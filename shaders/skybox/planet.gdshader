shader_type spatial;
render_mode blend_mix, depth_draw_opaque, depth_test_default, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec4 light : source_color;
uniform float light_power;
uniform float light_str;

uniform float fresnel_str;
uniform float rim_pow;
uniform vec4 rim_color : source_color;
uniform float rim_color_str;
uniform float rim_ems_str;
uniform float rim_ems_pow;

uniform float rim_ems_str2;
uniform float rim_ems_pow2;
uniform vec4 rim_color2 : source_color;
uniform float rim_color_str2;

uniform float mix_rou;
uniform float max_rou;
uniform sampler2D tex_frg_2;
uniform sampler2D tex_frg_4;

uniform float city_dark;
uniform float city_light;
uniform sampler2D tex_frg_72;

uniform float Cloud;
uniform float Cloud_speed;
uniform vec4 Cloud_color : source_color;
uniform sampler2D tex_frg_51;
uniform sampler2D tex_frg_3;

uniform sampler2D tex_frg_10 : hint_normal;
uniform float CloudNormal_scale;
uniform sampler2D tex_frg_11 : hint_normal;
uniform float plane_Normal_Scale;

uniform float ems_str;
void fragment() {
// ColorParameter:40
	vec4 n_out40p0 = light;


// Input:28
	vec3 n_out28p0 = NORMAL;


// DotProduct:29
	float n_out29p0 = dot(vec3(n_out40p0.xyz), n_out28p0);


// FloatParameter:31
	float n_out31p0 = light_power;


// VectorOp:93
	vec3 n_out93p0 = pow(vec3(n_out29p0), vec3(n_out31p0));


// FloatParameter:33
	float n_out33p0 = light_str;


// VectorOp:94
	vec3 n_out94p0 = n_out93p0 * vec3(n_out33p0);


// Clamp:95
	vec3 n_in95p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_in95p2 = vec3(1.00000, 1.00000, 1.00000);
	vec3 n_out95p0 = clamp(n_out94p0, n_in95p1, n_in95p2);


// FloatParameter:36
	float n_out36p0 = fresnel_str;


// Fresnel:35
	float n_out35p0 = pow(clamp(dot(NORMAL, VIEW), 0.0, 1.0), n_out36p0);


// FloatParameter:38
	float n_out38p0 = rim_pow;


// FloatOp:37
	float n_out37p0 = pow(n_out35p0, n_out38p0);


// VectorOp:97
	vec3 n_out97p0 = n_out95p0 * vec3(n_out37p0);


// FloatParameter:8
	float n_out8p0 = mix_rou;


// FloatParameter:9
	float n_out9p0 = max_rou;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, UV);
	float n_out2p1 = n_out2p0.r;


// Texture2D:4
	vec4 n_out4p0 = texture(tex_frg_4, UV);
	float n_out4p1 = n_out4p0.r;


// FloatOp:5
	float n_out5p0 = n_out2p1 + n_out4p1;


// Clamp:6
	float n_in6p1 = 0.00000;
	float n_in6p2 = 1.00000;
	float n_out6p0 = clamp(n_out5p0, n_in6p1, n_in6p2);


// Mix:7
	float n_out7p0 = mix(n_out8p0, n_out9p0, n_out6p0);


// FloatParameter:98
	float n_out98p0 = city_dark;


// Texture2D:72
	vec4 n_out72p0 = texture(tex_frg_72, UV);


// FloatParameter:74
	float n_out74p0 = city_light;


// VectorOp:89
	vec3 n_out89p0 = vec3(n_out72p0.xyz) * vec3(n_out74p0);


// VectorFunc:96
	vec3 n_out96p0 = vec3(1.0) - n_out95p0;


// VectorOp:90
	vec3 n_out90p0 = n_out89p0 * n_out96p0;


// FloatParameter:42
	float n_out42p0 = rim_ems_str;


// Fresnel:41
	float n_out41p0 = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), n_out42p0);


// FloatParameter:44
	float n_out44p0 = rim_ems_pow;


// FloatOp:43
	float n_out43p0 = pow(n_out41p0, n_out44p0);


// ColorParameter:45
	vec4 n_out45p0 = rim_color;


// FloatParameter:46
	float n_out46p0 = rim_color_str;


// VectorOp:79
	vec3 n_out79p0 = vec3(n_out45p0.xyz) * vec3(n_out46p0);


// VectorOp:80
	vec3 n_out80p0 = vec3(n_out43p0) * n_out79p0;


// VectorOp:81
	vec3 n_out81p0 = n_out80p0 * vec3(n_out29p0);


// Clamp:50
	vec3 n_in50p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_in50p2 = vec3(1.00000, 1.00000, 1.00000);
	vec3 n_out50p0 = clamp(n_out81p0, n_in50p1, n_in50p2);


// Texture2D:3
	vec4 n_out3p0 = texture(tex_frg_3, UV);


// Input:13
	float n_out13p0 = TIME;


// FloatParameter:15
	float n_out15p0 = Cloud_speed;


// FloatOp:14
	float n_out14p0 = n_out13p0 * n_out15p0;


// VectorDecompose:102
	float n_out102p0 = vec2(n_out14p0).x;
	float n_out102p1 = vec2(n_out14p0).y;


// VectorCompose:103
	float n_in103p1 = 0.00000;
	vec2 n_out103p0 = vec2(n_out102p0, n_in103p1);


// UVFunc:12
	vec2 n_in12p1 = vec2(1.00000, 1.00000);
	vec2 n_out12p0 = n_out103p0 * n_in12p1 + UV;


// Texture2D:51
	vec4 n_out51p0 = texture(tex_frg_51, n_out12p0);


// ColorParameter:53
	vec4 n_out53p0 = Cloud_color;


// VectorOp:52
	vec3 n_out52p0 = vec3(n_out51p0.xyz) * vec3(n_out53p0.xyz);


// FloatParameter:101
	float n_out101p0 = Cloud;


// VectorOp:54
	vec3 n_out54p0 = n_out52p0 * vec3(n_out101p0);


// VectorOp:56
	vec3 n_out56p0 = vec3(n_out3p0.xyz) + n_out54p0;


// FloatParameter:58
	float n_out58p0 = ems_str;


// VectorOp:82
	vec3 n_out82p0 = n_out56p0 * vec3(n_out58p0);


// FloatParameter:60
	float n_out60p0 = rim_ems_str2;


// Fresnel:61
	float n_out61p0 = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), n_out60p0);


// FloatParameter:59
	float n_out59p0 = rim_ems_pow2;


// FloatOp:63
	float n_out63p0 = pow(n_out61p0, n_out59p0);


// ColorParameter:66
	vec4 n_out66p0 = rim_color2;


// FloatParameter:62
	float n_out62p0 = rim_color_str2;


// VectorOp:83
	vec3 n_out83p0 = vec3(n_out66p0.xyz) * vec3(n_out62p0);


// VectorOp:84
	vec3 n_out84p0 = vec3(n_out63p0) * n_out83p0;


// Clamp:67
	vec3 n_in67p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_in67p2 = vec3(1.00000, 1.00000, 1.00000);
	vec3 n_out67p0 = clamp(vec3(n_out29p0), n_in67p1, n_in67p2);


// VectorOp:85
	vec3 n_out85p0 = n_out84p0 * n_out67p0;


// VectorOp:88
	vec3 n_out88p0 = n_out85p0 + n_out67p0;


// VectorOp:86
	vec3 n_out86p0 = n_out82p0 * n_out88p0;


// VectorOp:87
	vec3 n_out87p0 = n_out50p0 + n_out86p0;


// VectorOp:91
	vec3 n_out91p0 = n_out90p0 + n_out87p0;


// Mix:92
	vec3 n_out92p0 = mix(vec3(n_out98p0), n_out91p0, n_out88p0);


// Texture2D:10
	vec4 n_out10p0 = texture(tex_frg_10, n_out12p0);


// FloatParameter:99
	float n_out99p0 = CloudNormal_scale;


// VectorOp:16
	vec3 n_out16p0 = vec3(n_out10p0.xyz) * vec3(n_out99p0);


// VectorDecompose:21
	float n_out21p0 = n_out16p0.x;
	float n_out21p1 = n_out16p0.y;
	float n_out21p2 = n_out16p0.z;


// Texture2D:11
	vec4 n_out11p0 = texture(tex_frg_11, UV);


// FloatParameter:100
	float n_out100p0 = plane_Normal_Scale;


// VectorOp:18
	vec3 n_out18p0 = vec3(n_out11p0.xyz) * vec3(n_out100p0);


// VectorDecompose:20
	float n_out20p0 = n_out18p0.x;
	float n_out20p1 = n_out18p0.y;
	float n_out20p2 = n_out18p0.z;


// FloatOp:22
	float n_out22p0 = n_out21p0 + n_out20p0;


// FloatOp:23
	float n_out23p0 = n_out21p1 + n_out20p1;


// FloatOp:24
	float n_out24p0 = n_out21p2 * n_out20p2;


// VectorCompose:25
	vec3 n_out25p0 = vec3(n_out22p0, n_out23p0, n_out24p0);


// VectorFunc:26
	vec3 n_out26p0 = normalize(n_out25p0);


// Output:0
	ALPHA = n_out97p0.x;
	ROUGHNESS = n_out7p0;
	EMISSION = n_out92p0;
	NORMAL_MAP = n_out26p0;


}
