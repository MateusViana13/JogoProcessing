class Player {
  int x, y, size, health, speed;
  float angle;
  Player() {
    x = MAPSIZE / 2;
    y = MAPSIZE / 2;
    size = 40;
    health = 100;
    speed = 5;
    keys = new boolean[5];
    angle = 0;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle + HALF_PI);
    imageMode(CENTER);
    image(sp.imgXWing, 0, 0);
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
