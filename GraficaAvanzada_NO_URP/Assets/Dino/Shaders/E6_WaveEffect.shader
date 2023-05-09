Shader "Unlit/E6_WaveEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WaveHeight ("Wave Height", Range(0, 1)) = 0.2
        _WaveSpeed ("Wave Speed", Range(0, 5)) = 0.5
        _Amplitude ("Amplitude", Range(0, 10)) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
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

            float _WaveHeight;
            float _WaveSpeed;
            float _Amplitude;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;

                float2 offset = float2(
                   sin(uv.y * _Amplitude + _Time.y * _WaveSpeed) * _WaveHeight,
                   sin(uv.x * _Amplitude + _Time.x * _WaveSpeed) * _WaveHeight
                );

                uv += offset;
                fixed4 col = tex2D(_MainTex, uv);
                return col;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
