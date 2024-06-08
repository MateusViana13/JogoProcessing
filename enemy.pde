// ADD ON DISPLAY TO CHECK THEIR HEALTH
// text("Life: " + health, x - size / 2, y + size / 2 + 20);

class Enemy {
  int x, y, damage, health, size, speed;
  boolean hitR = false; // IS HIT BY RIGHT WEAPON?

  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    this.damage = 10;
    this.health = 50;
    this.size = 20;
    this.speed = 2;
  }

  void move() {
    float dx = x - p.x;
    float dy = y - p.y;
    float distanceP = dist(p.x, p.y, x, y); // DISTANCE TO THE PLAYER
    if (distanceP > 0) {
      float unitX = dx / distanceP;
      float unitY = dy / distanceP;
      x = (int)constrain(x - unitX * speed, size / 2, MAPSIZE - size / 2);
      y = (int)constrain(y - unitY * speed, size / 2, MAPSIZE - size / 2);
    }
  }

  void display() {
    fill(255, 0, 0);
    triangle(x, y - size / 2, x - size / 2, y + size / 2, x + size / 2, y + size / 2);
    fill(255);
  }
}

class Strong extends Enemy {
  Strong(int x, int y) {
    super(x, y);
    damage *= 2;
    health *= 2;
  }

  void display() {
    fill(0, 255, 0);
    triangle(x, y - size / 2, x - size / 2, y + size / 2, x + size / 2, y + size / 2);
    fill(255);
  }
}

class Fast extends Enemy {
  Fast(int x, int y) {
    super(x, y);
    damage /= 2;
    health /= 2;
    speed *= 2;
  }

  void display() {
    fill(0, 0, 255);
    triangle(x, y - size / 2, x - size / 2, y + size / 2, x + size / 2, y + size / 2);
    fill(255);
  }
}

class Shooter extends Enemy {
  int intervalS = 2000; // SHOOT INTERVAL
  int lastS = 0; // LAST SHOOT

  Shooter(int x, int y) {
    super(x, y);
    damage /= 2;
    speed /= 2;
  }

  void move() {
    super.move();
    int now = millis();
    if (now - lastS > intervalS) {
      be.add(new Bullet(x, y, p.x, p.y, false));
      lastS = now;
    }
  }

  void display() {
    fill(255, 255, 0);
    triangle(x, y - size / 2, x - size / 2, y + size / 2, x + size / 2, y + size / 2);
    fill(255);
  }
}

class Runaway extends Enemy {
  Runaway(int x, int y) {
    super(x, y);
    this.damage = 100;
    health *= 2;
    this.speed = 3;
  }

  void move() {
    float dx = x - p.x;
    float dy = y - p.y;
    float distanceP = dist(p.x, p.y, x, y);
    if (distanceP < 400) { // CHANGE THE DISTANCE IT RUNS
      if (distanceP > 0) {
        float unitX = dx / distanceP;
        float unitY = dy / distanceP;
        x = (int)constrain(x + unitX * speed, size / 2, MAPSIZE - size / 2);
        y = (int)constrain(y + unitY * speed, size / 2, MAPSIZE - size / 2);
      }
    }
  }

  void display() {
    fill(0, 0, 255);
    ellipse(x, y, size, size);
    fill(255);
  }
}

class Boss extends Enemy {
  int intervalT = 6000; // TELEPORT INTERVAL
  int lastT = 0; // LAST TELEPORT
  int intervalL = 10000; // LASER INTERVAL
  int lastBL = 0; // LAST LASER

  Boss(int x, int y) {
    super(x, y);
    health *= 5;
    size = 40;
    this.damage = 25;
  }

  void move() {
    super.move();
    int now = millis();
    if (now - lastT >= intervalT) {
      x = int(random(size / 2, MAPSIZE - size / 2));
      y = int(random(size / 2, MAPSIZE - size / 2));
      lastT = now;
    }
    if (now - lastBL >= intervalL) {
      le.add(new Laser(x, y, p.x, p.y, false));
      lastBL = now;
    }
  }

  void display() {
    fill(255, 0, 255);
    ellipse(x, y, size, size);
    fill(255);
  }
}

void updateEnemies() {
  spawnEnemies();
  for (Enemy en : e) {
    en.move();
    en.display();
  }
}

void spawnEnemies() {
  int currentEnemies = e.size();
  int numEnemies = max(min(MAXENEMIES, (int)(log(KILLCOUNT + 1) * 2.5)), MINENEMIES);
  if (currentEnemies < numEnemies) {
    for (int i = 0; i < numEnemies - currentEnemies; i++) {
      int enemyX = int(random(MAPSIZE));
      int enemyY = int(random(MAPSIZE));
      float r = random(1);
      if (r < 0.50) {
        e.add(new Enemy(enemyX, enemyY)); // 50%
      } else if (r < 0.70) {
        e.add(new Strong(enemyX, enemyY)); // 20%
      } else if (r < 0.85) {
        e.add(new Fast(enemyX, enemyY)); // 15%
      } else if (r < 0.97) {
        e.add(new Shooter(enemyX, enemyY)); // 12%
      } else if (r < 0.98) {
        e.add(new Runaway(enemyX, enemyY)); // 1%
      } else {
        e.add(new Boss(enemyX, enemyY)); // 2%
      }
    }
  }
}