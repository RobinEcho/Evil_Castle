/*******************************************
drawfunction, base on variable room to know where we are
********************************************/ 
int battle_mode = 0;
String [] options = {"Main Menu", "Load", "Quit"};
String[] job_list = {"Knight", "Paladin", "Ranger", "Assassin", "Mage", "Priest"};
int mainY, saveY, exitY, text_height;
float bagoptX, bagoptY;
float pc_width, pc_height, pcx, pcy, hp_percent;
  float enemy_width, enemy_height, enemy_start_x, enemy_start_y, enemy_x, enemy_y;
  float command_x, command_y, command_radius;
  float target_diameter;
  float tri_width, tri_height;
  boolean no_move = false;
  

  /*******************************************
            Main menu
  ********************************************/


 void menu(){
  
    font = loadFont("menu_font.vlw");
    
    textAlign(CENTER,CENTER);
    textFont(font);
    
  //should be replaced by image
    background(0);
  //
  
    textSize(60);
    text("Evil Castle",side_margin,height_margin/2);
                                  
    textSize(30);
    text("New Game", side_margin, height_margin);
                                  
    textSize(30);
    text("Load Game", side_margin, height_margin+150);
                                  
    textSize(30);
    text("Exit", side_margin, height_margin+300);
 
    
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
    noStroke();
    rect(boxX,boxY,boxwidth,boxheight,9);
    stroke(0);
    textAlign(CENTER, CENTER);
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
    noStroke();
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
    strokeWeight(1);
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
  battle_end();
  
  pc_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt + 1);
  pc_height = (height*2/3 - 3.0f * battle_UI_margin)/ (float)(max_pt + 2);
  pcx = width*2/3.0f + battle_UI_margin + (float)(max_pt/2.0) * pc_width;
  pcy = battle_UI_margin + pc_height/2.0f;
  
  enemy_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt+1);
  enemy_height = (height*2/3.0f - 3.0f * battle_UI_margin)/ (float)(max_pt+2);
  enemy_start_x = battle_UI_margin + (float)enemy_width;
  enemy_start_y = battle_UI_margin + enemy_height/2.0f;
  enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
  enemy_y = enemy_start_y;
  
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
  noStroke();
  for(int i = 0; i < enemy_count; i++){
    if(i == 0){
      if(m[0].is_alive()){
        image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }else{
        fill(0,100,100);
        rect( enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
      }
    }else{
      
      if(i % 2 == 0){
        enemy_x += enemy_width * m[i-1].get_mod();
      }else{
        enemy_x -= enemy_width * m[i-1].get_mod();
      }
      
      if(m[i].is_alive()){
        image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }else{
        fill(0,100,100);
        rect( enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }
    }
    
    enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0;
    //println("mob lv: " + m[i].get_level() + " patk: " + m[i].get_patk());
  }
  
  //Draw player status boxes
  p_box();
  
  //Draw player images and player status
  for(int i = 0; i < c_pt; i++){
    if(p[i].is_alive()){
      p[i].battle_x = i*pc_width/2.0f + pcx;
      p[i].battle_y = i*pc_height*1.5f + pcy;
      
      image(p[i].battle_img, p[i].battle_x, p[i].battle_y, pc_width, pc_height);
      
      //over head hp bar
      hp_percent = (float)p[i].get_cur_hp() / (float)p[i].get_max_hp();
      strokeWeight(1);
      stroke(0,100,0);
      fill(0,0,100);
      rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width, battle_UI_margin, 50);
      fill(0,100,100);
      rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width * hp_percent, battle_UI_margin, 50);
    }
      
        //player stats
        p_stats(i);
      
    }
    
    stroke(0, 100, 100);
    fill(0, 100, 100);
    textSize(30);
    textAlign(CENTER);
    text("ROUND: " + round, width/2, p[0].vertical_margin/2);
    
    unit_turn();
    display_buff_icons();
    /*****************************
    *  battle round starts
    *****************************/
    switch(battle_mode){
      //player turn start draw commands
      case 0:
        if(battle_list[cur].is_alive()){
          if(battle_list[cur].can_move){
            no_move = false;
            battle_command_UI();
          }else{
            no_move = true;
            battle_mode = 10;
          }
        }else{
          battle_mode = 10;
          println("player dead");
        }
        break;
        
      //player chooses attack target
      //image(m[i].img, enemy_x - i*enemy_width/2.0f, enemy_y + i*enemy_height*1.5f, enemy_width, enemy_height);
      case 1:
        enemy_selection();
        
        break;
      
      //player uses skill
      case 2:
        battle_command_UI();
        skill_box_width = command_radius * 1.5;
        skill_box_height = height * 2 / (command_radius/4.0);
        //println("cur: " + battle_list[cur].name);
        for(int i = 0; i < p[battle_list[cur].get_id()].skills.skill_count; i++){
           fill(65, 100, 100);
           rect(command_x + command_radius * 1.5 + battle_UI_margin, command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5)), skill_box_width, skill_box_height);
           fill(0,0,100);
           textSize(skill_box_height/3);
           textAlign(CENTER, CENTER);
           text(p[battle_list[cur].get_id()].skills.skill[i].name, command_x + command_radius * 1.5 + battle_UI_margin + skill_box_width/2, command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5)) + skill_box_height/2);
        }
        skill_desc();
      break;
      
      //player uses item
      case 3:
        select_item = false;
        bag.BagSquare(2);
        if(!usable){
          not_usable();
        }
        
        if(!select_item)
        {
           item_desc(2);
        }
        break;
      
      //player selects target
      case 4:
        ally_selection();
        
        break;
        
      case -1:
        if(battle_list[cur].is_alive()){
          if(battle_list[cur].can_move){
            no_move = false;
            println("monster round");
            switch(m[mid].getMType()){
              case 1:
                normal.attack_mode();
                break;
              case 2:
              normal.attack_mode();
                break;
              case 3:
              normal.attack_mode();
                break;
            }
          }else{
            no_move = true;
          }
        }else{
          println("monster dead");
        }
        battle_mode = 10;
        break;
      
      
      //battle turn & round end
      case 10:
        
        if(frameCount - start_frame < 100){
            for(int i = 0; i < max_pt; i++){
              if(hit[i] != -1){
                display_damage(hit[i], ((battle_list[cur].get_type() + 1) % 2));
              }
            }
            
            //for(int i = 0; i < c_pt; i++){
            //  println("Name: " + p[i].name + " is alive: " + p[i].is_alive());
            //}
        }
        else{
          esc = true;
          arrive = false;
          returned = false;
          if(battle_list[cur].buff_round[12] <= 0){
            cur++;
            if(cur >= (c_pt + enemy_count)){
              cur = 0;
              round++;
              
              check_buff_status();
              hit_set();
              
              for(int i = 0; i < (c_pt + enemy_count); i++){
                battle_list[i] = round_order()[i];
              }
              //println("cur pdef: " + p[0].get_pdef());
            }
            
          //Assassin delay move buff
          }else{
            Units temp;
            battle_list[cur].calc_buff();
            for(int i = cur; i < (c_pt + enemy_count) - 1; i++){
                temp = battle_list[i];
                battle_list[i] = battle_list[i + 1];
                battle_list[i + 1] = temp;
              }
          }
          
          if(battle_list[cur].get_type() == 0){
            mid = battle_list[cur].get_id();
            battle_mode = -1;
          }else{
            pid = battle_list[cur].get_id();
            battle_mode = 0;
          }
        }
        
      break;     
    }
  
}

/*************************************************
*  Draw Battle Command UI
**************************************************/
void battle_command_UI(){
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
}
      /*******************************************
             alies and player status pannel
      ********************************************/
  
void p_box(){
  fill(80, 80, 100);
  
  for(int i = 0; i < max_pt; i++){
    cx = c_width*i + (i+1)*battle_UI_margin;
    rect(cx, cy, c_width, c_height);
  }
}

  void p_stats(int c){
    cx = c_width*c + (c+1)*battle_UI_margin;
    fill(0,0,100);
    textAlign(CENTER);
    text(p[c].name, cx + c_width/2, cy + c_height/4);
    text("HP: " + (int)p[c].cur_hp + " / " + (int)p[c].max_hp, cx + c_width/2, cy + c_height/2);
    text("MP: " + (int)p[c].cur_mp + " / " + (int)p[c].max_mp, cx + c_width/2, cy + c_height*3/4);
  }
  
  /*****************************************************
  *  select enemy circle
  *****************************************************/
void enemy_selection(){
  enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
        enemy_y = enemy_start_y;
        target_diameter = (float)Math.sqrt( 2*(Math.pow((double)enemy_width,2.0)) );
        strokeWeight(3);
        stroke(0,100,100);
        fill(0,100,100,0);
        
        for(int i = 0; i < enemy_count; i++){
          if(i > 0){
            if(i % 2 == 0){
              enemy_x += enemy_width * m[i-1].get_mod();
            }else{
              enemy_x -= enemy_width * m[i-1].get_mod();
            }
          }
          
          if(m[i].is_alive()){
            ellipse(enemy_x + (enemy_width/2.0f * m[i].get_mod()), enemy_y + enemy_height/2.0 * m[i].get_mod(), target_diameter * m[i].get_mod(), target_diameter * m[i].get_mod());
          }
          enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0;
        }
}

    /*****************************************************
  *  select ally triangle
  *****************************************************/
void ally_selection(){
  noStroke();
        fill(32, 80, 100);
        tri_width = c_width * 0.1;
        tri_height = tri_width * 1.5;
        
        //when using skill
        if(command != 7){
          //0 use on self only, 1 use on ally
          switch(battle_list[cur].skills.skill[command].type){
              case 0:
                for(int i = 0; i < c_pt; i++){
                  cx = c_width*i + (i+1)*battle_UI_margin;
                  if(p[i] == battle_list[cur]){
                    triangle(cx + c_width/2, cy - battle_UI_margin, cx + c_width/2 - tri_width, cy - battle_UI_margin - tri_height, cx + c_width/2 + tri_width, cy - battle_UI_margin - tri_height);
                  }  
                }
                break;
                
              case 1:
                for(int i = 0; i < c_pt; i++){
                  cx = c_width*i + (i+1)*battle_UI_margin;
                  
                  //if priest uses revive
                  if(p[battle_list[cur].get_id()].job_code == 6 && command == 5){
                    if(!p[i].is_alive()){
                      triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
                    }
                    
                  //if other skills
                  }else{
                    if(p[i].is_alive()){
                      triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
                    }
                  }
                }
                break;
          }
          
        //when using item
        }else{
          for(int i = 0; i < c_pt; i++){
            cx = c_width*i + (i+1)*battle_UI_margin;
            
            if(item_list[bag.inv[bag_y][bag_x]].id != 39){
              if(p[i].is_alive()){
                triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
              }
            }else{
              if(!p[i].is_alive()){
                triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
              }
            }
          }
        }
}
