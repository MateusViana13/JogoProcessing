import ddf.minim.*;

class SoundManager {
  Minim minim;

  //SONS
  AudioPlayer menuMusic;
  AudioPlayer creditMusic;
  AudioPlayer shotSound;
  AudioPlayer easterEgg;
  AudioPlayer r2d2;
  AudioPlayer laser;
  AudioPlayer explosion;
  AudioPlayer buttonClick;

  SoundManager(PApplet p) {
    minim = new Minim(p);
  }

  void loadAudios() {
    // Carregar os sons uma vez durante a inicialização
    menuMusic = minim.loadFile("sounds/menu.mp3");
    shotSound = minim.loadFile("sounds/tiro2.mp3");
    shotSound.setGain(-15);
    easterEgg = minim.loadFile("sounds/montini.mp3");
    laser = minim.loadFile("sounds/laser.mp3");
    r2d2 = minim.loadFile("sounds/r2d2_1.mp3");
    explosion = minim.loadFile("sounds/explosion.mp3");
    buttonClick = minim.loadFile("sounds/click.mp3");
    creditMusic = minim.loadFile("sounds/creditos.mp3");
  }

  //MENU
  void playMenuMusic() {
    menuMusic.rewind();
    menuMusic.play();
    menuMusic.loop();
  }

  void playShotSound() {
    shotSound.rewind();
    shotSound.play();
  }

  void playEasterEgg() {
    easterEgg.rewind();
    easterEgg.play();
  }

  void playLaser() {
    laser.rewind();
    laser.play();
  }

  void playR2d2() {
    r2d2.rewind();
    r2d2.play();
  }

  void stopMenuMusic() {
    menuMusic.pause();
  }

  void playExplosion() {
    explosion.rewind();
    explosion.play();
  }

  void playButtonClick() {
    buttonClick.rewind();
    buttonClick.play();
  }

  //CREDITOS
  void playCreditMusic() {
    creditMusic.rewind();
    creditMusic.play();
  }

  void stopCreditMusic() {
    creditMusic.pause();
  }
}
