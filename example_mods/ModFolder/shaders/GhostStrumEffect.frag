#pragma header

uniform float progress;
void main() {
    vec2 uv = openfl_TextureCoordv;
	uv *= 1.05;
	//uv.x += /*sin(uv.y*(3.14159/2.0)-progress)*0.1 +*/;
    /*float c = 1.0, s = cos(uv.y*3.14159)*progress;
    uv *= mat2(
        vec2(1.0,-s/(openfl_TextureSize.x/openfl_TextureSize.y)),
        vec2(s/(openfl_TextureSize.y/openfl_TextureSize.x),1.0)
    );*/

	vec4 normal_map = flixel_texture2D(bitmap,uv);

	gl_FragColor = normal_map;
}