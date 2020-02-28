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
          battle_list[i].calc_buff();
          //println(battle_list[i].name + " buff round --");
          battle_list[i].buff_round[j]--;
          
          //println("buff " + i + " round left: " + battle_list[i].buff_round[j]);
          
          if(battle_list[i].buff_round[j] == 0){
            buff_end(i, j);
          }
        }
      }
    }
}

void buff_end(int target, int loc){
    
    //println("end buff");
    battle_list[target].buff_list[loc] *= -1;
    battle_list[target].calc_buff();
    battle_list[target].buff_list[loc] = 0;
    
}

void skill_desc(){
  String[] skill_type = {"true damage","physical damage", "magic damage", "recovery hp,mp", "buff"};
  for(int i = 0; i < p[battle_list[cur].get_id()].skills.skill_count; i++){
    if(mouseX >= (command_x + command_radius * 1.5 + battle_UI_margin) && mouseX <= (command_x + command_radius * 1.5 + battle_UI_margin) + skill_box_width
      && mouseY >= (command_y + skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5)) && mouseY <= (command_y + skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5)) + skill_box_height){
        fill(12,70,90);
        rect(c_width + 2*battle_UI_margin, cy, c_width * 2 + battle_UI_margin, c_height*2/3);
        
        textSize(30);
        fill(0,100,0);
        textAlign(LEFT,TOP);
        text("Skill Type: " + skill_type[p[battle_list[cur].get_id()].skills.skill[i].dmg_type], width/2 - c_width, cy + battle_UI_margin);
        
        textAlign(RIGHT,TOP);
        text("Cost: " + p[battle_list[cur].get_id()].skills.skill[i].mp_dec, width/2 + c_width, cy + battle_UI_margin);
        
        textAlign(CENTER,CENTER);
        text(p[battle_list[cur].get_id()].skills.skill[i].description, width/2, cy + c_height/3);
        
      }
  }
}

void unit_turn(){
  fill(0, 100, 100);
  textAlign(CENTER, CENTER);
  textSize(25);
  text(battle_list[cur].name + "\'s", command_x, command_y);
  text("turn", command_x, command_y + 35);
}

void draw_NPC(int x, int y, int target){
  image(npc[target], x - sqw/4, y - sqh/3, sqw + sqw/4, sqh + sqh/3);
}

void NPC_join(){
  noStroke();
  fill(60,100,100);
  rect(width*0.2, height*2/3, width * 0.6, height / 3 - 10, 30);
  
  fill(0,0,100);
  textSize(30);
  textAlign(CENTER, CENTER);
  
  if(new_companion == 0){
    text("You need a key to open this door!", width/2, height*2/3 + (height / 3 - 10)/2);
  }else{
    fill(60,100,100);
    rect(width*0.2, height/ 2, 100, 100, 30);
    fill(0,0,100);
    text("YES", width*0.2 + 50, height/ 2 + 50);
    
    fill(60,100,100);
    rect(width*0.8 - 100, height/ 2, 100, 100, 30);
    fill(0,0,100);
    text("NO", width*0.8 - 50, height/ 2 + 50);
  }
  
  fill(0,0,100);
  switch(new_companion){
    
    case 1:
      text("would you like Knight to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 2:
      text("would you like Paladin to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 3:
      text("would you like Ranger to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 4:
      text("would you like Assassin to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 5:
      text("would you like Mage to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 6:
      text("would you like Priest to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
  }
}
