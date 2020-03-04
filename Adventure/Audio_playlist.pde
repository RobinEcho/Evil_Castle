public void audio_init(){      
  for(int i = 0; i < 5; i++){
    boss_bgm[i] = new SoundFile(this, "boss" + (i+1) + ".mp3");
  }
  
    bgm = new SoundFile(this, "BGM.mp3");
    battle_bgm = new SoundFile(this, "battle.mp3");
    ending = new SoundFile(this, "end.mp3");
    menu = new SoundFile(this, "main_menu.mp3");
}
