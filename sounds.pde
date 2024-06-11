import ddf.minim.*;

class SoundManager {
  AudioPlayer bulletSound;
  AudioPlayer buttonClick;
  AudioPlayer companionSound;
  AudioPlayer creditMusic;
  AudioPlayer easterEgg;
  AudioPlayer explosionSound;
  AudioPlayer gameOverSound;
  AudioPlayer laserSound;
  Minim minim;
  AudioPlayer menuMusic;
  SoundManager(PApplet p) {
    minim = new Minim(p);
  }
  void loadAudios() {
    bulletSound = minim.loadFile("sounds/tiro.mp3");
    bulletSound.setGain(-15);
    buttonClick = minim.loadFile("sounds/click.mp3");
    companionSound = minim.loadFile("sounds/r2d2.mp3");
    creditMusic = minim.loadFile("sounds/creditos.mp3");
    easterEgg = minim.loadFile("sounds/montini.mp3");
    explosionSound = minim.loadFile("sounds/explosion.mp3");
    gameOverSound = minim.loadFile("sounds/death.mp3");
    laserSound = minim.loadFile("sounds/laser.mp3");
    menuMusic = minim.loadFile("sounds/menu.mp3");
    menuMusic.setGain(-10);
  }
  void playButtonClick() {
    buttonClick.rewind();
    buttonClick.play();
  }
  void playCreditMusic() {
    creditMusic.rewind();
    creditMusic.play();
  }
  void stopCreditMusic() {
    creditMusic.pause();
  }
  void playMenuMusic() {
    menuMusic.rewind();
    menuMusic.play();
    menuMusic.loop();
  }
  void stopMenuMusic() {
    menuMusic.pause();
  }
  void playEasterEgg() {
    easterEgg.rewind();
    easterEgg.play();
  }
  void playBulletSound() {
    bulletSound.rewind();
    bulletSound.play();
  }
  void playLaserSound() {
    laserSound.rewind();
    laserSound.play();
  }
  void playExplosionSound() {
    explosionSound.rewind();
    explosionSound.play();
  }
  void playCompanionSound() {
    companionSound.rewind();
    companionSound.play();
  }
}
