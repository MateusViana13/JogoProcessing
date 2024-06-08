import ddf.minim.*;

class SoundManager{
  Minim minim;
  
  //SONS
  AudioPlayer menuMusic;
  AudioPlayer creditMusic;
  AudioPlayer shotSound;
  
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
  
  void stopMenuMusic(){
    menuMusic.close();
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
