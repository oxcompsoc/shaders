const int ox = 0x4F58;
const int cs = 0x4353;
const vec3 light_blue = vec3(0.8, 0.84, 0.88);
//const vec3 inv_lb = 1.0 - light_blue;
const vec3 dark_blue = vec3(0.13, 0.3, 0.53);
//const vec3 inv_db = 1.0 - dark_blue;
const vec4 white = vec4(1.0, 1.0, 1.0, 1.0);

/**
 * Draw a circle at vec2 `pos` with radius `rad` and
 * color `color`.
 */
vec4 circle(vec2 uv, vec2 pos, float rad, vec3 color) {
	float d = length(pos - uv) - rad;
	float t = clamp(d, 0.0, 1.0);
	return vec4(color, 1.0 - t);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float ssize = min(iResolution.x, iResolution.y) / 4.0;
    vec2 a = vec2(fragCoord.x, ssize * 4.0 - fragCoord.y);
	vec2 gloc = floor(a.xy / ssize);
	vec2 rloc = mod(a.xy, ssize);

	int pos = int(floor(gloc.y + 4.0*gloc.x + 0.5));
    float dist = length(rloc - vec2(ssize/2.0, ssize/2.0));

    if (gloc.x < 4.0) {
        vec3 oxcolor, cscolor;    
        if (pos == 1 || pos / 4 == 1 || pos == 9 || pos == 11 || pos == 12) {
            oxcolor = dark_blue;
        } else {
            oxcolor = light_blue;
        }
        
        if (pos == 1 || pos == 6 || pos == 7 || pos == 9 || pos == 11 || pos == 14 || pos == 15) {
            cscolor = dark_blue;
        } else {
            cscolor = light_blue;
        }

        vec4 ox_circle_layer = circle(rloc, vec2(ssize/2.0, ssize/2.0), ssize/3.0, oxcolor);
        vec4 cs_circle_layer = circle(rloc, vec2(ssize/2.0, ssize/2.0), ssize/3.0, cscolor);

        vec4 oxpart = mix(white, ox_circle_layer, ox_circle_layer.a);
        vec4 cspart = mix(white, cs_circle_layer, cs_circle_layer.a);
        fragColor = mix(oxpart, cspart, abs(sin(iGlobalTime/3.0)));
    } else {
        fragColor = vec4(0.0);
    }
}

