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
