// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Artificial Illusions/EnvironmentLights"
{
	Properties
	{
		_LightTexture("LightTexture", 2D) = "white" {}
		_LightTexture1("LightTexture", 2D) = "white" {}
		_LightTexture2("LightTexture2", 2D) = "white" {}
		_EmissionTint("Emission Tint", Color) = (1,1,1,0)
		_EmissionPower("Emission Power", Float) = 0
		_AnimationSpeed("Animation Speed", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _EmissionTint;
		uniform sampler2D _LightTexture;
		uniform float _AnimationSpeed;
		uniform sampler2D _LightTexture1;
		uniform float4 _LightTexture1_ST;
		uniform sampler2D _LightTexture2;
		uniform float4 _LightTexture2_ST;
		uniform float _EmissionPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_AnimationSpeed).xx;
			float2 uv_TexCoord14 = i.uv_texcoord * float2( 0,-1 );
			float2 panner2 = ( 1.0 * _Time.y * temp_cast_0 + uv_TexCoord14);
			float2 uv_LightTexture1 = i.uv_texcoord * _LightTexture1_ST.xy + _LightTexture1_ST.zw;
			float2 uv_LightTexture2 = i.uv_texcoord * _LightTexture2_ST.xy + _LightTexture2_ST.zw;
			float4 Emission25 = ( ( _EmissionTint * ( ( tex2D( _LightTexture, panner2 ) * tex2D( _LightTexture1, uv_LightTexture1 ) ) * tex2D( _LightTexture2, uv_LightTexture2 ) ) ) * _EmissionPower );
			o.Emission = Emission25.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
0;288;1916;740;2689.337;213.574;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2256.613,-148.8159;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0,-1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;-2226.914,16.79613;Inherit;False;Property;_AnimationSpeed;Animation Speed;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;2;-1885.134,-16.86569;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;30;-1589.515,160;Inherit;True;Property;_LightTexture1;LightTexture;1;0;Create;True;0;0;False;0;-1;61c0b9c0523734e0e91bc6043c72a490;3310bb70c741cb3499a730705c362fdf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1611.26,-66.20027;Inherit;True;Property;_LightTexture;LightTexture;0;0;Create;True;0;0;False;0;-1;1b4fa38cd4688f2419b18988b33af31a;3310bb70c741cb3499a730705c362fdf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1080.055,109.2366;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;32;-1303.636,294.8206;Inherit;True;Property;_LightTexture2;LightTexture2;2;0;Create;True;0;0;False;0;-1;61c0b9c0523734e0e91bc6043c72a490;5798ded558355430c8a9b13ee12a847c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-835.6561,-144.6053;Inherit;False;Property;_EmissionTint;Emission Tint;4;0;Create;True;0;0;False;0;1,1,1,0;1,0.3752397,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-973.9961,257.1323;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-557.0443,10.27;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-563.7311,144.0073;Inherit;False;Property;_EmissionPower;Emission Power;5;0;Create;True;0;0;False;0;0;10.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-351.4229,127.2901;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-86.26891,116.7651;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-2271.954,242.9301;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;1;[HideInInspector];Create;True;0;0;False;0;-1;1b4fa38cd4688f2419b18988b33af31a;1b4fa38cd4688f2419b18988b33af31a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1848.025,335.7939;Inherit;False;GeoMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;445.89,55.94511;Inherit;False;25;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-533.4948,340.4507;Inherit;False;17;GeoMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;734.5787,-83.23813;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Artificial Illusions/EnvironmentLights;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;14;0
WireConnection;2;2;34;0
WireConnection;1;1;2;0
WireConnection;31;0;1;0
WireConnection;31;1;30;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;28;0;27;0
WireConnection;28;1;33;0
WireConnection;29;0;28;0
WireConnection;29;1;26;0
WireConnection;25;0;29;0
WireConnection;17;0;8;4
WireConnection;0;2;19;0
ASEEND*/
//CHKSM=6B7AD1CB25807943257E9CC10B9D207579FC1277