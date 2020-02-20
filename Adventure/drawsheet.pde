/*******************************************
drawfunction, base on variable room to know where we are
********************************************/ 
int mode = 0;
String [] options = {"Main Menu", "Save", "Quit"};
String[] job_list = {"Knight", "Priest", "Mage", "Paladin", "Ranger", "Assassin"};
int mainY, saveY, exitY, text_height;
float bagoptX, bagoptY;
float pc_width, pc_height, pcx, pcy, hp_percent;
  float enemy_width, enemy_height, enemy_x, enemy_y;
  float command_x, command_y, command_radius;
  
  

  /*******************************************
            Main menu
  ********************************************/


 void menu(){
  
    font = loadFont("menu_font.vlw");
    
    textFont(font);
    
  //should be replaced by image
    background(0);
  //
  
    textSize(60);
    text("Game Title",side_margin,height_margin/2);
                                  
    textSize(30);
    text("New Game", side_margin, height_margin);
                                  
    textSize(30);
    text("Load Game", side_margin, height_margin+200);
                                  
    textSize(30);
    text("Exit", side_margin, height_margin+400);
 
    
  }                    //close menu()
  
  
  /*******************************************
            job choice while newgame()
  ********************************************/
  
  void jobchoicestyle(){
    background(0);
   
    text_height =25;
    boxwidth = 240;
    boxheight = 360;
    
    boxX = (width-boxwidth)/2;
    boxY = (height-boxheight)/2;
    
    textSize(45);
    text("Please choose your job",boxX+boxwidth/2,50);
    
    fill(33,50);
    rect(boxX,boxY,boxwidth,boxheight,9);
    textAlign(CENTER);
    textSize(text_height);
    for(int i =0; i<total_jobs;i++)
    {
      fill(40,100);
      text(job_list[i],boxX+boxwidth/2,i*60+boxY+40);
      
    }
              
  }                  //close jobchoicestyle()
  
  
  void option(){
    
    text_height = 40;
    
    fill(60, 100, 100, 60);
    rect(boxX,boxY,boxwidth,boxheight,30);
    
    fill(90, 80, 80, 80);
    textSize(text_height);
    textAlign(CENTER);
    for(int i =0; i<3;i++)
    {
      text(options[i],boxX+(boxwidth/2),boxY+i*(text_height+30)+boxheight/3);
    }
    
    mainY = boxY+boxheight/3;
    saveY = mainY + 70;
    exitY = saveY + 70;
  }                    //close option()
  
  
  void bag_option(){
    
    fill(12,100,100);
    rect(bagoptX,bagoptY,bag.square_width*3,bag.square_height*3);
    
    textAlign(CENTER, CENTER);
    fill(255,100,100);
    stroke(4);
    textSize(24);
    text("USE",bagoptX + bag.square_width*1.5, bagoptY + bag.square_height*0.5);
    line(bagoptX, bagoptY + bag.square_height, bagoptX+ bag.square_width*3, bagoptY + bag.square_height);
    text("DROP",bagoptX + bag.square_width*1.5, bagoptY + bag.square_height*1.5);
    line(bagoptX, bagoptY + bag.square_height*2, bagoptX + bag.square_width* 3, bagoptY + bag.square_height*2);
    text("CANCEL",bagoptX + bag.square_width*1.5, bagoptY + bag.square_height*2.5);
     
  }                    //close bag_option()
  
  /*******************************************
       UI while battle
  ********************************************/
      
  void battle_UI(int enemy_count){
   
  PImage test = loadImage("src/player/Mage.png");
  
  
  pc_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt + 1);
  pc_height = (height*2/3 - 3.0f * battle_UI_margin)/ (float)(max_pt + 2);
  pcx = width*2/3.0f + battle_UI_margin + (float)(max_pt/2.0) * pc_width;
  pcy = battle_UI_margin + pc_height/2.0f;
  
  enemy_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt+1);
  enemy_height = (height*2/3.0f - 3.0f * battle_UI_margin)/ (float)(max_pt+2);
  enemy_x = battle_UI_margin + (float)(enemy_count-1) * enemy_width;
  enemy_y = battle_UI_margin + enemy_height/2.0f;
  
  command_radius = (width/3.0f - 4.0f * battle_UI_margin)/ 4.0;
  command_x = width/2.0f;
  command_y = height/3.0f + battle_UI_margin/2.0; 
  
  textSize(40);
  background(0,0,100);
  /*
  fill(66, 100, 100);
  rect(battle_UI_margin, battle_UI_margin, width/2 - 2 * battle_UI_margin, height*2/3 - 2 * battle_UI_margin);
  
  fill(40, 100, 100);
  rect(width/2 + battle_UI_margin, battle_UI_margin, width/2 - 2 * battle_UI_margin, height*2/3 - 2 * battle_UI_margin);
  */
  
  //Draw enemies
  for(int i = 0; i < enemy_count; i++){
    image(m[i].img, enemy_x - i*enemy_width/2.0f, enemy_y + i*enemy_height*1.5f, enemy_width, enemy_height);
    //println("mob lv: " + m[i].get_level() + " patk: " + m[i].get_patk());
  }
  
  //Draw player status boxes
  for(int i = 0; i < max_pt; i++){
    cx = c_width*i + (i+1)*battle_UI_margin;
    p_box();
  }
  
  //Draw player images and player status
  for(int i = 0; i < c_pt; i++){
    image(p[i].img, i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy, pc_width, pc_height);
    
    //over head hp bar
    hp_percent = (float)p[i].get_cur_hp() / (float)p[i].get_max_hp();
    strokeWeight(1);
    stroke(0,100,0);
    fill(0,0,100);
    rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width, battle_UI_margin, 50);
    fill(0,100,100);
    rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width * hp_percent, battle_UI_margin, 50);
    
   // if(death){
    
       
    
    //}
    
    
    
    //player stats
    cx = c_width*i + (i+1)*battle_UI_margin;
    p_stats(i);
  }
  
  //if(mode == 1){
    strokeWeight(battle_UI_margin);
    stroke(24, 100, 100);
    fill(12, 50,100,20);
    ellipse(command_x, command_y, command_radius * 2, command_radius * 2);
    for(int i = 0; i < 4; i++){
      if(i % 2 == 0){
        noStroke();
        fill(65, 100, 100);
        ellipse(command_x, command_y + (i - 1) * command_radius, command_radius, command_radius);
      }else{
        noStroke();
        fill(65, 100, 100);
        ellipse(command_x + (i - 2) * command_radius, command_y, command_radius, command_radius);
      }
      
      switch(i){
        case 0:
          textSize(command_radius/ 3.0);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Attack", command_x, command_y + (i - 1) * command_radius);
          break;
        case 1:
          textSize(command_radius/ 3.0);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Item", command_x + (i - 2) * command_radius, command_y);
          break;
        case 2:
          textSize(command_radius/ 3.0);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Flee", command_x, command_y + (i - 1) * command_radius);
          break;
        case 3:
          textSize(command_radius/ 3.0);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Skill", command_x + (i - 2) * command_radius, command_y);
          break;
      }
    }
    
    switch(mode){
      case 2:
        skill_box_width = command_radius * 1.5;
        skill_box_height = height * 2 / (command_radius/4.0);
        for(int i = 0; i < 6; i++){
           fill(65, 100, 100);
           rect(command_x + command_radius * 1.5 + battle_UI_margin, command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5)), skill_box_width, skill_box_height);
           fill(0,0,100);
           textSize(skill_box_height/2);
           textAlign(CENTER, CENTER);
           //text(p[0].skills.skill[i].name, command_x + command_radius * 1.5 + battle_UI_margin + skill_box_width/2, command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5)) + skill_box_height/2);
        }
      break;
      
      case 3:
        bag.BagSquare(2);
        if(move_item){
          image(item_pic[temp_item_code], mouseX - (bag.square_width/2), mouseY - (bag.square_height/2), bag.square_width, bag.square_height);
        }
        break;
    }
  //}
}



      /*******************************************
             alies and player status pannel
      ********************************************/
  
  void p_box(){
  fill(80, 80, 100);
  rect(cx, cy, c_width, c_height);
}

  void p_stats(int c){
    fill(0,0,100);
    textAlign(CENTER);
    text(p[c].job.name, cx + c_width/2, cy + c_height/4);
    text("HP: " + p[c].cur_hp + " / " + p[0].max_hp, cx + c_width/2, cy + c_height/2);
    text("MP: " + p[c].cur_mp + " / " + p[0].max_mp, cx + c_width/2, cy + c_height*3/4);
  }
