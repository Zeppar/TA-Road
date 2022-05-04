Shader "Unlit/HalfLambertCode"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

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
                return fixed4(nDotl, nDotl, nDotl, 1.0);
            }
            ENDCG
        }
    }
}
