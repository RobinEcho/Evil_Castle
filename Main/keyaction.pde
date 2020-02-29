/*******************************************************************
function about keyboard, set variable first, all action base on room 
*********************************************************************/

boolean opt = false,inhelp = true;
boolean up = false, down = false, left = false, right = false;
int temp_room;

/*******************************************
quick key and movement 
********************************************/ 

void keyPressed(){
    if(room > 1){
      switch(keyCode){
        case 'o':
        case 'O':
          if(!opt){
            opt = true;
            temp_room = room;
            room = 99;
          }else{
            opt = false;
            room = temp_room;
          }
        break;
        case ' ':
          switch(floor){
            case 1:
              if(floor_room < floor_1.length){
                floor_room++;
              }else{
                floor_room = 1;
                floor++;
              }
            break;
            
            case 2:
              if(floor_room < floor_2.length){
                floor_room++;
              }else{
                floor_room = 1;
                floor++;
              }
            break;
            
            case 3:
              if(floor_room < floor_3.length){
                floor_room++;
              }else{
                floor_room = 1;
                floor++;
              }
            break;
            
            case 4:
              if(floor_room < floor_4.length){
                floor_room++;
              }else{
                floor_room = 1;
                floor++;
              }
            break;
            
            case 5:
              if(floor_room < floor_5.length){
                floor_room++;
              }else{
                floor_room = 1;
              }
            break;
          }
          break;
      }
    }
    
    if(room == 2){
      switch(keyCode){
       
        case 'a':
        case 'A':
          if(!up && !down && !left && !right){
            moving = true;
            move_count = 0;
            left = true;
            p[0].dir = 3;
            monsterappear();
            
          }
          //println("change left: " + left);
          break;
        case 'd':
        case 'D':
          if(!up && !down && !left && !right){
            moving = true;
            move_count = 0;
            right = true;
            p[0].dir = 1;
            monsterappear();
          }
          //println("change right: " + right);
          break;
        case 'w':
        case 'W':
          if(!up && !down && !left && !right){
            moving = true;
            move_count = 0;
            up = true;
            p[0].dir = 0;
            monsterappear();
          }
          //println("change up: " + up);
          break;
        case 's':
        case 'S':
          if(!up && !down && !left && !right){
            moving = true;
            move_count = 0;
            down = true;
            p[0].dir = 2;
            monsterappear();
          }
          //println("change down: " + down);
          break;
          
          case 'f':
          case 'F':
            int target_coord[] = new int[2];
            target_coord = p[0].interact();
            
            if(map.npc[target_coord[1]][target_coord[0]]){
              println("HI!");
              switch(floor){
                case 1:
                  //boss
                  if(floor_room == 2){
                    if(target_coord[1] == 10 && target_coord[0] == 11){
                      boss_fight();
                    }
                    
                    //boss not defeated
                    if((target_coord[1] == 10 && target_coord[0] == 27)
                      || (target_coord[1] == 11 && target_coord[0] == 27)
                      || (target_coord[1] == 12 && target_coord[0] == 27)){
                        
                        room = 4;
                    }
                  }
                  
                  //npc join party
                  if(floor_room == 3){
                    if(target_coord[1] == 8 && target_coord[0] == 13){
                      if(cell_key){
                          new_companion = 1;
                      }else{
                        new_companion = 0;
                      }
                      
                      
                      room = 98;
                      println("knight");
                    }
                    
                    if(target_coord[1] == 8 && target_coord[0] == 18){
                      if(cell_key){
                          new_companion = 2;
                      }else{
                        new_companion = 0;
                      }
                      room = 98;
                      println("paladin");
                    }
                    
                    if(target_coord[1] == 8 && target_coord[0] == 23){
                      if(cell_key){
                          new_companion = 3;
                      }else{
                        new_companion = 0;
                      }
                      room = 98;
                      println("ranger");
                    }
                    
                    if(target_coord[1] == 13 && target_coord[0] == 13){
                      if(cell_key){
                          new_companion = 4;
                      }else{
                        new_companion = 0;
                      }
                      room = 98;
                      println("assassin");
                    }
                    
                    if(target_coord[1] == 13 && target_coord[0] == 18){
                      if(cell_key){
                          new_companion = 5;
                      }else{
                        new_companion = 0;
                      }
                      room = 98;
                      println("mage");
                    }
                    
                    if(target_coord[1] == 13 && target_coord[0] == 23){
                      if(cell_key){
                          new_companion = 6;
                      }else{
                        new_companion = 0;
                      }
                      room = 98;
                      println("priest");
                    }
                  }
                  break;
                  
                case 2:
                  //boss
                  if(floor_room == 4){
                    if(target_coord[1] == 6 && target_coord[0] == 20){
                      boss_fight();
                    }
                  }
                  
                  //door
                  if(floor_room == 1){
                    if(target_coord[1] == 5 && target_coord[0] == 19){
                      room = 4;
                    }
                  }
                  
                  //equipment safe
                  if(floor_room == 6){
                    if(target_coord[1] == 13 && target_coord[0] == 10){
                      room = 8;
                    }
                  }
                            
                  //shop and heal
                  if(floor_room == 5){
                    if(!in_shop){
                      room = 89;
                    }
                  }
                  break;
                case 3:
                  //boss
                  if(floor_room == 3){
                    if((target_coord[1] == 7 && target_coord[0] == 15)
                      || (target_coord[1] == 7 && target_coord[0] == 16)
                      || (target_coord[1] == 8 && target_coord[0] == 15)
                      || (target_coord[1] == 8 && target_coord[0] == 16)){
                        
                        boss_fight();
                        
                    }
                  }
                  
                  //door
                  if(floor_room == 8){
                    if(target_coord[1] == 4 && target_coord[0] == 20){
                      room = 4;
                    }
                  }
                  
                  //equipment safe
                  if(floor_room == 3){
                    if(target_coord[1] == 6 && target_coord[0] == 22){
                      room = 8;
                    }
                  }
                  
                  //shop and heal
                  if(floor_room == 9){
                    if(!in_shop){
                      room = 89;
                    }
                  }
                  break;
                case 4:
                  //boss
                  if(floor_room == 7){
                    if(target_coord[1] == 9 && target_coord[0] == 20){
                      boss_fight();
                    }
                    
                    //door
                    if(target_coord[1] == 5 && target_coord[0] == 20){
                      room = 4;
                    }
                  }
                  
                  //equipment safe
                  if(floor_room == 8){
                    if(target_coord[1] == 13 && target_coord[0] == 10){
                      room = 8;
                    }
                  }
                  
                  //shop and heal
                  if(floor_room == 6){
                    if(!in_shop){
                      room = 89;
                    }
                  }
                  break;
                case 5:
                  //boss
                  if(floor_room == 6){
                    if((target_coord[6] == 7 && target_coord[0] == 20)
                      || (target_coord[6] == 7 && target_coord[0] == 21)
                      || (target_coord[7] == 8 && target_coord[0] == 20)
                      || (target_coord[7] == 8 && target_coord[0] == 21)){
                        
                        boss_fight();
                      
                    }
                    
                    //door
                    if((target_coord[6] == 10 && target_coord[0] == 13)
                      || (target_coord[6] == 11 && target_coord[0] == 13)){
                        
                        room = 4;
                        
                    }
                  }
                  
                  //equipment safe
                  if(floor_room == 4){
                    if(target_coord[1] == 12 && target_coord[0] == 10){
                      room = 8;
                    }
                  }
                  
                  if(floor_room == 7){
                    if(target_coord[1] == 10 && target_coord[0] == 19){
                      room = 999;
                    }
                  }
                  
                  //shop and heal
                  if(floor_room == 4){
                    if(target_coord[0] == 26 && (target_coord[1] == 11 || target_coord[1] == 12)){
                      if(!in_shop){
                        room = 89;
                      }
                    }
                  }
                  break;
              }
            }
            
            println("room: " + room);
            break;
      }
      }
      
      if(room > 1 && room < 90){
      switch(keyCode){
        case 'b':
        case 'B':
            pid = 0;
            if(!inBag){
              inBag = true;
              room = 80;
            }else{
              inBag = false;
    
              room = map.get_map_room();
            }
        break;
        
        case 'h':
        case 'H':
            if(!inhelp){
              
              inhelp = true;
              
              room = 3;
            }else{
              
              inhelp = false;
              
              room = 2;
            }
        
          break;
        
        case 'x':
         case'X':
             dmg(10,0,1);
             p[0].dec_mp(10);
             p[0].calc_stats();
           break;
       
       case 'l':
         case'L':
             start_frame = frameCount;
             p[0].gainExp(10);
             //p[1].gainExp(100);
             //p[2].gainExp(100);
             //p[3].gainExp(100);
             //steps = 100;
             break;
      }
      }
    
  }
 
/*******************************************
movement part
********************************************/ 
  
  void keyReleased(){
    switch(keyCode){
      case 'a':
      case 'A':
          moving = false;
          break;
        case 'd':
        case 'D':
          moving = false;
          break;
        case 'w':
        case 'W':
          moving = false;
          break;
        case 's':
        case 'S':
          moving = false;
          break;
    }
  }
