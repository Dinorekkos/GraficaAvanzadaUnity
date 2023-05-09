Shader "Custom/CelShading" {
    Properties {
        _MainTexture ("Base Texture", 2D) = "white" {}
        _TextureRamp ("Texture Ramp", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _OutlineWidth ("Outline Width", Range(0,0.1)) = 0.01
    }
    SubShader {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100

        CGPROGRAM
        #pragma surface surf Standard vertex:vert
            #pragma target 3.0

        sampler2D _MainTexture;
        sampler2D _TextureRamp;
        float4 _OutlineColor;
        float _OutlineWidth;

        struct Input {
            float2 uv_MainTexture;
            float3 worldPos;
            float3 worldNormal;
            float3 worldTangent;
            float3 worldBinormal;
            INTERNAL_DATA
        };

        void vert(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            o.worldNormal = UnityObjectToWorldNormal(v.normal);
        }

        void surf (Input IN, inout SurfaceOutputStandard o) {
            // Calcula el color difuso basado en las texturas de base y de rampa
            float4 tex = tex2D(_MainTexture, IN.uv_MainTexture);
            float4 ramp = tex2D(_TextureRamp, float2(dot(IN.worldNormal, _WorldSpaceLightPos0.xyz), 0));
            float rampValue = ramp.r;
            float4 diffuse = tex * rampValue;

            // Calcula el contorno
            float3 outline = fwidth(IN.worldPos);
            outline = outline * _OutlineWidth;

            // Establece la salida del shader
            o.Albedo = diffuse.rgb;
            o.Metallic = 0;
            o.Smoothness = 1;
            o.Normal = normalize(IN.worldNormal);
            o.Emission = _OutlineColor.rgb * outline;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
