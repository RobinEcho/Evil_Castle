boolean opt = false;
int temp_room;

/*****************************************************************************************************************************************************************/

void keyPressed(){
    if(room > 1){
      switch(keyCode){
        case 'a':
        case 'A':
          left = true;
          
      monsterappear();
          //println("change left: " + left);
          break;
        case 'd':
        case 'D':
          right = true;
          
      monsterappear();
          //println("change right: " + right);
          break;
        case 'w':
        case 'W':
          up = true;
          
      monsterappear();
          //println("change up: " + up);
          break;
        case 's':
        case 'S':
          down = true;
          
      monsterappear();
          //println("change down: " + down);
          break;
          
          case 'o':
          case 'O':
            if(!opt){
              opt = true;
              temp_room = room;
              room = 99;
              println("false opt: " + room);
              
            }else{
              opt = false;

              room = temp_room;
              println("true opt: " + opt);
            }
              break;
      }
    }
  }

/*****************************************************************************************************************************************************************/
  
  void keyReleased(){
    switch(keyCode){
      case 'a':
      case 'A':
          left = false;
          break;
        case 'd':
        case 'D':
          right = false;
          break;
        case 'w':
        case 'W':
          up = false;
          break;
        case 's':
        case 'S':
          down = false;
          break;
    }
  }