void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 xy = fragCoord.xy / iResolution.xy;
    float ratio = iResolution.y / iResolution.x;
    if (xy.x <= ratio) {
        xy.x = xy.x / ratio;
        // Now [x,y] in [0,1] * [0,1]
        
        float x = floor(xy.x * 4.0);
  		float y = floor(xy.y * 4.0);
        float coord = y * 4.0 + x;
        vec2 center = vec2(0.125 + 0.25 * floor(xy.x * 4.0), 0.125 + 0.25 * floor(xy.y * 4.0));
        float radius = 1.5 / 17.0;
        float inRadius = clamp(length(xy - center) / radius, 0.0, 1.0);
        vec4 c = vec4(1.0, 1.0, 1.0, 1.0);
        if (length(xy - center) < radius) {
        	c = vec4(192.0 / 255.0, 214.0 / 255.0, 224.0 / 255.0, 1.0);
        	if (x == 1.0 || coord == 2.0 || coord == 8.0 || coord == 10.0 || coord == 15.0) {
        		c = vec4(32.0 / 255.0, 74.0 / 255.0, 135.0 / 255.0, 1.0);
        	}
        	float f = 0.0;
        	if (inRadius > 0.95) {
            	f = (inRadius - 0.95) / 0.05;
        	}
        	fragColor = mix(c, vec4(1.0, 1.0, 1.0, 1.0), f);
        }
        else {
            fragColor = vec4(1.0, 1.0, 1.0, 1.0);
        }
    }
    else {
        fragColor = vec4(0,0,0,0);
    }
}
