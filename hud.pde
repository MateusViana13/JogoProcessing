void updateCamera() {
  CAMERAX = constrain(p.x - VIEWSIZE / 2, 0, MAPSIZE - VIEWSIZE);
  CAMERAY = constrain(p.y - VIEWSIZE / 2, 0, MAPSIZE - VIEWSIZE);
}

void displayHUD() {
  textSize(16);
  textAlign(LEFT);
  int widthValue = 5;
  fill(255);
  text("Life: " + p.health, widthValue, 20);
  text("Kills: " + KILLCOUNT, widthValue, 40);
  text("Score: " + TOTALSCORE, widthValue, 60);
  // Sprint Alert
  int sprintR = cooldownS - (millis() - lastS);
  if (sprintR > 0) {
    text("Sprint Cooldown: " + ceil(sprintR / 1000.0) + "s", widthValue, 80);
  } else {
    text("Sprint Ready", widthValue, 80);
  }
  // RightWeapon Alert
  int currentTime = millis();
  if (rightWeapon == LASER) {
    int rightR = cooldownL - (currentTime - lastL);
    if (rightR > 0) {
      text("Laser Cooldown: " + ceil(rightR / 1000.0) + "s", widthValue, 100);
    } else {
      text("Laser Cooldown: Ready to use.", widthValue, 100);
    }
  }
  if (rightWeapon == MISSILE) {
    int rightR = cooldownM - (currentTime - lastM);
    if (rightR > 0) {
      text("Missile Cooldown: " + ceil(rightR / 1000.0) + "s", widthValue, 100);
    } else {
      text("Missile Cooldown: Ready to use.", widthValue, 100);
    }
  } else if (rightWeapon == COMPANION) {
    if (activeC) {
      int rightR = (int)(timerC + activeTimeC) - (int)(millis() / 1000.0);
      if (rightR > 0) {
        text("Companion Active: " + rightR + "s", widthValue, 100);
      } else {
        text("Companion Active: 0s", widthValue, 100);
      }
    } else {
      int rightR = (int)(cooldownTimerC + cooldownC) - (int)(millis() / 1000.0);
      if (rightR > 0) {
        text("Companion Cooldown: " + rightR + "s", widthValue, 100);
      } else {
        text("Companion Cooldown: Ready to use.", widthValue, 100);
      }
    }
  }
}
