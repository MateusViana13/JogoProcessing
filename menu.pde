class Menu {
  PFont crawlFont; // CREDIT'S FONT
  float crawlY = 600; // CREDIT START POSITION
  float lineHeight = 35; // LINE SPACING
  int numStars = 200;
  float[] starX = new float[numStars];
  float[] starY = new float[numStars];
  float[] starSize = new float[numStars];
  void generateStars() {
    for (int i = 0; i < numStars; i++) {
      starX[i] = random(width);
      starY[i] = random(height);
      starSize[i] = random(1, 3);
    }
  }
  void drawStarBackground() {
    background(0);
    fill(255);
    for (int i = 0; i < numStars; i++) {
      ellipse(starX[i], starY[i], starSize[i], starSize[i]);
    }
  }
  void drawButton(float x, float y, String label, float size) {
    rectMode(CENTER);
    stroke(255, 255, 0);
    strokeWeight(3);
    fill(0);
    rect(x, y, size, 50);
    fill(255, 255, 0);
    noStroke();
    textSize(24);
    text(label, x, y + 10);
  }
  void drawWeaponButton(float x, float y, String label, int index) {
    rectMode(CENTER);
    if (rightWeapon == index) {
      fill(0, 255, 0);
    } else {
      fill(255);
    }
    rect(x, y, 200, 50);
    fill(0);
    textSize(24);
    text(label, x, y + 8);
  }
  void drawSpriteAboveButton(float x, float y, PImage sprite) {
    image(sprite, x - sprite.width / 2, y - sprite.height - 50);
  }
  void drawInstructionsMenu() {
    drawStarBackground();
    textAlign(CENTER);
    textSize(24);
    fill(255);
    text("instruções de Como Jogar", width / 2, 150);
    textSize(30);
    text("WASD para mover", width / 2, 200);
    text("Botão Esquerdo do Mouse para atirar", width / 2, 240);
    text("Botão Direito do Mouse para usar a arma especial", width / 2, 280);
    text("Shift para dar um sprint", width / 2, 320);
    drawButton(width / 2, height / 2 - 50, "voltar ao menu principal", 400);
    imageMode(CORNER);
    image(sp.imgJawa, width - 150, height - 200);
  }
  void drawCredits() {
    drawStarBackground();
    fill(255);
    textAlign(CENTER, CENTER);
    String[] credits = {
      "STAR WARS",
      "hyperjump",
      "",
      "um jogo desenvolvido por",
      "gamf",
      "",
      "Numa galáxia em guerra,",
      "um piloto destemido",
      "embarca na nave x-wing",
      "para enfrentar inimigos intermináveis.",
      "Com reflexos afiados ",
      "e estratégia implacável,",
      "ele desafia a Estrela da Morte ",
      "e luta pela maior pontuação,",
      "Cada vitória é uma luz na escuridão,",
      "enquanto a batalha sem fim continua.",
      "",
      "Desenvolvedores:",
      "André Franco",
      "Felipe Pereira",
      "Guilherme Salomão",
      "Mateus Montini",
      "Mateus viana",
      "",
      "gamf. All Rights Reserved."
    };
    for (int i = 0; i < credits.length; i++) {
      float fontSize = map(crawlY + i * lineHeight, height, 50, 48, 12);
      textSize(fontSize);
      text(credits[i], width/2, crawlY + i * lineHeight);
    }
    crawlY -= 0.5;
    if (crawlY < 50 - (credits.length - 1) * lineHeight) {
      crawlY = 50 - (credits.length - 1) * lineHeight;
    }
    menu.drawButton(150, 50, "F1 - Sair", 250);
  }
}
