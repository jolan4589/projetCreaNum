color  TL, BL, TR, BR, bc;
int  nbX, nbY;
float  prctRect;
float  prctCircle;


void setup() {
  fullScreen();
  //size(800, 800);
  colorMode(HSB, 100);
  rectMode(CENTER);

  bc = color(random(100), random(100), random(20, 100));
  prctRect = random(0.2, 0.7);
  TL = color(random(100), random(100), random(20, 100));
  BL = color(random(100), random(100), random(20, 100));
  TR = color(random(100), random(100), random(20, 100));
  BR = color(random(100), random(100), random(20, 100));
  nbX = (int) random(100);
  nbY = (int) random(100);
  strokeWeight(1);

  smooth();
  frameRate(1);
  circleOnRect();
}

color  interpolColor(color c1, color c2, float prct) {
  float H, S, B;

  H = lerp(hue(c1), hue(c2), prct);
  S = lerp(saturation(c1), saturation(c2), prct);
  B = lerp(brightness(c1), brightness(c2), prct);
  return (color(H, S, B));
}

color  getColor4Location(float X, float Y) {
  float prctX = X / width, prctY = Y / height;

  return (interpolColor(interpolColor(TL, BL, prctY), interpolColor(TR, BR, prctY), prctX));
}

void draw() {
  bc = color(random(100), random(100), random(20, 100));
  prctRect = random(0.2, 0.7);
  TL = color(random(100), random(100), random(20, 100));
  BL = color(random(100), random(100), random(20, 100));
  TR = color(random(100), random(100), random(20, 100));
  BR = color(random(100), random(100), random(20, 100));
  nbX = (int) random(100);
  nbY = (int) random(100);
  background(bc);

  circleOnRect();
}

void circleOnRect() {
  float sizeX = width / (float) nbX, sizeY = height / (float) nbY;

  for (int i = 0; i < nbX; i++) {
    float posX = i * sizeX + sizeX / 2;
    for (int j = 0; j < nbY; j++) {
      float posY = j * sizeY + sizeY / 2;
      color c = getColor4Location(posX, posY);
      fill(c);
      rect(posX, posY, sizeX, sizeY);
      fill(color((hue(c) + 50) % 100, saturation(c), brightness(c)) );
      circle(posX, posY, min(sizeX, sizeY) * prctRect);
    }
  }
}
