Shader "Playground/ColorInterpolation" {
	
	Properties
	{
		_ColorA("Color A", Color) = (1,0,0,1)
		_ColorB("Color B", Color) = (0,1,0,1)
	}

		SubShader{
			Pass
	{	
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		
		float4 _ColorA;
	float4 _ColorB;
	struct vertInput {
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	
	};
	struct vertOutput {
		float4 pos : SV_POSITION;
		float2 uv : TEXCOORD0;
	};

	vertOutput vert(vertInput input) {
		vertOutput o;
		o.pos = UnityObjectToClipPos(input.pos);
		o.uv = input.uv;
		return o;
	}

	float Lerp(float a, float b, float t) {
		float finalValue = (1 - t) * a + t * b;
		return finalValue;
	}

	float4 LerpRGB(float4 a, float4 b, float t) {
		float4 finalColor = float4(Lerp(a.r,b.r,t), Lerp(a.g, b.g, t), Lerp(a.b, b.b, t), Lerp(a.a, b.a, t));
		return finalColor;
	}

	float4 frag(vertOutput output) : COLOR{
		float4 color = LerpRGB(_ColorA,_ColorB, Lerp(output.uv.x, output.uv.y, output.uv.x));
		return color;
	}

		ENDCG
	}
	
	}
}

