// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Artificial Illusions/Cyber Cube"
{
	Properties
	{
		_AlbedoTransparencyTexture("AlbedoTransparency Texture", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_EmissionTexture("Emission Texture", 2D) = "white" {}
		_HologramTexture("Hologram Texture", 2D) = "white" {}
		_HologramColor("Hologram Color", Color) = (0,0,0,0)
		_HologramEmissionPower("Hologram Emission Power", Range( 0 , 10)) = 0
		_AnimationSpeed("Animation Speed", Range( 0 , 2)) = 0
		_AnimationMap("Animation Map", 2D) = "white" {}
		[HideInInspector]_CubeFaces_Mask("CubeFaces_Mask", 2D) = "white" {}
		[HideInInspector]_CubeFrame_Mask("CubeFrame_Mask", 2D) = "white" {}
		_HologramOpacity("Hologram Opacity", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _AlbedoTransparencyTexture;
		uniform float4 _AlbedoTransparencyTexture_ST;
		uniform sampler2D _EmissionTexture;
		uniform float4 _EmissionTexture_ST;
		uniform sampler2D _CubeFrame_Mask;
		uniform float4 _CubeFrame_Mask_ST;
		uniform sampler2D _HologramTexture;
		uniform float4 _HologramTexture_ST;
		uniform sampler2D _CubeFaces_Mask;
		uniform float4 _CubeFaces_Mask_ST;
		uniform float4 _HologramColor;
		uniform float _HologramEmissionPower;
		uniform sampler2D _AnimationMap;
		uniform float _AnimationSpeed;
		uniform float _Metallic;
		uniform float _HologramOpacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_AlbedoTransparencyTexture = i.uv_texcoord * _AlbedoTransparencyTexture_ST.xy + _AlbedoTransparencyTexture_ST.zw;
			float4 Albedo36 = tex2D( _AlbedoTransparencyTexture, uv_AlbedoTransparencyTexture );
			o.Albedo = Albedo36.rgb;
			float2 uv_EmissionTexture = i.uv_texcoord * _EmissionTexture_ST.xy + _EmissionTexture_ST.zw;
			float2 uv_CubeFrame_Mask = i.uv_texcoord * _CubeFrame_Mask_ST.xy + _CubeFrame_Mask_ST.zw;
			float4 CubeFrame_MASK47 = tex2D( _CubeFrame_Mask, uv_CubeFrame_Mask );
			float2 uv_HologramTexture = i.uv_texcoord * _HologramTexture_ST.xy + _HologramTexture_ST.zw;
			float2 uv_CubeFaces_Mask = i.uv_texcoord * _CubeFaces_Mask_ST.xy + _CubeFaces_Mask_ST.zw;
			float4 CubeFaces_MASK46 = tex2D( _CubeFaces_Mask, uv_CubeFaces_Mask );
			float2 temp_cast_1 = (_AnimationSpeed).xx;
			float2 uv_TexCoord20 = i.uv_texcoord * float2( 0,-1 );
			float2 panner21 = ( 1.0 * _Time.y * temp_cast_1 + uv_TexCoord20);
			float4 PannerAnimation41 = tex2D( _AnimationMap, panner21 );
			float4 Emission13 = ( ( tex2D( _EmissionTexture, uv_EmissionTexture ) * CubeFrame_MASK47 ) + ( ( ( ( tex2D( _HologramTexture, uv_HologramTexture ) * CubeFaces_MASK46 ) * _HologramColor ) * _HologramEmissionPower ) * PannerAnimation41 ) );
			o.Emission = Emission13.rgb;
			float temp_output_10_0 = _Metallic;
			o.Metallic = temp_output_10_0;
			o.Smoothness = temp_output_10_0;
			o.Alpha = ( CubeFrame_MASK47 + ( CubeFaces_MASK46 * _HologramOpacity ) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2;622;1916;406;2395.282;-330.8241;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;50;-4145.54,474.9208;Inherit;False;645.5535;548.8762;Comment;4;28;46;32;47;MASKS;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;28;-4092.85,793.797;Inherit;True;Property;_CubeFaces_Mask;CubeFaces_Mask;7;1;[HideInInspector];Create;True;0;0;False;0;-1;8e1dae13bbee74d4caa7fc1041b7caf2;8e1dae13bbee74d4caa7fc1041b7caf2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;45;-2977.4,-438.0659;Inherit;False;1230.251;317.0379;;5;19;20;21;22;41;Panner Animation;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;62;-3224.318,773.8211;Inherit;False;1557.628;536.6068;Comment;9;16;43;25;26;12;49;11;15;42;Hologram;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-3762.987,877.756;Inherit;False;CubeFaces_MASK;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2927.4,-236.028;Inherit;False;Property;_AnimationSpeed;Animation Speed;5;0;Create;True;0;0;False;0;0;0.653;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-2921.88,-388.0659;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0,-1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;21;-2612.485,-350.3329;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;25;-3174.318,823.8211;Inherit;True;Property;_HologramTexture;Hologram Texture;2;0;Create;True;0;0;False;0;-1;None;567ff6f7d0426024f84540d8abcf14a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;49;-3142.79,1036.124;Inherit;False;46;CubeFaces_MASK;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-2695.897,972.2721;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;11;-2798.245,1103.428;Inherit;False;Property;_HologramColor;Hologram Color;3;0;Create;True;0;0;False;0;0,0,0,0;1,0.07093366,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;-2376.04,-381.0044;Inherit;True;Property;_AnimationMap;Animation Map;6;0;Create;True;0;0;False;0;-1;None;5a5b20f962bdb22428da08e032649287;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;32;-4095.54,524.9208;Inherit;True;Property;_CubeFrame_Mask;CubeFrame_Mask;8;1;[HideInInspector];Create;True;0;0;False;0;-1;ac4e9f5c12cd4be469aced9d58db11d6;ac4e9f5c12cd4be469aced9d58db11d6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-2486.566,1146.167;Inherit;False;Property;_HologramEmissionPower;Hologram Emission Power;4;0;Create;True;0;0;False;0;0;7.88;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2352.166,967.158;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2651.26,158.37;Inherit;False;572.8786;510.5785;;3;2;33;48;Cube Frame Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-3790.71,631.1445;Inherit;False;CubeFrame_MASK;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-2012.149,-375.4799;Inherit;False;PannerAnimation;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-2165.127,1063.249;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-2113.439,1186.669;Inherit;False;41;PannerAnimation;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-2599.284,210.37;Inherit;True;Property;_EmissionTexture;Emission Texture;1;0;Create;True;0;0;False;0;-1;None;d3cef658b924f44468cb20e1b8eeb26b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;48;-2573.913,530.0223;Inherit;False;47;CubeFrame_MASK;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1835.69,1063.433;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-2247.381,350.4263;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1676.046,629.5346;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-4097.674,-246.1199;Inherit;True;Property;_AlbedoTransparencyTexture;AlbedoTransparency Texture;0;0;Create;True;0;0;False;0;-1;None;3ed82142137daa345bcc1e46ef9e8de4;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1378.818,366.1578;Inherit;False;46;CubeFaces_MASK;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1368.189,495.4351;Inherit;False;Property;_HologramOpacity;Hologram Opacity;9;0;Create;True;0;0;False;0;1;0.86;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-3759.113,-245.9953;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;7;-1081.084,290.4453;Inherit;False;47;CubeFrame_MASK;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-1126.819,418.7102;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1514.713,626.1942;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-764.3695,303.0961;Inherit;False;Property;_Metallic;Metallic;0;0;Create;True;0;0;False;0;0;0.808;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;14;-712.5964,220.1943;Inherit;False;13;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-812.768,399.68;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;9;-706.3934,139.3798;Inherit;False;36;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-435.8085,133.8026;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Artificial Illusions/Cyber Cube;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;46;0;28;0
WireConnection;21;0;20;0
WireConnection;21;2;19;0
WireConnection;26;0;25;0
WireConnection;26;1;49;0
WireConnection;22;1;21;0
WireConnection;12;0;26;0
WireConnection;12;1;11;0
WireConnection;47;0;32;0
WireConnection;41;0;22;0
WireConnection;16;0;12;0
WireConnection;16;1;15;0
WireConnection;43;0;16;0
WireConnection;43;1;42;0
WireConnection;33;0;2;0
WireConnection;33;1;48;0
WireConnection;34;0;33;0
WireConnection;34;1;43;0
WireConnection;36;0;3;0
WireConnection;61;0;51;0
WireConnection;61;1;60;0
WireConnection;13;0;34;0
WireConnection;52;0;7;0
WireConnection;52;1;61;0
WireConnection;0;0;9;0
WireConnection;0;2;14;0
WireConnection;0;3;10;0
WireConnection;0;4;10;0
WireConnection;0;9;52;0
ASEEND*/
//CHKSM=5F6AADDC46D2A5EDCE7ABC2A73BF924F3765675A