import ddf.minim.*;

class SoundManager{
  Minim minim;
  
  //SONS
  AudioPlayer menuMusic;
  AudioPlayer creditMusic;
  
  SoundManager(PApplet p) {
    minim = new Minim(p);
  }
  
  //MENU
  void playMenuMusic(){
    menuMusic = minim.loadFile("sounds/menu.mp3"); 
    menuMusic.play();
    menuMusic.loop();
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
