Shader "Unlit/Unlit3D1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Angle ("Angle", Float) = 10
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _Angle;

            v2f vert (appdata v)
            {
                v2f o;

                int directionMultiplier = 1;
                float timeSin = sin(_Time[1]);

                //_Angle = abs(timeSin) * _Angle;

                //if (timeSin < 0) directionMultiplier = -1;
                //else directionMultiplier = 1;
                
                //float dist = distance(float3(0,0,0), v.vertex.y);

                //v.vertex.y += dist;

                _Angle = _Angle * v.vertex.y;

                v.vertex.xz = float2(   v.vertex.x * cos(_Angle ) - v.vertex.z * sin(_Angle) * directionMultiplier,
                                        v.vertex.z * cos(_Angle) + v.vertex.x * sin(_Angle) * directionMultiplier
                                    );

                //v.vertex.y -= dist;


                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                col.a = 0.3f;
                return col;
            }
            ENDCG
        }
    }
}
