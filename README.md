# OpenGL Shaders

Loosely, a shader is a program that runs on your GPU that is used to determine
what colour a certain pixel on screen should be. We're going to aim to right
shaders to generate pictures and animations. For some examples, go to
[Shadertoy][]. Once you've figured out the basics of how to write a shader, the
goals this evening are going to be:

* Shortest shader to draw the [CompSoc logo's sixteen dots][logo]
* A shader that can do an animation with the CompSoc logo
* Shortest shader that can draw something that the committee can recognise as a human face...
* A "3D" cube, possibly with animation

Solutions will go in this repository!

## Mathematical description

A shader is a function `shader : [0, 1]^2 -> [0,1]^4` where the input vector is
the coordinate (with `0,0` in the bottom left and `1,1` in the top right).
Here's a really simple shader:

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // fragCoord is in screen space, we need resolution independence
	vec2 xy = fragCoord.xy / iResolution.xy;
	fragColor.rg = xy;
    fragColor.b = 0.0;
}
```

`fragCoord` corresponds to the output vector, and you can access its fields via
`.x, .y, .z, .w` instead. You can paste the above into Shadertoy and press 'Run'
(at the bottom of the editor) to view the gradient.

Here is an example of a circle inscribed in a square:

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 xy = fragCoord.xy / iResolution.xy;
    float ratio = iResolution.y / iResolution.x;
    if (xy.x <= ratio) {
        xy.x = xy.x / ratio;
        // Now [x,y] in [0,1] * [0,1]
        vec2 center = vec2(0.5, 0.5);
        // Check if point is in circle
        if (length(center - xy) <= 0.4) {
            fragColor = vec4(192.0 / 255.0, 214.0 / 255.0, 224.0 / 255.0, 1.0);
        }
        else {
            fragColor = vec4(1.0, 1.0, 1.0, 1.0);
        }
    }
    else {
        fragColor = vec4(0,0,0,0);
    }
}
```

[shadertoy]: http://shadertoy.com
[logo]: https://ox.compsoc.net/images/compsoc/banner.png
