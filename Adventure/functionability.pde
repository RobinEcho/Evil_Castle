   /*******************************************
     function about game data
  ********************************************/ 
 
 
 void newGame(){
    
     font = loadFont("main_font.vlw");
     textFont(font);
    
    saved = false;
    
    room = 1;
    jobchoicestyle();   
  }                    //close newGame()
  
  
  void load(){
    
    font = loadFont("main_font.vlw");
    textFont(font);
    
    if(profile.length != 0){
      for(int i = 0; i < profile.length; i++){
        text(profile[i], 300, 300);
      }
    }else{
      
      saved = true;
      
    }
  }                    //close load()
  
  
  void saveData(){
    File f = new File(dataPath("bin/characterdata"), "saveddata.txt");
    f.delete();
    try{
      output = createWriter("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("SAVE FAILED");
    }
    output.println(p[0].job.code);
    output.println(p[0].level);
    output.println(p[0].exp);
    output.close();
  }                    //close saveData()
  
void check_buff_status(){
    
    for(int i = 0; i < (c_pt + enemy_count); i++){
      for(int j = 0; j < buff_count; j++){
        
        if(battle_list[i].buff_round[j] > 0){
          battle_list[i].buff_round[j]--;
        }
        
        if(battle_list[i].buff_round[j] == 0){
          buff_end(i, j);
        }
      }
    }
}

void buff_end(int target, int loc){
    
    println("end buff");
    battle_list[target].buff_list[loc] = 0;
    
}
