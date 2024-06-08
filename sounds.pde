import ddf.minim.*;

class SoundManager{
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
  
  //MENU
  void playMenuMusic(){
    menuMusic = minim.loadFile("sounds/menu.mp3"); 
    menuMusic.play();
    menuMusic.loop();
  }
  
  void playShotSound(){
    float randomValue = random(0, 1); 
    
    if(randomValue == 0){
      shotSound = minim.loadFile("sounds/tiro1.mp3");
    }else{
      shotSound = minim.loadFile("sounds/tiro2.mp3");      
    }
    shotSound.setGain(-15);
    shotSound.play();
  }
  
  void playEasterEgg(){
    easterEgg = minim.loadFile("sounds/montini.mp3");
    easterEgg.play();
  }
  
  void playLaser(){
    laser = minim.loadFile("sounds/laser.mp3");
    laser.play();
  }
  
  void playR2d2(){
    r2d2 = minim.loadFile("sounds/r2d2_1.mp3");
    r2d2.play();
  }
  
  void stopMenuMusic(){
    menuMusic.close();
  }
  
  void playExplosion(){
    explosion = minim.loadFile("sounds/explosion.mp3");
    explosion.play();
  }
  
  void playButtonClick(){
    buttonClick = minim.loadFile("sounds/click.mp3");
    buttonClick.play();
  }
  
  //CREDITOS
  void playCreditMusic(){
    creditMusic = minim.loadFile("sounds/creditos.mp3");
    creditMusic.play();
  }
  
  void stopCreditMusic(){
    creditMusic.close();
  }
}
