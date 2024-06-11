class Bullet {
  float angle, damage = 10, size = 10, speed = 10, x, y;
  boolean isPlayerBullet;
  Bullet(float startX, float startY, float targetX, float targetY, boolean isPlayerBullet) {
    sm.playBulletSound();
    x = startX;
    y = startY;
    this.isPlayerBullet = isPlayerBullet;
    speed = isPlayerBullet ? 10 : 2;
    angle = atan2(targetY - startY, targetX - startX);
  }
  void move() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }
  void display() {
    if (isPlayerBullet) {
      stroke(255, 0, 0);
    } else {
      stroke(0, 255, 0);
    }
    float endX = x + cos(angle) * size;
    float endY = y + sin(angle) * size;
    line(x, y, endX, endY);
    noStroke();
  }
  boolean isOffScreen() {
    return x < 0 || x > MAPSIZE || y < 0 || y > MAPSIZE;
  }
}
class Laser {
  float angle, damage = 50, endX, endY, size = 100, speed, x, y;
  boolean isPlayerLaser;

  Laser(float startX, float startY, float targetX, float targetY, boolean isPlayerLaser) {
    if (rightWeapon == LASER)
      sm.playLaserSound();
    x = startX;
    y = startY;
    this.isPlayerLaser = isPlayerLaser;
    speed = isPlayerLaser ? 6 : 2;
    angle = atan2(targetY - startY, targetX - startX);
    endX = x + cos(angle) * size;
    endY = y + sin(angle) * size;
  }
  void update() {
    float dx = cos(angle) * speed;
    float dy = sin(angle) * speed;
    x += dx;
    y += dy;
    endX += dx;
    endY += dy;
  }
  void display() {
    if (isPlayerLaser) {
      stroke(255, 0, 0);
    } else {
      stroke(0, 255, 0);
    }
    line(x, y, endX, endY);
    noStroke();
  }
  boolean isOffScreen() {
    return x < 0 || x > MAPSIZE || y < 0 || y > MAPSIZE;
  }
  boolean hits(Enemy enemy) {
    float ex = enemy.x;
    float ey = enemy.y;
    PVector laserVector = new PVector(endX - x, endY - y);
    PVector enemyVector = new PVector(ex - x, ey - y);
    float dotProduct = enemyVector.dot(laserVector);
    float laserMagnitude = laserVector.mag();
    float distanceToLine = dotProduct / laserMagnitude;
    float effectiveRange = size / 2;
    if (distanceToLine <= laserMagnitude && distanceToLine >= 0 && dist(x, y, ex, ey) <= effectiveRange) {
      return true;
    }
    return false;
  }
}
class Missile {
  boolean exploded = false;
  int currentExplosionFrame = 0, explosionFrames = 30, explosionRadius = 100;
  float damage = 25, size = 15, speed, x, y, targetX, targetY;
  Missile(float startX, float startY, float targetXPosition, float targetYPosition) {
    x = startX;
    y = startY;
    targetX = targetXPosition;
    targetY = targetYPosition;
    speed = 5;
  }
  void move() {
    if (!exploded) {
      float dx = targetX - x;
      float dy = targetY - y;
      float distance = sqrt(dx * dx + dy * dy);
      float vx = dx / distance * speed;
      float vy = dy / distance * speed;
      x += vx;
      y += vy;
    }
  }
  void display() {
    if (!exploded) {
      fill(255, 0, 0);
      ellipse(x, y, size, size);
    } else {
      if (currentExplosionFrame < explosionFrames) {
        fill(255, 0, 0, 100);
        ellipse(x, y, explosionRadius * 2, explosionRadius * 2);
        if (currentExplosionFrame == 0) {
          sm.playExplosionSound();
        }
        currentExplosionFrame++;
      }
    }
  }
  boolean isOffScreen() {
    return x < 0 || x > MAPSIZE || y < 0 || y > MAPSIZE;
  }
  boolean hits(Enemy enemy) {
    if (exploded) {
      float distanceSquared = (x - enemy.x) * (x - enemy.x) + (y - enemy.y) * (y - enemy.y);
      return distanceSquared <= explosionRadius * explosionRadius;
    }
    return false;
  }
}
class Companion {
  PImage sprite;
  float fireRate = 0.2, lastShotTime, x, y;
  float angle;

  Companion(float startX, float startY) {
    x = startX;
    y = startY;
    sprite = sp.imgCompanion;
  }
  void move(float targetX, float targetY) {
    x = lerp(x, targetX, 0.05);
    y = lerp(y, targetY, 0.05);
  }
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle + HALF_PI);
    imageMode(CENTER);
    image(sprite, 0, 0);
    popMatrix();
  }
  void shoot(ArrayList<Bullet> bullets) {
    int currentTime = millis();
    if (currentTime - lastShotTime >= 1000 * fireRate) {
      float targetX = mouseX + CAMERAX;
      float targetY = mouseY + CAMERAY;
      bullets.add(new Bullet(x, y, targetX, targetY, true));
      lastShotTime = currentTime;
    }
  }
}
void updateWeaponry() {
  for (int i = b.size() - 1; i >= 0; i--) {
    Bullet bu = b.get(i);
    bu.move();
    bu.display();
    if (bu.isOffScreen()) {
      b.remove(i);
    }
  }
  for (int i = be.size() - 1; i >= 0; i--) {
    Bullet bu = be.get(i);
    bu.move();
    bu.display();
    if (bu.isOffScreen()) {
      be.remove(i);
    } else if (isHitB(p, be)) {
      p.health -= 10;
      be.remove(i);
    }
  }
  for (int i = le.size() - 1; i >= 0; i--) {
    Laser la = le.get(i);
    la.update();
    la.display();
    if (la.isOffScreen()) {
      le.remove(i);
    } else if (isHitL(p, le)) {
      p.health -= la.damage;
      le.remove(i);
    }
  }
  if (rightWeapon == LASER) {
    for (int i = l.size() - 1; i >= 0; i--) {
      Laser la = l.get(i);
      la.update();
      la.display();
      if (la.isOffScreen()) {
        l.remove(i);
      }
    }
  }
  if (rightWeapon == MISSILE) {
    for (int i = m.size() - 1; i >= 0; i--) {
      Missile mi = m.get(i);
      mi.move();
      mi.display();
      if (mi.isOffScreen()) {
        m.remove(i);
      } else if (!mi.exploded) {
        for (int j = e.size() - 1; j >= 0; j--) {
          Enemy enemy = e.get(j);
          if (dist(mi.x, mi.y, enemy.x, enemy.y) < (mi.size / 2 + enemy.size / 2)) {
            mi.exploded = true;
            break;
          }
        }
      } else if (mi.currentExplosionFrame >= mi.explosionFrames) {
        m.remove(i);
      } else {
        for (int j = e.size() - 1; j >= 0; j--) {
          Enemy en = e.get(j);
          if (mi.hits(en) && !en.hitR) {
            en.hitR = true;
            en.health -= mi.damage;
            if (en.health <= 0) enemyDestroyed(en);
          }
        }
      }
    }
  }
  if (rightWeapon == COMPANION) {
    for (int i = c.size() - 1; i >= 0; i--) {
      Companion co = c.get(i);
      co.move(p.x, p.y);
      co.display();
      co.shoot(b);
      if (millis() / 1000.0 - timerC > activeTimeC) {
        c.remove(i);
        activeC = false;
        cooldownTimerC = millis() / 1000.0;
      }
      co.angle = atan2(mouseY - (co.y - CAMERAY), mouseX - (co.x - CAMERAX));
    }
  }
}
