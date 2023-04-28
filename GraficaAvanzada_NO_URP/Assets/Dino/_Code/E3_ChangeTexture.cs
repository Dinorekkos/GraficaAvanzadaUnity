using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class E3_ChangeTexture : MonoBehaviour
{
    [SerializeField] private Texture texture1; 
    [SerializeField] private Texture texture2; 
    [SerializeField] private MeshRenderer meshRenderer;

    
    void Start()
    {
        
    }
    
    
    
    private float _time;

    void Update()
    {
        Mathf.Sin(_time += Time.deltaTime);
        if (_time > 1)
        {
            _time = 0;
            ChangeTexture();
        }
    }
    
    void ChangeTexture()
    {
        Texture newTexture = meshRenderer.material.GetTexture("_MainTex") == texture1 ? texture2 : texture1;
        meshRenderer.material.SetTexture("_MainTex", newTexture);
    }
    
}
