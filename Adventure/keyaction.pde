/*******************************************************************
function about keyboard, set variable first, all action base on room 
*********************************************************************/

boolean opt = false;
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
    
    if(room > 1 && room < 90){
      switch(keyCode){
        case 'a':
        case 'A':
          if(!up && !down && !left && !right){
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
            }
            break;
            
        case 'b':
        case 'B':
            if(!inBag){
              inBag = true;
              room = 80;
            }else{
              inBag = false;
    
              room = map.get_map_room();
            }
        break;
      }
    }
  }
 
/*******************************************
movement part
********************************************/ 
  
  //void keyReleased(){
  //  switch(keyCode){
  //    case 'a':
  //    case 'A':
  //        left = false;
  //        break;
  //      case 'd':
  //      case 'D':
  //        right = false;
  //        break;
  //      case 'w':
  //      case 'W':
  //        if(move_count == 5){
  //          up = false;
  //        }
  //        break;
  //      case 's':
  //      case 'S':
  //        down = false;
  //        break;
  //  }
  //}
