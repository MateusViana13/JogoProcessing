import java.awt.event.KeyEvent;
Menu menu;
Player p;
SoundManager sm;
Sprites sp;
ArrayList<Enemy> e = new ArrayList<>();
ArrayList<Bullet> b;
ArrayList<Bullet> be; // BULLETS FOR ENEMIES
ArrayList<Laser> l;
ArrayList<Laser> le; // LASERS FOR ENEMIES
ArrayList<Missile> m;
ArrayList<Companion> c = new ArrayList<Companion>();
PFont font;
// GLOBAL VARIABLES
int MAPSIZE = 1500;
int VIEWSIZE = 1000;
int CAMERAX = 0;
int CAMERAY = 0;
int KILLCOUNT = 0;
int TOTALSCORE = 0;
int MINENEMIES = 10;
int MAXENEMIES = 50;
int MAX_KILLCOUNT = 100;
int SCREEN_SELECTED = 0;
// MOUSE INPUT
boolean[] keys;
boolean isLeftPressed = false;
boolean isRightPressed = false;
// RIGHT WEAPON SELECT
int LASER = 0;
int MISSILE = 1;
int COMPANION = 2;
int rightWeapon = 0;
// BULLET VARIABLES
int lastB = 0;
int cooldownB = 150;
// LASER VARIABLES
int lastL = 0;
int cooldownL = 10000;
// MISSILE VARIABLES
int lastM = 0;
int cooldownM = 5000;
// COMPANION VARIABLES
boolean activeC = false;
float timerC = 0;
float cooldownTimerC = 0;
int cooldownC = 7;
int activeTimeC = 10;
// SPRINT
boolean isS = false;
int lastS = 0;
int durantionS = 500;
int cooldownS = 5000;
void setup() {
  size(1000, 1000);
  p = new Player();
  e = new ArrayList<Enemy>();
  b = new ArrayList<Bullet>();
  be = new ArrayList<Bullet>();
  l = new ArrayList<Laser>();
  le = new ArrayList<Laser>();
  m = new ArrayList<Missile>();
  sp = new Sprites();
  sp.loadSprites();
  sm = new SoundManager(this);
  sm.loadAudios();
  sm.playMenuMusic();
  menu = new Menu();
  menu.generateStars();
  font = createFont("Starjedi.ttf", 36);
  textFont(font);
}
void draw() {
  // MENU
  if (SCREEN_SELECTED == 0) {
    menu.drawStarBackground();
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
    menu.drawButton(width / 2, height / 2 - 25, "Começar jogo", 250);
    menu.drawButton(width / 2, height / 2 + 75, "Créditos", 250);
    menu.drawButton(width / 2, height / 2 + 175, "Como jogar", 250);
  }
  // CREDITS
  if (SCREEN_SELECTED == 1) {
    menu.drawCredits();
  }
  // INSTRUCTION
  if (SCREEN_SELECTED == 2) {
    menu.drawInstructionsMenu();
  }
  // WEAPON SELECTION
  if (SCREEN_SELECTED == 3) {
    menu.drawStarBackground();
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("Selecione sua Arma", width / 2, height / 2 - 300);
    textSize(24);
    imageMode(CORNER);
    menu.drawWeaponButton(width / 2 - 250, height / 2, "Laser", 0);
    menu.drawSpriteAboveButton(width / 2 - 250, height / 2, sp.imgLaserSelect);
    menu.drawWeaponButton(width / 2, height / 2, "Missil", 1);
    menu.drawSpriteAboveButton(width / 2, height / 2, sp.imgMissileSelect);
    menu.drawWeaponButton(width / 2 + 250, height / 2, "Companheiro", 2);
    menu.drawSpriteAboveButton(width / 2 + 250, height / 2, sp.imgCompanionSelect);
    menu.drawButton(width / 2, height / 2 + 100, "jogar", 250);
    menu.drawButton(width / 2, height / 2 + 200, "Menu", 250);
  }
  // GAME
  if (SCREEN_SELECTED == 4) {
    menu.drawStarBackground();
    updateCamera();
    translate(-CAMERAX, -CAMERAY);
    p.display();
    p.updatePlayer();
    updateWeaponry();
    updateEnemies();
    checkCollisions();
    translate(CAMERAX, CAMERAY);
    displayHUD();
    handleMouseInput();
  }
  // GAME OVER
  if (SCREEN_SELECTED == 5) {
    sm.gameOverSound.play();
    menu.drawStarBackground();
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(64);
    text("Game over", width / 2, height / 2 - 200);
    fill(255);
    textSize(36);
    text("Score: " + TOTALSCORE, width / 2, height / 2 - 75);
    fill(255);
    textSize(36);
    text("Kills: " + KILLCOUNT, width / 2, height / 2 - 25);
    menu.drawButton(width / 2, height / 2 + 50, "Menu", 350);
    menu.drawButton(width / 2, height / 2 + 150, "Jogar novamente", 350);
  }
}
void resetGame() {
  KILLCOUNT = 0;
  TOTALSCORE = 0;
  CAMERAX = 0;
  CAMERAY = 0;
  p = new Player();
  e = new ArrayList<Enemy>();
  b = new ArrayList<Bullet>();
  be = new ArrayList<Bullet>();
  l = new ArrayList<Laser>();
  le = new ArrayList<Laser>();
  m = new ArrayList<Missile>();
}
