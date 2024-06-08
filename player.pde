class Player {
  int x, y, size, health, speed;

  Player(int startX, int startY, int startSize, int startHealth, int startSpeed) {
    x = startX;
    y = startY;
    size = startSize;
    health = startHealth;
    speed = startSpeed;
    keys = new boolean[5];
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, size, size);
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
  }
}
