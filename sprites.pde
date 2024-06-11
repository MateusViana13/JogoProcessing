class Sprites {
  PImage imgJawa;
  PImage imgXWing;
  PImage imgTie;
  PImage imgTieStrong;
  PImage imgTieFast;
  PImage imgTieShooter;
  PImage imgDeathStar;
  PImage imgComet;
  PImage imgCompanion;
  PImage imgLaserSelect;
  PImage imgMissileSelect;
  PImage imgCompanionSelect;
  void loadSprites() {
    imgJawa = loadImage("sprites/jawa.png");
    imgXWing = loadImage("sprites/xwing.png");
    imgTie = loadImage("sprites/tie.png");
    imgTieStrong = loadImage("sprites/strong.png");
    imgTieFast = loadImage("sprites/fast.png");
    imgTieShooter = loadImage("sprites/shooter.png");
    imgDeathStar = loadImage("sprites/deathstar.png");
    imgComet = loadImage("sprites/asteroid.png");
    imgCompanion = loadImage("sprites/companion.png");
    imgLaserSelect = loadImage("sprites/laser.png");
    imgMissileSelect = loadImage("sprites/missile.png");
    imgCompanionSelect = loadImage("sprites/companion2.png");
    updateSprites();
  }
  void updateSprites() {
    resizeSprite(imgJawa, 200);
    resizeSprite(imgXWing, p.size);
    resizeSprite(imgTie, 30);
    resizeSprite(imgTieStrong, 30);
    resizeSprite(imgTieFast, 30);
    resizeSprite(imgTieShooter, 30);
    resizeSprite(imgDeathStar, 60);
    resizeSprite(imgComet, 30);
    resizeSprite(imgCompanion, 40);
    resizeSprite(imgMissileSelect, 200);
    resizeSprite(imgLaserSelect, 200);
    resizeSprite(imgCompanionSelect, 200);
  }
  void resizeSprite(PImage sprite, int size) {
    float aspectRatio = (float) sprite.width / (float) sprite.height;
    int newWidth, newHeight;
    if (sprite.width > sprite.height) {
      newWidth = size;
      newHeight = (int) (size / aspectRatio);
    } else {
      newHeight = size;
      newWidth = (int) (size * aspectRatio);
    }
    sprite.resize(newWidth, newHeight);
  }
}
