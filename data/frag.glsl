precision mediump float;
precision mediump int;

// Set in Processing sketch.
uniform float time;
uniform vec2 dimensions;
uniform vec2 center;
uniform float quant;
uniform vec2 tiles;
uniform vec4 start;
uniform vec4 stop;
uniform float scrollDamping;

// This will be set in the vertex shader and passed
// to the fragment shader.
varying vec4 vertTexCoord;

// Transparent black. Order: RGBA.
const vec4 clear = vec4(0.0, 0.0, 0.0, 0.0);

// When c == 2, Minkowksi distance is Euclidean;
// when c == 1, Minkowski is Manhattan.
float minkowski(vec2 a, vec2 b, float c) {
  vec2 d = pow(abs(a - b), vec2(c, c));
  return pow(d.x + d.y, 1.0 / c);
}

// Quantize a color.
vec4 quantize(vec4 v, float delta) {
  return floor((v / delta) + 0.5) * delta;
}

// Allow the pattern to be repeated by taking
// the fractional portion of the product between
// the position in range [0, 1] and tile count.
vec2 tile(vec2 a, vec2 b) {
  return fract(a * b);
}

// Lower-bounds inclusive (>=), upper-bounds exclusive
// (<). If value is in-bounds, return the value,
// otherwise return 0.
float inbounds(float v, float lb, float ub) {
  return v >= lb && v < ub ? v : 0.0;
}

void main() {

  // Slow down scroll-speed (without slowing oscillation)
  // by multiplying it against a damping value.
  vec2 scroll = time * -0.009 * (tiles);

  // Convert fragCoord from pixel dimensions to [0, 1]
  // by dividing sketch dimensions, then add scroll.
  // fragCoord is a vec4, not a vec2.
  vec2 pos = scroll + (gl_FragCoord.xy / dimensions);

  // Repeat the pattern by tiling the position.
  vec2 tile = tile(pos, tiles);

  // Shift cosine from the range [-1, 1] to [0, 1].
  float osc = 0.2 + cos(time * 0.4) * 0.08;

  // The value passed to the Minkowski distance
  // will oscillate between 0.6 and 4.0, meaning
  // between a polar star and rounded square form.
  float delta = mix(0.6, 4.0, osc);

  // Find Minkowski distance from tile to center.
  float dist = minkowski(tile, center, delta);

  // Keep dist in the range [0, 1] with floor mod.
  float t = mod(dist, 1.0);

  // Linear interpolation of colors by step t in RGB.
  vec4 clr = mix(start, stop, t);

  // With transparency mixed in.
  vec4 alclr = mix(clr, clear, inbounds(t, 0.1, 0.9));

  // Reduce color from smooth gradient to band.
  gl_FragColor = quantize(alclr, quant);
}