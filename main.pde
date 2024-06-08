import java.awt.event.KeyEvent;

Player p;
PImage img;
ArrayList<Enemy> e = new ArrayList<>();
ArrayList<Bullet> b; 
ArrayList<Bullet> be; // BULLETS FOR ENEMIES
ArrayList<Laser> l;
ArrayList<Laser> le; // LASERS FOR ENEMIES
ArrayList<Missile> m; 
ArrayList<Companion> c = new ArrayList<Companion>();

// OBJECTS
SoundManager soundManager;
Menu menu;
PFont myFont;

// GLOBAL VARIABLES
int MAPSIZE = 1500;
int VIEWSIZE = 1000;
int CAMERAX = 0;
int CAMERAY = 0;
int KILLCOUNT = 0;
int TOTALSCORE = 0;
int MINENEMIES = 5;
int MAXENEMIES = 50;
int SCREEN_SELECTED = 0;

// MOUSE INPUT
boolean[] keys;
boolean isLeftPressed = false;
boolean isRightPressed = false;

// RIGHT WEAPON SELECT
int LASER = 0;
int MISSILE = 1;
int COMPANION = 2;
int rightWeapon = LASER;

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
  p = new Player(width / 2, height / 2);
  e = new ArrayList<Enemy>();
  b = new ArrayList<Bullet>();
  be = new ArrayList<Bullet>();
  l = new ArrayList<Laser>();
  le = new ArrayList<Laser>();
  m = new ArrayList<Missile>();
  
  soundManager = new SoundManager(this);
  soundManager.loadAudios();
  soundManager.playMenuMusic();
  menu = new Menu();
  menu.generateStars();
  
  myFont = createFont("Starjedi.ttf", 36);
  textFont(myFont);
  
  img = loadImage("sprites/jawa_2.png");
  img.resize(0, 200);
}

void draw() {
  //MENU
  if(SCREEN_SELECTED == 0){
    menu.drawMenuPrincipal();
  }
  
  //CREDITOS
  if(SCREEN_SELECTED == 1){
    menu.drawCredits();
  }
  
  //INSTRUÇÃO DE COMO JOGAR
  if(SCREEN_SELECTED == 2){
    menu.drawInstructionsMenu();
  }
  
  //SELEÇÃO ARMA
  if(SCREEN_SELECTED == 3){
    menu.drawMenuSelecaoArmas();
  }
  
  //JOGO
  if(SCREEN_SELECTED == 4){
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
  
  //GAME OVER
  if(SCREEN_SELECTED == 5){
    menu.drawMenuGameOver(TOTALSCORE, KILLCOUNT);
  }
}
