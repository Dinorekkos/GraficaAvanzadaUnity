Shader "Custom/E8_Specular"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SpecularTex ("Specular (RGB)", 2D) = "white" {}
        _Intensity ("Intensity", Range(0,1)) = 0.5
        _LightPos ("Light Position", Vector) = (0,0,0,0)
        _Shininess ("Shininess", Range(0,1)) = 0.5
        _SpecularFactor ("Specular Factor", Range(0,1)) = 0.5
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
        
        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };
        

        //Dino
        sampler2D _MainTex;
        float _Intensity;
        float3 _LightPos;
        float _Shininess;
        float _SpecularFactor;
        sampler2D _SpecularTex;
        

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            
            //Revisar
            float3 halfDir = normalize(_LightPos - IN.worldPos + _WorldSpaceCameraPos - IN.worldPos);
            float Ndoth =  max(0,dot(o.Normal,halfDir));
            _Intensity = pow(Ndoth, _Shininess);

            o.Emission = _SpecularFactor * _Intensity * tex2D(_SpecularTex, IN.uv_MainTex).rgb;
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            
            

            

            
        }   
        ENDCG
    }
    FallBack "Diffuse"
}
