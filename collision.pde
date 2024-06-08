boolean isHitB(Player player, ArrayList<Bullet> bullets) {
  for (Bullet b : bullets) {
    if (dist(player.x, player.y, b.x, b.y) < (player.size / 2 + b.size / 2)) {
      return true;
    }
  }
  return false;
}

boolean isHitL(Player player, ArrayList<Laser> lasers) {
  for (Laser l : lasers) {
    if (dist(player.x, player.y, l.x, l.y) < (player.size / 2 + l.size / 2)) {
      return true;
    }
  }
  return false;
}

void checkCollisions() {
  for (int i = e.size() - 1; i >= 0; i--) {
    Enemy en = e.get(i);
    if (dist(p.x, p.y, en.x, en.y) < (p.size / 2 + en.size / 2)) {
      p.health -= en.damage;
      e.remove(i);
      continue;
    }
    for (int j = b.size() - 1; j >= 0; j--) {
      Bullet bu = b.get(j);
      if (dist(bu.x, bu.y, en.x, en.y) < (bu.size / 2 + en.size / 2)) {
        en.health -= bu.damage;
        b.remove(j);
        if (en.health <= 0) enemyDestroyed(en);
        break;
      }
    }
    if (rightWeapon == LASER) {
      for (int k = l.size() - 1; k >= 0; k--) {
        Laser la = l.get(k);
        if (la.hits(en) && !en.hitR) {
          en.health -= la.damage;
          en.hitR = true;
          if (en.health <= 0) enemyDestroyed(en);
        }
      }
    }
    if (rightWeapon == MISSILE) {
      for (int k = m.size() - 1; k >= 0; k--) {
        Missile mi = m.get(k);
        if (dist(mi.x, mi.y, en.x, en.y) < (mi.size / 2 + en.size / 2)) {
          mi.exploded = true;
          fill(255, 0, 0, 100);
          ellipse(mi.x, mi.y, mi.explosionRadius * 2, mi.explosionRadius * 2);
          if (mi.hits(en) && !en.hitR) {
            en.health -= mi.damage;
            en.hitR = true;
            if (en.health <= 0) enemyDestroyed(en);
          }
        }
      }
    }
    if (p.health <= 0) {
      SCREEN_SELECTED = 5;
    }
  }
}

void enemyDestroyed(Enemy en) {
  if (en instanceof Strong) TOTALSCORE += 2;
  else if (en instanceof Fast) TOTALSCORE += 2;
  else if (en instanceof Shooter) TOTALSCORE += 3;
  else if (en instanceof Runaway) TOTALSCORE += 100;
  else if (en instanceof Boss) {
    TOTALSCORE += 100;
    p.health = min(p.health + 25, 100);
  } else TOTALSCORE += 1; // NORMAL ENEMY
  e.remove(en);
  KILLCOUNT++;
  if (KILLCOUNT % 50 == 0) {
    p.health = min(p.health + 5, 100);
  }
}
