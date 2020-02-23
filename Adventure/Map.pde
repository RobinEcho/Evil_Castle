int map_width = width/sqw, map_height = height/sqh;
int maproom; 

Map map = new Map();

 public class Map{
  
  
  protected boolean[][] wall = new boolean[map_height][map_width];
  public boolean[][] npc = new boolean[map_height][map_width];
  public int[][] exit = new int[map_height][map_width];
  
  //bg = loadImage("src/backgroundimage/map1.jpg");
  public Map(){
    map_init();
  }
  
  public void map_init(){
    
    for(int i = 0; i < map_height; i++){
      for(int j = 0; j < map_width; j++){
        this.wall[i][j] = false;
        this.npc[i][j] = false;
        this.exit[i][j] = 0;
      }
    }
    
    this.npc[10][20] = true;
  }
  
  public int get_map_room(){
    return maproom;
  }
  
  public void draw_npc(){
    fill(0,0,100);
    for(int i = 0; i < npc.length; i++){
      for(int j = 0; j < npc[i].length; j++){
        if(this.npc[i][j]){
          rect(j * sqw, i * sqh, sqw, sqh);
        }
      }
    }
  }
  
  public boolean isWall(int x, int y){
    return this.wall[y][x];
  }
  
  public void set_wall(int x, int y){
    this.wall[y][x] = true;
  }
  
  public void del_wall(int x, int y){
    this.wall[y][x] = false;    
  }
  
  public boolean is_npc(int x, int y){
    return this.npc[y][x];
  }
  
  public void set_npc(int x, int y){
    this.npc[y][x] = true;
  }
  
  public void del_npc(int x, int y){
    this.npc[y][x] = false;    
  }
  
  public void isBoundary(){
  
    if(left){
    if(p[0].charX == -sqw){
        left = false;
        p[0].charX += sqw;
        steps--;
      }
    }
    
    if(right){
    if(p[0].charX == width){
      
        right = false;
        p[0].charX -= sqw;
        steps--;
      }
    }
    
    if(up){
    if(p[0].charY == -sqh){
      
        up = false;
        p[0].charY += sqh;
        steps--;
      }
    }
    
    if(down){
    if(p[0].charY == height){
      
        down = false;
        p[0].charY -= sqh;
        steps--;
      }    
    }
    
  }                    //close isBoundary
  
  public void drawmap(int floor_id, int floor_room_id){
    
    bg = loadImage("src/backgroundimage/floor_" + (floor_id) + "/room" + (floor_room_id) + ".jpg");
    room = 2;
    maproom = room;
    cur_room_npc();
    
  }                    // close drawmap()
  
  public void init_exit(int floor_id, int floor_room_id){
    switch(floor_id){
      //floor 1
      case 1:
          switch(floor_room_id){
            case 1:
              floor_1[floor_room_id-1].exit[9][28] = 2;
              floor_1[floor_room_id-1].exit[10][28] = 2;
              floor_1[floor_room_id-1].exit[11][28] = 2;
              break;
              
            case 2:
              floor_1[floor_room_id-1].exit[10][8] = 1;
              floor_1[floor_room_id-1].exit[11][8] = 1;
              floor_1[floor_room_id-1].exit[12][8] = 1;
              
              floor_1[floor_room_id-1].exit[10][28] = 3;
              floor_1[floor_room_id-1].exit[11][28] = 3;
              floor_1[floor_room_id-1].exit[12][28] = 3;
              break;
              
            case 3:
              floor_1[floor_room_id-1].exit[10][8] = 2;
              floor_1[floor_room_id-1].exit[11][8] = 2;
              floor_1[floor_room_id-1].exit[12][8] = 2;
              
              floor_1[floor_room_id-1].exit[10][28] = 4;
              floor_1[floor_room_id-1].exit[11][28] = 4;
              floor_1[floor_room_id-1].exit[12][28] = 4;
              break;
              
            case 4:
              floor_1[floor_room_id-1].exit[12][3] = 3;
              floor_1[floor_room_id-1].exit[13][3] = 3;
              floor_1[floor_room_id-1].exit[14][3] = 3;
              floor_1[floor_room_id-1].exit[15][3] = 3;
              floor_1[floor_room_id-1].exit[16][3] = 3;
              
              floor_1[floor_room_id-1].exit[5][33] = 5;
              break;
              
            case 5:
              floor_1[floor_room_id-1].exit[17][33] = 4;
              floor_1[floor_room_id-1].exit[17][34] = 4;
              
              /******************************
              *  go up to floor 2 room 1
              ******************************/
              floor_1[floor_room_id-1].exit[8][6] = 6;
              floor_1[floor_room_id-1].exit[9][6] = 6;
              floor_1[floor_room_id-1].exit[10][6] = 6;
              floor_1[floor_room_id-1].exit[11][6] = 6;
              floor_1[floor_room_id-1].exit[12][6] = 6;
              break;
          }
        break;
      
      //floor 2
      case 2:
        switch(floor_room_id){
          case 1:
              floor_2[floor_room_id-1].exit[6][29] = -5;
              floor_2[floor_room_id-1].exit[7][29] = -5;
              floor_2[floor_room_id-1].exit[8][29] = -5;
              
              floor_2[floor_room_id-1].exit[6][9] = 6;
              floor_2[floor_room_id-1].exit[7][9] = 6;
              floor_2[floor_room_id-1].exit[8][9] = 6;
              
              for(int i = 13; i <= 26; i++){
                floor_2[floor_room_id-1].exit[18][i] = 2;
              }
              
              //go up to floor 3 room 1
              floor_2[floor_room_id-1].exit[5][19] = 7;
              break;
              
            case 2:
              for(int i = 14; i <= 25; i++){
                floor_2[floor_room_id-1].exit[3][i] = 1;
              }
              
              floor_2[floor_room_id-1].exit[9][29] = 3;
              floor_2[floor_room_id-1].exit[10][29] = 3;
              floor_2[floor_room_id-1].exit[11][29] = 3;
              
              floor_2[floor_room_id-1].exit[9][9] = 4;
              floor_2[floor_room_id-1].exit[10][9] = 4;
              floor_2[floor_room_id-1].exit[11][9] = 4;
              
              //floor_2[floor_room_id-1].exit[19][19] = 0; //game end exit
              break;
              
            case 3:
              floor_2[floor_room_id-1].exit[9][11] = 2;
              floor_2[floor_room_id-1].exit[10][11] = 2;
              floor_2[floor_room_id-1].exit[11][11] = 2;
              break;
              
            case 4:
              floor_2[floor_room_id-1].exit[10][29] = 2;
              floor_2[floor_room_id-1].exit[11][29] = 2;
              floor_2[floor_room_id-1].exit[12][29] = 2;
              
              floor_2[floor_room_id-1].exit[10][10] = 5;
              floor_2[floor_room_id-1].exit[11][10] = 5;
              floor_2[floor_room_id-1].exit[12][10] = 5;
              break;
              
            case 5:
              floor_2[floor_room_id-1].exit[9][28] = 4;
              floor_2[floor_room_id-1].exit[10][28] = 4;
              floor_2[floor_room_id-1].exit[11][28] = 4;
              break;
            
            case 6:
              floor_2[floor_room_id-1].exit[12][28] = 1;
              floor_2[floor_room_id-1].exit[13][28] = 1;
              break;
        }
        break;
        
      case 3:
        switch(floor_room_id){
          case 1:
                // to 2nd floor, go down
                floor_3[floor_room_id-1].exit[18][21] = -1;
                
                floor_3[floor_room_id-1].exit[9][11] = 2;
                floor_3[floor_room_id-1].exit[10][11] = 2;
                floor_3[floor_room_id-1].exit[11][11] = 2;
                break;
                
          case 2:
                floor_3[floor_room_id-1].exit[11][30] = 1;
                floor_3[floor_room_id-1].exit[12][30] = 1;
                
                floor_3[floor_room_id-1].exit[15][19] = 4;
                
                floor_3[floor_room_id-1].exit[10][9] = 3;
                floor_3[floor_room_id-1].exit[10][10] = 3;
                break;
          
          case 3:
                floor_3[floor_room_id-1].exit[18][19] = 2;
                break;
                
          case 4:
                floor_3[floor_room_id-1].exit[5][19] = 2;
                
                floor_3[floor_room_id-1].exit[9][29] = 5;
                floor_3[floor_room_id-1].exit[10][29] = 5;
                floor_3[floor_room_id-1].exit[11][29] = 5;
                break;
          
          case 5:
                floor_3[floor_room_id-1].exit[9][9] = 4;
                floor_3[floor_room_id-1].exit[10][9] = 4;
                floor_3[floor_room_id-1].exit[11][9] = 4;
                
                floor_3[floor_room_id-1].exit[9][29] = 6;
                floor_3[floor_room_id-1].exit[10][29] = 6;
                floor_3[floor_room_id-1].exit[11][29] = 6;
                break;
          
          case 6:
                floor_3[floor_room_id-1].exit[9][10] = 5;
                floor_3[floor_room_id-1].exit[10][10] = 5;
                floor_3[floor_room_id-1].exit[11][10] = 5;
                
                floor_3[floor_room_id-1].exit[5][20] = 7;
                break;
          
          case 7:
                floor_3[floor_room_id-1].exit[18][19] = 6;
                floor_3[floor_room_id-1].exit[18][20] = 6;
                
                floor_3[floor_room_id-1].exit[5][20] = 8;
                break;
          
          case 8:
                floor_3[floor_room_id-1].exit[18][19] = 7;
                floor_3[floor_room_id-1].exit[18][20] = 7;
                
                floor_3[floor_room_id-1].exit[9][10] = 9;
                floor_3[floor_room_id-1].exit[10][10] = 9;
                floor_3[floor_room_id-1].exit[11][10] = 9;
                
                // to 4th, go up
                floor_3[floor_room_id-1].exit[4][20] = 10;
                break;
          
          case 9:
                floor_3[floor_room_id-1].exit[9][28] = 8;
                floor_3[floor_room_id-1].exit[10][28] = 8;
                floor_3[floor_room_id-1].exit[11][28] = 8;
                break;
            
        }
        break;
        
      case 4:
        switch(floor_room_id){
          case 1:
              //to floor 3, go down
              floor_4[floor_room_id-1].exit[18][21] = -8;
              
              floor_4[floor_room_id-1].exit[9][11] = 2;              
              floor_4[floor_room_id-1].exit[10][11] = 2;
              floor_4[floor_room_id-1].exit[11][11] = 2;
              
              floor_4[floor_room_id-1].exit[5][21] = 4;
              
              break;
              
          case 2:
              floor_4[floor_room_id-1].exit[9][28] = 1;
              floor_4[floor_room_id-1].exit[10][28] = 1;
              floor_4[floor_room_id-1].exit[11][28] = 1;
              
              floor_4[floor_room_id-1].exit[9][8] = 3;
              floor_4[floor_room_id-1].exit[10][8] = 3;
              floor_4[floor_room_id-1].exit[11][8] = 3;
              break;
          
          case 3:
              floor_4[floor_room_id-1].exit[9][28] = 2;
              floor_4[floor_room_id-1].exit[10][28] = 2;
              floor_4[floor_room_id-1].exit[11][28] = 2;
              break;
          
          case 4:
              floor_4[floor_room_id-1].exit[18][21] = 1;
              
              floor_4[floor_room_id-1].exit[9][11] = 5;
              floor_4[floor_room_id-1].exit[10][11] = 5;
              floor_4[floor_room_id-1].exit[11][11] = 5;
              break;    
          
          case 5:
              floor_4[floor_room_id-1].exit[9][30] = 4;
              floor_4[floor_room_id-1].exit[10][30] = 4;
              floor_4[floor_room_id-1].exit[11][30] = 4;
              
              floor_4[floor_room_id-1].exit[9][10] = 6;
              floor_4[floor_room_id-1].exit[10][10] = 6;
              floor_4[floor_room_id-1].exit[11][10] = 6;
              
              floor_4[floor_room_id-1].exit[5][20] = 7;
              break;    
          
          case 6:
              floor_4[floor_room_id-1].exit[9][28] = 5;
              floor_4[floor_room_id-1].exit[10][28] = 5;
              floor_4[floor_room_id-1].exit[11][28] = 5;
              break;
          
          case 7:
              floor_4[floor_room_id-1].exit[18][20] = 5;
              
              floor_4[floor_room_id-1].exit[9][10] = 8;
              floor_4[floor_room_id-1].exit[10][10] = 8;
              floor_4[floor_room_id-1].exit[11][10] = 8;
              
              // to 5th floor, go up 
              floor_4[floor_room_id-1].exit[5][20] = 9;
              break;
          
          case 8:
              floor_4[floor_room_id-1].exit[12][28] = 7;
              floor_4[floor_room_id-1].exit[13][28] = 7;
              break;
            
        }
        break;
        
      case 5:
        switch(floor_room_id){
          case 1:
              // to 4th floor, go down 
              floor_5[floor_room_id-1].exit[18][19] = -7;
              
              floor_5[floor_room_id-1].exit[7][31] = 2;
              
              floor_5[floor_room_id-1].exit[7][8] = 3;
              
              floor_5[floor_room_id-1].exit[5][19] = 5;
              break;
              
            case 2:
              floor_5[floor_room_id-1].exit[9][11] = 1;
              floor_5[floor_room_id-1].exit[10][11] = 1;
              floor_5[floor_room_id-1].exit[11][11] = 1;
              break;
            
            case 3:
              floor_5[floor_room_id-1].exit[10][29] = 1;
              floor_5[floor_room_id-1].exit[11][29] = 1;
              
              floor_5[floor_room_id-1].exit[6][10] = 4;
              floor_5[floor_room_id-1].exit[6][11] = 4;
              break;
            
            case 4:
              floor_5[floor_room_id-1].exit[15][18] = 3;
              floor_5[floor_room_id-1].exit[15][19] = 3;              
              break;
            
            case 5:
              floor_5[floor_room_id-1].exit[18][20] = 1;
              
              floor_5[floor_room_id-1].exit[2][19] = 6;
              floor_5[floor_room_id-1].exit[2][20] = 6;
              break;
            
            case 6:
              floor_5[floor_room_id-1].exit[16][20] = 5;
              floor_5[floor_room_id-1].exit[16][21] = 5;
              
              floor_5[floor_room_id-1].exit[10][13] = 7;
              floor_5[floor_room_id-1].exit[11][13] = 7;
              break;
            
            case 7:
              floor_5[floor_room_id-1].exit[11][23] = 6;
              floor_5[floor_room_id-1].exit[12][23] = 6;
              floor_5[floor_room_id-1].exit[13][23] = 6;
              break;
            
        }
        break;
    }
  }
  
}

void cur_room_npc(){
  switch(floor){
    case 1:
      floor_1[floor_room - 1].draw_npc();
      break;
      
    case 2:
      floor_2[floor_room - 1].draw_npc();
      break;
      
    case 3:
      floor_3[floor_room - 1].draw_npc();
      break;
      
    case 4:
      floor_4[floor_room - 1].draw_npc();
      break;
      
    case 5:
      floor_5[floor_room - 1].draw_npc();
      break;
      
  }
}
