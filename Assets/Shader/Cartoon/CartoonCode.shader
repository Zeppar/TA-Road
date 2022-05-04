Shader "Unlit/CartoonCode"
{
    Properties
    {
        _RampTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };

            sampler2D _RampTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 nDir = normalize(i.worldNormal);
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float nDotl = 0.5 + dot(nDir, lDir) * 0.5;
                fixed4 color = tex2D(_RampTex, float2(nDotl, 0.2));
                return color;
            }
            ENDCG
        }
    }
}
