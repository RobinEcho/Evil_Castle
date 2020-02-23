/*******************************************
key system inside game
********************************************/ 
  
  boolean battle_end = false;
  int round = 1, pid = 0, mid = 0, cur = 0;
  int enemy_count, elite_count;
  int move_count = 0;

/*******************************************
move function, link to keyaction
********************************************/ 

void move() {
      if(up){
        p[0].set_y(p[0].charY - 45);
        
        //if(move_count == 4){
        //  move_count = 0;
          steps++;
          up = false;
        //}
        
        move_count++;
      }
      
      if(down){
        p[0].set_y(p[0].charY + 45);
        //if(move_count == 4){
        //  move_count = 0;
          steps++;
          down = false;
        //}
        
        move_count++;
      }
      
      if(right){
        p[0].set_x(p[0].charX + 40);
        //if(move_count == 4){
        //  move_count = 0;
          steps++;
          right = false;
        //}
        
        move_count++;
      }
      
      if(left){
        p[0].set_x(p[0].charX - 40);
        //if(move_count == 4){
        //  move_count = 0;
          steps++;
          left = false;
        //}
        
        move_count++;
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
          if(floor > 4){
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
        
        pid = 0;
        battle_mode = 0;
        //  if(order[cur].get_type() == 1){
        //    pid = order[cur].get_id();
            
        //    battle_mode = 0;
        //  }else{
        //    mid = order[cur].get_id();
            
        //    battle_mode = -1;
        //  }
    }
  }  
}                    //close monsterappear()

void change_room(){
  switch(floor){
    case 1:
      for(int i = 0; i < floor_1[floor_room-1].exit.length; i++){
        for(int j = 0; j < floor_1[floor_room-1].exit[i].length; j++){
          if((int)p[0].charX/ (int)sqw == j && (int)p[0].charY/ (int)sqh == i){
            println("x: " + (int)p[0].charX/ (int)sqw + " y: "  + (int)p[0].charY/ (int)sqh);
            println("floor: " + floor + " room: " + floor_room);
          if(floor_1[floor_room-1].exit[i][j] != 0){
            println("move");
            if(floor_1[floor_room-1].exit[i][j] > floor_1.length){
              floor = 2;
              floor_room = 1;
              p[0].charX = 800;
              p[0].charY = 450;
            }else{
              floor_room = floor_1[floor_room-1].exit[i][j];
              p[0].charX = 800;
              p[0].charY = 450;
            }
          }
          }
        }
      }
      break;
      
    case 2:
      for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
        for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
          if((int)p[0].charX/ (int)sqw == j && (int)p[0].charY/ (int)sqh == i){
          if(floor_2[floor_room-1].exit[i][j] != 0){
            if(floor_2[floor_room-1].exit[i][j] > floor_2.length){
              floor = 3;
              floor_room = 1;
              p[0].charX = 800;
              p[0].charY = 450;
            }else if(floor_2[floor_room-1].exit[i][j] < 0){
              floor = 1;
              floor_room = floor_2[floor_room-1].exit[i][j] * -1;
              p[0].charX = 800;
              p[0].charY = 450;
            }else{
              floor_room = floor_2[floor_room-1].exit[i][j];
              p[0].charX = 800;
              p[0].charY = 450;
            }
          }
        }
        }
      }
      break;
      
    case 3:
      for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
        for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
          if((int)p[0].charX/ (int)sqw == j && (int)p[0].charY/ (int)sqh == i){
          if(floor_3[floor_room-1].exit[i][j] != 0){
            if(floor_3[floor_room-1].exit[i][j] > floor_3.length){
              floor = 4;
              floor_room = 1;
            }else if(floor_3[floor_room-1].exit[i][j] < 0){
              floor = 2;
              floor_room = floor_3[floor_room-1].exit[i][j] * -1;
            }else{
              floor_room = floor_3[floor_room-1].exit[i][j];
            }
          }
        }
        }
      }
      break;
      
    case 4:
      for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
        for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
          if((int)p[0].charX/ (int)sqw == j && (int)p[0].charY/ (int)sqh == i){
          if(floor_4[floor_room-1].exit[i][j] != 0){
            if(floor_4[floor_room-1].exit[i][j] > floor_4.length){
              floor = 5;
              floor_room = 1;
            }else if(floor_4[floor_room-1].exit[i][j] < 0){
              floor = 3;
              floor_room = floor_4[floor_room-1].exit[i][j] * -1;
            }else{
              floor_room = floor_4[floor_room-1].exit[i][j];
            }
          }
        }
        }
      }
      break;
      
    case 5:
      for(int i = 0; i < floor_5[floor_room-1].exit.length; i++){
        for(int j = 0; j < floor_5[floor_room-1].exit[i].length; j++){
          if((int)p[0].charX/ (int)sqw == j && (int)p[0].charY/ (int)sqh == i){
          if(floor_5[floor_room-1].exit[i][j] != 0){
            if(floor_5[floor_room-1].exit[i][j] < 0){
              floor = 4;
              floor_room = floor_5[floor_room-1].exit[i][j] * -1;
            }else{
              floor_room = floor_5[floor_room-1].exit[i][j];
            }
          }
        }
        }
      }
      break;
  }
}
