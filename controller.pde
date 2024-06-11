void keyPressed() {
  if (key == 'w' || key == 'W') keys[0] = true;
  if (key == 'a' || key == 'A') keys[1] = true;
  if (key == 's' || key == 'S') keys[2] = true;
  if (key == 'd' || key == 'D') keys[3] = true;
  if (keyCode == SHIFT) {
    keys[4] = true;
  }
  if (SCREEN_SELECTED == 1) {
    if (keyCode == KeyEvent.VK_F1) {
      SCREEN_SELECTED = 0;
      sm.stopCreditMusic();
      sm.playMenuMusic();
    }
  }
}
void keyReleased() {
  if (key == 'w' || key == 'W') keys[0] = false;
  if (key == 'a' || key == 'A') keys[1] = false;
  if (key == 's' || key == 'S') keys[2] = false;
  if (key == 'd' || key == 'D') keys[3] = false;
  if (keyCode == SHIFT) {
    keys[4] = false;
  }
}
void mousePressed() {
  if (SCREEN_SELECTED == 0) {
    boolean clickJogar = isMouseOverButton(width / 2, height / 2 - 25, mouseX, mouseY, 250);
    boolean clickCreditos = isMouseOverButton(width / 2, height / 2 + 75, mouseX, mouseY, 250);
    boolean clickInstructions = isMouseOverButton(width / 2, height / 2 + 175, mouseX, mouseY, 250);
    if (clickCreditos) {
      sm.playButtonClick();
      SCREEN_SELECTED = 1;
      sm.stopMenuMusic();
      sm.playCreditMusic();
    }
    if (clickJogar) {
      sm.playButtonClick();
      resetGame();
      SCREEN_SELECTED = 3;
    }
    if (clickInstructions) {
      sm.playButtonClick();
      SCREEN_SELECTED = 2;
    }
  }
  if (SCREEN_SELECTED == 2) {
    boolean clickMenu = isMouseOverButton(width / 2, height / 2 - 50, mouseX, mouseY, 400);
    if (clickMenu) {
      sm.playButtonClick();
      SCREEN_SELECTED = 0;
    }
    if (mouseX >= (width - 150) && mouseX <= (width - 150)+ 100 && mouseY >= (height - 200) && mouseY <= (height - 200) + 200) {
      sm.playEasterEgg();
    }
  }
  if (SCREEN_SELECTED == 3) {
    boolean clickLaser = isMouseOverButton(width / 2 - 250, height / 2, mouseX, mouseY, 200);
    boolean clickMissil = isMouseOverButton(width / 2, height / 2, mouseX, mouseY, 200);
    boolean clickCompanion = isMouseOverButton(width / 2 + 250, height / 2, mouseX, mouseY, 200);
    if (clickLaser) {
      sm.playButtonClick();
      rightWeapon = 0;
    }
    if (clickMissil) {
      sm.playButtonClick();
      rightWeapon = 1;
    }
    if (clickCompanion) {
      sm.playButtonClick();
      rightWeapon = 2;
    }
    boolean clickJogar = isMouseOverButton(width / 2, height / 2 + 100, mouseX, mouseY, 250);
    boolean clickMenu = isMouseOverButton(width / 2, height / 2 + 200, mouseX, mouseY, 250);
    if (clickMenu) {
      sm.playButtonClick();
      resetGame();
      SCREEN_SELECTED = 0;
    }
    if (clickJogar) {
      sm.playButtonClick();
      resetGame();
      SCREEN_SELECTED = 4;
    }
  }
  if (SCREEN_SELECTED == 4) {
    if (mouseButton == LEFT) {
      isLeftPressed = true;
    }
    if (mouseButton == RIGHT) {
      isRightPressed = true;
    }
  }
  if (SCREEN_SELECTED == 5) {
    boolean clickMenu  = isMouseOverButton(width / 2, height / 2 + 50, mouseX, mouseY, 350);
    boolean clickJogarNovamente = isMouseOverButton(width / 2, height / 2 + 150, mouseX, mouseY, 350);
    if (clickMenu) {
      sm.playButtonClick();
      SCREEN_SELECTED = 0;
    }
    if (clickJogarNovamente) {
      sm.playButtonClick();
      resetGame();
      SCREEN_SELECTED = 4;
    }
  }
}
void mouseReleased() {
  if (mouseButton == LEFT) {
    isLeftPressed = false;
  }
  if (mouseButton == RIGHT) {
    isRightPressed = false;
  }
}
void handleMouseInput() {
  if (isLeftPressed) {
    int timeL = millis();
    if (timeL - lastB >= cooldownB) {
      float targetX = mouseX + CAMERAX;
      float targetY = mouseY + CAMERAY;
      b.add(new Bullet(p.x, p.y, targetX, targetY, true));
      lastB = timeL;
    }
  }
  if (isRightPressed) {
    int timeR = millis();
    float targetX = mouseX + CAMERAX;
    float targetY = mouseY + CAMERAY;
    if (timeR - lastL >= cooldownL) {
      for (Enemy en : e) {
        en.hitR = false;
      }
      l.add(new Laser(p.x, p.y, targetX, targetY, true));
      lastL = timeR;
    } else if (rightWeapon == MISSILE && timeR - lastM >= cooldownM) {
      if (m.size() > 0) {
        Missile firstMissile = m.get(0);
        firstMissile.exploded = true;
      }
      m.add(new Missile(p.x, p.y, targetX, targetY));
      lastM = timeR;
    } else if (rightWeapon == COMPANION && !activeC && millis() / 1000.0 - cooldownTimerC > cooldownC) {
      c.add(new Companion(p.x, p.y));
      sm.playCompanionSound();
      activeC = true;
      timerC = millis() / 1000.0;
    }
  }
}
boolean isMouseOverButton(float buttonX, float buttonY, float mouseX, float mouseY, float buttonWidth) {
  float buttonHeight = 50;
  float left = buttonX - buttonWidth / 2;
  float right = buttonX + buttonWidth / 2;
  float top = buttonY - buttonHeight / 2;
  float bottom = buttonY + buttonHeight / 2;
  if (mouseX > left && mouseX < right && mouseY > top && mouseY < bottom) {
    return true;
  } else {
    return false;
  }
}
