// In shaders, color is represented with vec4s. Float arrays
// make it easy to pass colors from Java into the shader.
float[] targetStartClr = { 0.4, 0.4, 0.4, 1.0 };
float[] targetStopClr = { 0.85, 0.85, 0.85, 1.0 };
float[] currentStartClr = targetStartClr; // Current color being lerped
float[] currentStopClr = targetStopClr; // Current color being lerped

float quantity = 0.15;
float tiles = 5;
PShader bkgShdr;
float w = 0;
float h = 0;
float tx = 0;
float ty = 0;

void setupBackground() {
  rectMode(RADIUS);
  ellipseMode(RADIUS);

  // Set tile dimensions from sketch dimensions.
  w = width;
  h = height;
  tx = w > h ? tiles : tiles * w / h;
  ty = w > h ? tiles * h / w : tiles;

  // Load shader, set properties.
  bkgShdr = loadShader("frag.glsl", "vert.glsl");
  bkgShdr.set("tiles", tx, ty);
  bkgShdr.set("dimensions", w, h);
  bkgShdr.set("center", 0.5, 0.5);
  bkgShdr.set("quant", quantity);
  bkgShdr.set("start", targetStartClr, 4);
  bkgShdr.set("stop", targetStopClr, 4);
}

void drawBackground() {
  if (currentStartClr != targetStartClr || currentStopClr != targetStopClr) {
    currentStartClr = lerpColor(currentStartClr, targetStartClr, 0.006);
    currentStopClr = lerpColor(currentStopClr, targetStopClr, 0.006);
  }

  // Update uniforms.
  float time = (frameCount) * 0.003;
  //float scrollDamping = map(mouseX, 0, width, -0.01, 0.01);
  bkgShdr.set("time", time);
  bkgShdr.set("start", currentStartClr, 4);
  bkgShdr.set("stop", currentStopClr, 4);
  //bkgShdr.set("scrollDamping", scrollDamping);

  // Display shader background on a rect.
  shader(bkgShdr);
  rect(0.0, 0.0, width, height);

  // Reset to default shader.
  resetShader(TRIANGLES);
}

float[] lerpColor(float[] startColor, float[] stopColor, float progress) {
  float[] lerpedColor = new float[4];
  for (int i = 0; i < 4; i++) {
    lerpedColor[i] = lerp(startColor[i], stopColor[i], progress);
  }
  return lerpedColor;
}
