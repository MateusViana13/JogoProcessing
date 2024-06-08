
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
    drawButton(width / 2, height / 2 - 25, "Começar Jogo");
    
    // Desenha o botão "Créditos"
    drawButton(width / 2, height / 2 + 75, "Créditos");
  }

  void drawMenuGameOver() {
    background(0);
    fill(255, 0, 0); // Cor vermelha para o texto "Game Over"
    textAlign(CENTER);
    textSize(32);
    text("Game over", width / 2, height / 2 - 100);
    
    // Mostrar o score
    fill(255);
    textSize(24);
    text("Score: ", width / 2, height / 2 - 50);
  
    // Desenhar o botão "Menu"
    drawButton(width / 2, height / 2 + 50, "Menu");
  
    // Desenhar o botão "Jogar Novamente"
    drawButton(width / 2, height / 2 + 150, "Jogar novamente");
  }

  void drawStarBackground() {
    background(0);
    fill(255);
    for (int i = 0; i < numStars; i++) {
      ellipse(starX[i], starY[i], starSize[i], starSize[i]);
    } 
  }
  
  void drawGameOver(){
  
  }
  
  void drawMenuSelecao(){
  
  }
  
  void drawInstrucao(){
  
  }

  void drawButton(float x, float y, String label) {
    rectMode(CENTER);
    stroke(255, 255, 0);
    strokeWeight(3);
    fill(0);
    rect(x, y, 250, 50);
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
      "",
      "Um filme dirigido por",
      "George Lucas",
      "",
      "Créditos:",
      "Roteiro: George Lucas",
      "Produção: Gary Kurtz",
      "Música: John Williams",
      "Efeitos Visuais: Industrial Light & Magic",
      "",
      "Atores:",
      "Mark Hamill",
      "Harrison Ford",
      "Carrie Fisher",
      "Peter Cushing",
      "e muitos outros...",
      "",
      "© Lucasfilm Ltd. All Rights Reserved."
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
    
    menu.drawButton(150, 50, "F1 - Sair");
  }
}
