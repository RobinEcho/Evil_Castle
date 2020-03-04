String [] shop_option = {"Shop", "Save", "Leave"};
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
    
    try{
      profile = loadStrings("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("LOAD FAILED");
    }
    
    reset();
    
    font = loadFont("main_font.vlw");
    textFont(font);
    
    if(profile.length > 0){
      boss_defeated = Integer.parseInt(profile[0]);
      floor = Integer.parseInt(profile[1]);
      floor_room = Integer.parseInt(profile[2]);
      c_pt = Integer.parseInt(profile[3]);
      
       
      for(int i = 0; i < c_pt; i++){
        p[i] = new Player(Integer.parseInt(profile[4 + (i * 12)]));
        p[i].name = p[i].job.name;
        p[i].set_id(i);
        p[i].set_level(Integer.parseInt(profile[5 + (i * 12)]));
        p[i].set_exp(Float.parseFloat(profile[6 + (i * 12)]));
        p[i].set_flat_str(Float.parseFloat(profile[7 + (i * 12)]));
        p[i].set_flat_con(Float.parseFloat(profile[8 + (i * 12)]));
        p[i].set_flat_intel(Float.parseFloat(profile[9 + (i * 12)]));
        p[i].set_flat_wis(Float.parseFloat(profile[10 + (i * 12)]));
        p[i].set_flat_agi(Float.parseFloat(profile[11 + (i * 12)]));
        p[i].AP = Integer.parseInt(profile[12 + (i * 12)]);
        p[i].equipment[0] = Integer.parseInt(profile[13 + (i * 12)]);
        p[i].equipment[1] = Integer.parseInt(profile[14 + (i * 12)]);
        p[i].equipment[2] = Integer.parseInt(profile[15 + (i * 12)]);
        p[i].skills.skill_count = (p[i].get_level() / 5) + 1;
      }
        
        p[0].gold = Integer.parseInt(profile[(4 + c_pt * 12) + 1]);
        
        for(int i = 0; i < bag.inv.length; i++){
          for(int j = 0; j < bag.inv[i].length; j++){
            bag.inv[i][j] = Integer.parseInt(profile[(4 + c_pt * 12) + 1 + i * bag.inv[0].length + j]);
          }
        }
        
        
      p[0].set_img("player_2",1);
      p[0].name = "Adam";
      p[0].battle_img = loadImage("src/player/battle/Player.png");
      p[0].icon = loadImage("src/player/icon/Player.png");
      p[0].avatar = loadImage("src/player/avatar/player.png");
      p[0].set_loc(20*sqw,9*sqh);
      
      if(c_pt > 0){
        for(int i = 1; i < c_pt; i++){
          npc_in_cell[p[i].get_job_code() - 1] = false;
          
          switch(p[i].get_job_code()){
            case 1:
              floor_1[2].del_npc(13, 8);
              break;
              
            case 2:
              floor_1[2].del_npc(18, 8);
              break;
              
            case 3:
              floor_1[2].del_npc(23, 8);
              break;
              
            case 4:
              floor_1[2].del_npc(13, 13);
              break;
              
            case 5:
              floor_1[2].del_npc(18, 13);
              break;
              
            case 6:
              floor_1[2].del_npc(23, 13);
              break;
          }
        }
      }
      
      switch(floor){
        case 1:
          map = floor_1[floor_room - 1];
          break;
          
        case 2:
          map = floor_2[floor_room - 1];
          break;
          
        case 3:
          map = floor_3[floor_room - 1];
          break;
          
        case 4:
          map = floor_4[floor_room - 1];
          break;
          
        case 5:
          map = floor_1[floor_room - 1];
                  
          p[0].set_loc(26*sqw,11*sqh);
          break;
      }
      
      room = 2;
      saved = false;
      println("load save finish");
                  
    }else{
      println("no save");
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
    
    output.println(boss_defeated);
    output.println(floor);
    output.println(floor_room);
    output.println(c_pt);
    
    for(int i = 0; i < c_pt; i++){
      output.println(p[i].get_job_code());
      output.println(p[i].get_level());
      output.println(p[i].get_exp());
      output.println(p[i].get_flat_str());
      output.println(p[i].get_flat_con());
      output.println(p[i].get_flat_intel());
      output.println(p[i].get_flat_wis());
      output.println(p[i].get_flat_agi());
      output.println(p[i].AP);
      
      output.println(p[i].equipment[0]);
      output.println(p[i].equipment[1]);
      output.println(p[i].equipment[2]);
    }
    
    output.println(p[0].gold);
    
    for(int i = 0; i < bag.inv.length; i++){
      for(int j = 0; j < bag.inv[i].length; j++){
        output.println(bag.inv[i][j]);
      }
    }
    
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

void display_buff_icons(){
  int rows, shown = 0;
  
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
  
  //Draw enemies
  noStroke();
  for(int i = 0; i < enemy_count; i++){
    shown = 0;
    rows = m[i].active_buffs / 4 + 1;
    
    if(i != 0){
      if(i % 2 == 0){
        enemy_x += enemy_width * m[i-1].get_mod();
      }else{
        enemy_x -= enemy_width * m[i-1].get_mod();
      }
    }
    
    for(int j = 0; j < buff_count; j++){
      if(m[i].buff_round[j] > 0){
        image(buff_icon[j], enemy_x + enemy_width * m[i].mod + (shown % 4) * 25, enemy_y - (rows - (shown / 4)) * 25, 20, 20);
        shown++;
      }
    }
    
    enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0;
     
  }
  
  //Draw player images and player status
  for(int i = 0; i < c_pt; i++){
    shown = 0;
    rows = p[i].active_buffs / 4 + 1;
    
    //println(p[i].name + " has " + p[i].active_buffs + " number of buffs.");
    
    for(int j = 0; j < buff_count; j++){
      if(p[i].buff_round[j] > 0){
        image(buff_icon[j], p[i].battle_x - (shown % 4) * 25 - 25, p[i].battle_y - (rows - (shown / 4)) * 25, 20, 20);
        shown++;
      }
    }
    
  }
}

void loot(){
  int rand, loot_count = (enemy_count * (r.nextInt(floor) + floor / 3));
  int rand_med, rand_eq;
  int[] loots;
  
  if(loot_count > 0){
    loots = new int[loot_count];
    
    for(int i = 0; i < loots.length; i++){
      rand = r.nextInt(10000) % 100;
      
      //key for equipment
      if(rand < 10){
        println("key");
        loots[i] = 100;
        
      //gold
      }else if(rand < 29){
        println("gold");
        p[0].gold += r.nextInt(100) * floor;
        
      //potions
      }else if(rand < 80){
        println("med");
        rand_med = r.nextInt(100);
        
        if(rand_med < 30){
          loots[i] = 90;
        }else if(rand_med < 60){
          loots[i] = 93;
        }else if(rand_med < 75){
          loots[i] = 91;
        }else if(rand_med < 90){
          loots[i] = 94;
        }else if(rand_med < 95){
          loots[i] = 92;
        }else{
          loots[i] = 95;
        }
      
      //equipment
      }else{
        println("equipment");
          rand_eq = r.nextInt(1000) % c_pt;
          
          rand = r.nextInt(100) % (floor - 1);
          
          loots[i] = (p[rand_eq].job_code * 100) + ((r.nextInt(3) + 1) * 10) + (rand + 1);
          
          for(int j = 0; j < item_list.length; j++){
            if(item_list[j].get_id() == loots[i]){
              loots[i] = j;
            }
          }
      }
      
      for(int j = 0; j < bag.inv.length; j++){
        for(int k = 0; k < bag.inv[j].length; k++){
          if(bag.inv[j][k] == item_count - 1){
            bag.inv[j][k] = loots[i];
            j = bag.inv.length - 1;
            k = bag.inv[j].length - 1;
          }else if(j == bag.inv.length - 1 && k == bag.inv[j].length - 1){
            println("Bag Full!");
            i = loots.length - 1;
          }
        }
      }
    }
    
  }else{
    println("empty loot");
  }
}

void shop_menu(){
  text_height = 40;
  boxwidth = 240;
  boxheight = 360;
    
  boxX = (width-boxwidth)/2;
  boxY = (height-boxheight)/2;
    
  fill(60, 100, 100, 60);
  noStroke();
  rect(boxX,boxY,boxwidth,boxheight,30);
    
  fill(90, 80, 80, 80);
  textSize(text_height);
  textAlign(CENTER);
  for(int i =0; i<3;i++)
  {
    text(shop_option[i],boxX+(boxwidth/2),boxY+i*(text_height+30)+boxheight/3);
  }
    
  mainY = boxY+boxheight/3;
  saveY = mainY + 70;
  exitY = saveY + 70;
}

void recover(){
  for(int i = 0; i < c_pt; i++){
    p[i].rec_hp(p[i].get_max_hp());
    p[i].rec_mp(p[i].get_max_mp());
    p[i].calc_stats();
  }
}

void boss_fight(){
  play_battle = true;
  boss_battle = true;
  
  
  switch(floor){
    case 1:
      enemy_count = 1;
      m[0].setMType(3);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      m[0].set_patk(1);
      m[0].set_pdef(5);
      m[0].set_mdef(5);
      m[0].set_mdef(5);
      break;
      
    case 2:
      enemy_count = 1;
      m[0].setMType(3);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(10);
      m[0].init_stats();
      m[0].set_patk(30);
      m[0].set_pdef(50);
      m[0].set_matk(80);
      m[0].set_mdef(65);
      m[0].set_max_hp(500);
      m[0].set_max_mp(800);
      break;
      
    case 3:
      enemy_count = 2;
      m[0].setMType(2);
      m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      //m[0].set_level(1);
      m[0].init_stats();
      
      m[1].setMType(3);
      m[1].set_level(floor * 5);
      //m[1].set_level(1);
      m[1].init_stats();
      break;
      
    case 4:
      enemy_count = 3;
      m[0].setMType(1);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      
      m[1].setMType(3);
      //m[1].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[1].set_level(1);
      m[1].init_stats();
      
      m[2].setMType(1);
      //m[2].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[2].set_level(1);
      m[2].init_stats();
      break;
      
    case 5:
      enemy_count = 3;
      m[0].setMType(2);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      
      m[1].setMType(3);
      //m[1].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[1].set_level(1);
      m[1].init_stats();
      
      m[2].setMType(2);
      //m[2].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[2].set_level(1);
      m[2].init_stats();
      break;
  }
  
  cur = 0;
  round = 1;
  inBattle = true;
  battle_end = false;
  Units[] order;
        
  room = 90;
  order = round_order();
        
  for(int i = 0; i < order.length; i++){
    battle_list[i] = order[i];
  }
        
  if(order[cur].get_type() == 1){
    pid = order[cur].get_id();
            
    battle_mode = 0;
  }else{
    mid = order[cur].get_id();
            
    battle_mode = -1;
  }
}

void equipment_safe(){
  int free = 0, rand;
  int[] eq = new int[3];
  
  if(box_key){
  
    //count free slots in bag
    for(int i = 0; i < bag.inv.length; i++){
        for(int j = 0; j < bag.inv[i].length; j++){
          if(bag.inv[i][j] == item_count - 1){
            free++;
          }
        }
    }
    
    //no room
    if(free < eq.length){
      
      room = 84;
      
    //get item
    }else{
      
      for(int i = 0; i < eq.length; i++){
        rand = r.nextInt(1000) % c_pt;
        
        eq[i] = (p[rand].job_code * 100) + ((r.nextInt(3) + 1) * 10) + boss_defeated;
        
        for(int j = 0; j < bag.inv.length; j++){
          for(int k = 0; k < bag.inv[j].length; k++){
            
            //remove key from bag
            if(bag.inv[j][k] == 100){
              bag.inv[j][k] = item_count - 1;
            }
            
            //put item in bag
            if(bag.inv[j][k] == item_count - 1){
              
              for(int x = 0; x < item_list.length; x++){
                if(eq[i] == item_list[x].id){
                  bag.inv[j][k] = x;
                }
              }
                
              j = bag.inv.length - 1;
              k = bag.inv[j].length - 1;
              
            }//end if
            
          }//end for k
        }//end for j
      }//end for i
      
      box_key = false;
      
      room = 83;
    }//end else on free equipment
    
  //no key
  }else{
    fill(60,100,100);
    rect(width/2 - 200, height / 2 - 100, 400, 200);
    fill(0, 0, 100);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("You need a key!", width/2, height/2);
  }
}
