using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class FloatAndRotate : MonoBehaviour
{
    public float floatAmplitude = 0.5f;
    public float floatSpeed = 1f;
    public bool randomizeStartFloatProgression = true;
    private float startFloatProgression = 0f;
    private float startY;

    public float maxRotationSpeed = 1f;
    private float rotationSpeed;
    public Space rotateWorldOrLocalSpace = Space.World;
    public bool randomizeInitialRotationProgression = true;
    public bool rotateX = false;
    public bool rotateY = true;
    public bool rotateZ = false;


    void Start()
    {
        startY = transform.localPosition.y;
        RandomizeInitialFloatProgression();
        RandomizeRotationSpeed();
        RandomizeInitialRotationProgession();
    }

    void Update()
    {
        Float();
        Rotate();
    }
    void RandomizeInitialFloatProgression()
    {
        if (randomizeStartFloatProgression)
        {
            startFloatProgression = Random.Range(-1f, 1f);

            transform.localPosition =
                new Vector3(transform.localPosition.x,
                            startY + floatAmplitude * Mathf.Sin((Time.time + startFloatProgression) * floatSpeed),
                            transform.localPosition.z);
        }
    }

    void Float()
    {
        transform.localPosition =
        new Vector3(transform.localPosition.x,
                    startY + floatAmplitude * Mathf.Sin((Time.time + startFloatProgression) * floatSpeed),
                    transform.localPosition.z);
    }
    void RandomizeRotationSpeed()
    {
        rotationSpeed = Random.Range(-maxRotationSpeed, maxRotationSpeed);
    }
    void RandomizeInitialRotationProgession()
    {
        Vector3 rotateAmount = new Vector3(0f, 0f, 0f);

        if (rotateX)
        {
            rotateAmount.x = Random.Range(0f, 360f);
        }
        if (rotateY)
        {
            rotateAmount.y = Random.Range(0f, 360f);
        }
        if (rotateZ)
        {
            rotateAmount.z = Random.Range(0f, 360f);
        }

        transform.Rotate(rotateAmount);
    }
    void Rotate()
    {
        float rotateAmount = rotationSpeed * Time.deltaTime;

        if (rotateX)
        {
            transform.Rotate(new Vector3(rotateAmount, 0f, 0f), rotateWorldOrLocalSpace);
        }
        if (rotateY)
        {
            transform.Rotate(new Vector3(0f, rotateAmount, 0f), rotateWorldOrLocalSpace);
        }
        if (rotateZ)
        {
            transform.Rotate(new Vector3(0f, 0f, rotateAmount), rotateWorldOrLocalSpace);
        }
    }
}
