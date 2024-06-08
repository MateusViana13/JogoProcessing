
class Menu{
  PFont crawlFont; // Fonte para os créditos
  float crawlY = 600; // Posição inicial dos créditos
  float lineHeight = 35; // Espaço entre as linhas de texto
  
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

  void drawMenuPrincipal(){
    drawStarBackground();
    
    fill(255);
    textAlign(CENTER);
    textSize(52);
    text("Star Wars", width / 2, height / 2 - 300);
    
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(76);
    text("Hyperjump", width / 2, height / 2 - 240);
    
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("Menu inicial", width / 2, height / 2 - 100);
    
    // Desenha o botão "Começar Jogo"
    drawButton(width / 2, height / 2 - 25, "Começar jogo", 250);
    
    // Desenha o botão "Créditos"
    drawButton(width / 2, height / 2 + 75, "Créditos", 250);
    
    // Desenha o botão "Como jogar"
    drawButton(width / 2, height / 2 + 175, "Como jogar", 250);
  }

  void drawMenuGameOver(int score, int killCount) {
    drawStarBackground();
    
    fill(255, 0, 0); // Cor vermelha para o texto "Game Over"
    textAlign(CENTER);
    textSize(64);
    text("Game over", width / 2, height / 2 - 200);
    
    // Mostrar o score
    fill(255);
    textSize(36);
    text("Score: " + score, width / 2, height / 2 - 75);
    
    fill(255);
    textSize(36);
    text("Kills: " + killCount, width / 2, height / 2 - 25);
  
    // Desenhar o botão "Menu"
    drawButton(width / 2, height / 2 + 50, "Menu", 350);
  
    // Desenhar o botão "Jogar Novamente"
    drawButton(width / 2, height / 2 + 150, "Jogar novamente", 350);
  }

  void drawStarBackground() {
    background(0);
    fill(255);
    for (int i = 0; i < numStars; i++) {
      ellipse(starX[i], starY[i], starSize[i], starSize[i]);
    } 
  }
  
   void drawMenuSelecaoArmas() {
    drawStarBackground(); 

    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("Selecione sua Arma", width / 2, height / 2 - 300);
  
    textSize(24);
    
    // Desenhar o primeiro botão
    drawWeaponButton(width / 2 - 250, height / 2, "Laser", 0);
  
    // Desenhar o segundo botão
    drawWeaponButton(width / 2, height / 2, "Missil", 1);
  
    // Desenhar o terceiro botão
    drawWeaponButton(width / 2 + 250, height / 2, "Companheiro", 2);
    
    drawButton(width / 2, height / 2 + 100, "jogar", 250);
    
    drawButton(width / 2, height / 2 + 200, "Menu", 250);
  }

  void drawWeaponButton(float x, float y, String label, int index) {
    rectMode(CENTER);
    if (rightWeapon == index) {
      fill(0, 255, 0); // Verde para a arma selecionada
    } else {
      fill(255); // Branco para outras opções
    }
    rect(x, y, 200, 50);
    fill(0);
    textSize(24);
    text(label, x, y + 8);
  }
  
  void drawInstructionsMenu() {
    drawStarBackground();
    textAlign(CENTER);
    textSize(24);
    fill(255);
    text("instruções de Como Jogar", width / 2, 50);
    
    textSize(30);
    text("WASD para mover", width / 2, 100);
    text("Botão Esquerdo do Mouse para atirar", width / 2, 140);
    text("Botão Direito do Mouse para usar a arma especial", width / 2, 180);
    text("Shift para dar um sprint", width / 2, 220);
    
    // Desenhar botão "Voltar ao Menu Principal"
    drawButton(width / 2, height / 2 - 50, "voltar ao menu principal", 400);
    
    image(img, width - 150, height - 200);
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
  
  void drawCredits(){
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
      "embarca na nave Hyperdrive",
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
      float fontSize = map(crawlY + i * lineHeight, height, 50, 48, 12); // Tamanho do texto diminui conforme ele se aproxima do topo
      textSize(fontSize);
      text(credits[i], width/2, crawlY + i * lineHeight);
    }
  
    crawlY -= 0.5; // Velocidade de diminuição do texto
  
    // Define uma altura mínima para os créditos
    if (crawlY < 50 - (credits.length - 1) * lineHeight) {
      crawlY = 50 - (credits.length - 1) * lineHeight;
    }
    
    menu.drawButton(150, 50, "F1 - Sair", 250);
  }
}
