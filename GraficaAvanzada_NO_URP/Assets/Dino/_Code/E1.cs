using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class E1 : MonoBehaviour
{
    [SerializeField] private Color color;
    [SerializeField] private MeshRenderer meshRenderer;

    public Color Color
    {
        get => color;
        set => color = value;
    }
    private float _time;

    void Update()
    {
        Mathf.Sin(_time += Time.deltaTime);
        if (_time > 1)
        {
            _time = 0;
            Color = GenerateColor();
            meshRenderer.material.SetColor("_Color", Color);
        }
    }
    
    private Color GenerateColor()
    {
       return Color = new Color(Random.Range(0f, 1f), Random.Range(0f, 1f), Random.Range(0f, 1f), 1);
    }

}
