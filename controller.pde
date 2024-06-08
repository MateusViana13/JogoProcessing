void keyPressed() {
  if (key == 'w' || key == 'W') keys[0] = true;
  if (key == 'a' || key == 'A') keys[1] = true;
  if (key == 's' || key == 'S') keys[2] = true;
  if (key == 'd' || key == 'D') keys[3] = true;
  if (keyCode == SHIFT) { 
    keys[4] = true; 
  }
  
  if(SCREEN_SELECTED == 1){
    if (keyCode == KeyEvent.VK_F1) {
      SCREEN_SELECTED = 0;   
      soundManager.stopCreditMusic();
      soundManager.playMenuMusic();
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
    // Verifica se o clique foi dentro do botão
    boolean clickJogar = isMouseOverButton(width / 2, height / 2 - 25, mouseX, mouseY);
    boolean clickCreditos = isMouseOverButton(width / 2, height / 2 + 75, mouseX, mouseY);
    
    if (clickCreditos) {
      SCREEN_SELECTED = 1;
      soundManager.stopMenuMusic();
      soundManager.playCreditMusic();   
    }
    
    if (clickJogar) {
      SCREEN_SELECTED = 4;
    }
  }
  
  if(SCREEN_SELECTED == 4){
    if (mouseButton == LEFT) {
      isLeftPressed = true; // Set the flag when left mouse button is pressed
      soundManager.playShotSound();
    }
    if (mouseButton == RIGHT) {
      isRightPressed = true; // Set the flag when right mouse button is pressed
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
      m.add(new Missile(p.x, p.y, targetX, targetY));
      lastM = timeR;
    } else if (rightWeapon == COMPANION && !activeC && millis() / 1000.0 - cooldownTimerC > cooldownC) {
      c.add(new Companion(p.x, p.y, p.size*4/5));
      activeC = true;
      timerC = millis() / 1000.0;
    }
  }
}

boolean isMouseOverButton(float buttonX, float buttonY, float mouseX, float mouseY) {
  float buttonWidth = 250;
  float buttonHeight = 50;
  
  // Calcular os limites do botão
  float left = buttonX - buttonWidth / 2;
  float right = buttonX + buttonWidth / 2;
  float top = buttonY - buttonHeight / 2;
  float bottom = buttonY + buttonHeight / 2;
  
  // Verificar se o clique está dentro dos limites do botão
  if (mouseX > left && mouseX < right && mouseY > top && mouseY < bottom) {
    return true;
  } else {
    return false;
  }
}
