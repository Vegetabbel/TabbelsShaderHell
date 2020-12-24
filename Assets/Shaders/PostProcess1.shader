Shader "Tabbel's/PostProcess1"
{
    Properties
    {  
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {               
                fixed4 col = tex2D(_MainTex, i.uv + float2(0, sin(i.vertex.x/-50 + _Time[1] / 2) / 80));

                //fixed4 col = tex2D  (_MainTex, i.uv / abs(sin(_Time[1] + 1)));
                //col = half4(col.r * 0.5f, col.g * 0.75f, col.b * 0.75f, col.a);

                return col;
            }
            ENDCG
        }
    }
}
