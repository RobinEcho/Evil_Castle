/*******************************************
key system inside game
********************************************/ 
  
  boolean battle_end = false;
  int round = 1, pid = 0, mid = 0, cur = 0;
  int enemy_count, elite_count;
  int move_count = 0;
  boolean can_move = false;

/*******************************************
move function, link to keyaction
********************************************/ 

void move() {
  if(frameCount % 2 == 0){
    p[0].change_map_img();
  }
    //println(move_count);
      if(up){
        if(move_count == 0){
          test_move();
          //println("test move up! " + can_move);
        }
        
        if(can_move){
          p[0].set_y(p[0].charY - sqh/5);
          
          move_count++;
          if(move_count == 5){
            move_count = 0;
            //steps++;
            up = false;
          }
          
          
        }else{
          up = false;
        }
        //move_count++;
        
      }
      
      if(down){
        if(move_count == 0){
          test_move();
          //println("test move down! " + can_move);
        }
        
        if(can_move){
          p[0].set_y(p[0].charY + sqh/5);
          
          move_count++;
          if(move_count == 5){
            move_count = 0;
            //steps++;
            down = false;
          }
          
        }else{
          down = false;
        }
        //move_count++;
        
      }
      
      if(right){
        if(move_count == 0){
          test_move();
          //println("test move right! " + can_move);
        }
        
        if(can_move){
          p[0].set_x(p[0].charX + sqw/5);
          move_count++;
          if(move_count == 5){
            move_count = 0;
            //steps++;
            right = false;
          }
        }else{
          right = false;
        }
        //move_count++;
        
      }
      
      if(left){
        if(move_count == 0){
          test_move();
          //println("test move left! " + can_move);
        }
        
        if(can_move){
          p[0].set_x(p[0].charX - sqw/5);
          move_count++;
          if(move_count == 5){
            move_count = 0;
            //steps++;
            left = false;
          }
        }else{
          left = false;
        }
        //move_count++;
        
      }
}                    //close move()
/*----------------------------------------------------------------------------------------------*/

     /* friendly_unit = 1 monster: 1-2
        friendly_unit = 2 monster: 2-3
        friendly_unit = 3 monster: 3-4
        
     
      */
void monsterappear() {
  if(room < 80)
  {
    
      encounter   = steps + r.nextInt(20);
      
      if(encounter >= 60){
        cur = 0;
        round = 1;
        inBattle = true;
        play_battle = true;
        battle_end = false;
        Units[] order;
        
        elite_count = r.nextInt(100) % floor;
        
        if(elite_count > 0){
          if(floor > 3){
            enemy_count =  r.nextInt(100) % 3 + 1;
          }else{
            enemy_count =  r.nextInt(100) % floor + 1;
          }
        }else{
          if(floor > 3){
            enemy_count =  r.nextInt(100) % 4 + 1;
          }else{
            enemy_count =  r.nextInt(100) % floor + 1;
          }
        }
        
        enemy_setup();
        
        room = 90;
                
        steps = 0;
        
        encounter = 0;
        
        order = round_order();
        
        for(int i = 0; i < order.length; i++){
          battle_list[i] = order[i];
        }
        
        //pid = 0;
        //battle_mode = 0;
          if(order[cur].get_type() == 1){
            pid = order[cur].get_id();
            
            battle_mode = 0;
          }else{
            mid = order[cur].get_id();
            
            battle_mode = -1;
          }
    }
  }  
}                    //close monsterappear()

void change_room(int cur_room){
  int loc_x, loc_y;
  
  loc_x = (int)p[0].charX / (int)sqw;
  loc_y = (int)p[0].charY / (int)sqh;
  
  switch(floor){
    case 1:
      if(floor_1[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_1[floor_room-1].exit[loc_y][loc_x] > floor_1.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_2/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
              if(floor_2[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_2[floor_room-1];
                new_location(j, i);
                
                i = floor_2[floor_room-1].exit.length-1;
                j = floor_2[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //move to connected room
        }else{
          floor_room = floor_1[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_1/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_1[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_1[floor_room-1].exit[i].length; j++){
              
              if(floor_1[floor_room-1].exit[i][j] == cur_room){
                map = floor_1[floor_room-1];
                new_location(j, i);
                
                i = floor_1[floor_room-1].exit.length-1;
                j = floor_1[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 2:
      if(floor_2[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_2[floor_room-1].exit[loc_y][loc_x] > floor_2.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_3/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
              if(floor_3[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_3[floor_room-1];
                new_location(j, i);
                
                i = floor_3[floor_room-1].exit.length-1;
                j = floor_3[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //go down 1 floor
        }else if(floor_2[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_2[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_1/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_1[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_1[floor_room-1].exit[i].length; j++){
              if(floor_1[floor_room-1].exit[i][j] == floor_1.length + 1){
                map = floor_1[floor_room-1];
                new_location(j, i);
                
                i = floor_1[floor_room-1].exit.length-1;
                j = floor_1[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_2[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_2/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
              
              if(floor_2[floor_room-1].exit[i][j] == cur_room){
                map = floor_2[floor_room-1];
                new_location(j, i);
                
                i = floor_2[floor_room-1].exit.length-1;
                j = floor_2[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 3:
      if(floor_3[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_3[floor_room-1].exit[loc_y][loc_x] > floor_3.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_4/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
              if(floor_4[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_4[floor_room-1];
                new_location(j, i);
                
                i = floor_4[floor_room-1].exit.length-1;
                j = floor_4[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //go down 1 floor
        }else if(floor_3[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_3[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_2/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
              if(floor_2[floor_room-1].exit[i][j] == floor_2.length + 1){
                map = floor_2[floor_room-1];
                new_location(j, i);
                
                i = floor_2[floor_room-1].exit.length-1;
                j = floor_2[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_3[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_3/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
              
              if(floor_3[floor_room-1].exit[i][j] == cur_room){
                map = floor_3[floor_room-1];
                new_location(j, i);
                
                i = floor_3[floor_room-1].exit.length-1;
                j = floor_3[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 4:
      if(floor_4[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_4[floor_room-1].exit[loc_y][loc_x] > floor_4.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_5/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_5[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_5[floor_room-1].exit[i].length; j++){
              if(floor_5[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_5[floor_room-1];
                new_location(j, i);
                
                i = floor_5[floor_room-1].exit.length-1;
                j = floor_5[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //go down 1 floor
        }else if(floor_4[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_4[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_3/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
              if(floor_3[floor_room-1].exit[i][j] == floor_3.length + 1){
                map = floor_3[floor_room-1];
                new_location(j, i);
                
                i = floor_3[floor_room-1].exit.length-1;
                j = floor_3[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_4[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_4/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
              
              if(floor_4[floor_room-1].exit[i][j] == cur_room){
                map = floor_4[floor_room-1];
                new_location(j, i);
                
                i = floor_4[floor_room-1].exit.length-1;
                j = floor_4[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 5:
      if(floor_5[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //go down 1 floor
        if(floor_5[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_5[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_4/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
              if(floor_4[floor_room-1].exit[i][j] == floor_4.length + 1){
                map = floor_4[floor_room-1];
                new_location(j, i);
                
                i = floor_4[floor_room-1].exit.length-1;
                j = floor_4[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_5[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_5/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_5[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_5[floor_room-1].exit[i].length; j++){
              
              if(floor_5[floor_room-1].exit[i][j] == cur_room){
                map = floor_5[floor_room-1];
                new_location(j, i);
                
                i = floor_5[floor_room-1].exit.length-1;
                j = floor_5[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
  }
}

void new_location(int x, int y){
  //println("floor: " + floor + " room: " + floor_room);
  move_count = 0;
  switch(p[0].dir){
    //up
    case 0:
      p[0].charX = sqw * x;
      p[0].charY = sqh * (y-1);
      up = false;
      break;
                    
    //right
    case 1:
      p[0].charX = sqw * (x+1);
      p[0].charY = sqh * y;
      right = false;
      break;
                    
    //down
    case 2:
      p[0].charX = sqw * x;
      p[0].charY = sqh * (y+1);
      down = false;
      break;
                    
   //left
   case 3:
     p[0].charX = sqw * (x-1);
     p[0].charY = sqh * y;
     left = false;
     break;
  }//end switch
}

void test_move(){
  int cur_x = (int)p[0].charX/sqw, cur_y = (int)p[0].charY/sqh;
  //println("testing!");
  switch(p[0].dir){
    //up
    case 0:
      //println("WALL up: " + map.wall[cur_y-1][cur_x]);
      can_move = !map.wall[cur_y-1][cur_x] && !map.npc[cur_y-1][cur_x];
      break;
                    
    //right
    case 1:
      //println("WALL right: " + map.wall[cur_y-1][cur_x]);
      can_move = !map.wall[cur_y][cur_x+1] && !map.npc[cur_y][cur_x+1];
      break;
                    
    //down
    case 2:
      //println("WALL down: " + map.wall[cur_y-1][cur_x]);
      can_move = !map.wall[cur_y+1][cur_x] && !map.npc[cur_y+1][cur_x];
      break;
                    
   //left
   case 3:
     //println("WALL left: " + map.wall[cur_y-1][cur_x]);
     can_move = !map.wall[cur_y][cur_x-1] && !map.npc[cur_y][cur_x-1];
     break;
     
   default:
     println("Player Direction Error!");
     can_move = false;
     break;
  }
}

void npc_on_map(){
      //companions
      if(floor == 1 && floor_room == 3){
        if(npc_in_cell[0])
          draw_NPC(13*sqw, 6*sqh, 0);
          
        if(npc_in_cell[1])
          draw_NPC(18*sqw, 6*sqh, 1);
        
        if(npc_in_cell[2])
          draw_NPC(23*sqw, 6*sqh, 2);
        
        if(npc_in_cell[3])
          draw_NPC(13*sqw, 15*sqh, 3);
        
        if(npc_in_cell[4])
          draw_NPC(18*sqw, 15*sqh, 4);
        
        if(npc_in_cell[5])
          draw_NPC(23*sqw, 15*sqh, 5);
      }
      
      //Boss
      if(floor == 1 && floor_room == 2){
        if(boss_defeated < 1){
          image(boss_img[floor - 1], 11 * sqw, 10 * sqh, sqw, sqh);
        }
      }else if(floor == 2 && floor_room == 4){
        if(boss_defeated < 2){
          image(boss_img[floor - 1], 19.5 * sqw, 5.75 * sqh, sqw * 1.5, sqh * 1.5);
        }
      }else if(floor == 3 && floor_room == 3){
        if(boss_defeated < 3){
          image(boss_img[floor - 1], 15 * sqw, 7 * sqh, sqw * 2, sqh * 2);
        }
      }else if(floor == 4 && floor_room == 7){
        if(boss_defeated < 4){
          image(boss_img[floor - 1], 20 * sqw, 9 * sqh, sqw, sqh);
        }
      }else if(floor == 5 && floor_room == 6){
        if(boss_defeated < 5){
          image(boss_img[floor - 1], 20 * sqw, 6 * sqh, sqw * 2, sqh * 2);
        }
      }
      
      //princess
      if(floor == 5 && floor_room == 7){
        image(princess, 18.5 * sqw, 6.5 * sqh, sqw * 1.3, sqh * 1.5);
      }
      
      //equipment safe
      if(floor == 2 && floor_room == 6){
        image(safe, 10 * sqw, 13 * sqh, sqw, sqh);
      }
      
      if(floor == 3 && floor_room == 3){
        image(item_list[98].img, 22 * sqw, 6 * sqh, sqw, sqh);
      }
      
      if(floor == 4 && floor_room == 8){
        image(safe, 10 * sqw, 13 * sqh, sqw, sqh);
      }
      
      if(floor == 5 && floor_room == 4){
        image(safe, 10 * sqw, 12 * sqh, sqw, sqh);
      }
}
