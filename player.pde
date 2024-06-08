class Player {
  int x, y, size, health, speed;
  PImage sprite;
  float angle;

  Player(int startX, int startY) {
    x = startX;
    y = startY;
    size = 30;
    health = 100;
    speed = 5;
    keys = new boolean[5];
    angle = 0;
    sprite = loadImage("sprites/xwing.png");
    sprite.resize(size, size);
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle + HALF_PI); // Rotate so that the image faces upwards by default
    imageMode(CENTER); // Draw the image centered at the (0, 0) point
    image(sprite, 0, 0);
    popMatrix();
  }

  void updatePlayer() {
    if (millis() - lastS >= cooldownS) {
      if (keys[4]) {
        isS = true;
        lastS = millis();
      } else {
        isS = false;
      }
    }
    if (millis() - lastS >= durantionS) {
      isS = false;
    }
    int newSpeed = isS ? speed * 2 : speed;
    if (keys[0]) y = constrain(y - newSpeed, size / 2, MAPSIZE - size / 2);
    if (keys[1]) x = constrain(x - newSpeed, size / 2, MAPSIZE - size / 2);
    if (keys[2]) y = constrain(y + newSpeed, size / 2, MAPSIZE - size / 2);
    if (keys[3]) x = constrain(x + newSpeed, size / 2, MAPSIZE - size / 2);
    angle = atan2(mouseY - (y - CAMERAY), mouseX - (x - CAMERAX));
  }
}
