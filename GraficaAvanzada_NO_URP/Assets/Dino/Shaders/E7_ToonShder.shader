Shader "Custom/CelShading_Dino"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        _RampTexture ("Ramp Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _OutlineWidth ("Outline Width", Range(0, 20)) = 10
        
        
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

        sampler2D _MainTex;
        sampler2D _RampTexture;
        fixed4 _Color;
        fixed4 _OutlineColor;
        half _OutlineWidth;
        
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float3 dirCamera = normalize(_WorldSpaceCameraPos - IN.worldPos);
            float Ndoth = max(0, dot(o.Normal, dirCamera));
            float rampValue = tex2D(_RampTexture, float2(Ndoth, 0.5)).r;
            float outline = 1 - smoothstep(0, _OutlineWidth, Ndoth);
            
            o.Emission = _OutlineColor.rgb * outline;
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * rampValue;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
