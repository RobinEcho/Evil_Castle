int map_width = width/sqw, map_height = height/sqh;
int maproom; 

Map map = new Map();

 public class Map{
  
  
  public boolean[][] wall = new boolean[map_height][map_width];
  public boolean[][] npc = new boolean[map_height][map_width];
  public int[][] exit = new int[map_height][map_width];
  
  //bg = loadImage("src/backgroundimage/map1.jpg");
  public Map(){
    map_init();
  }
  
  public void map_init(){
    
    for(int i = 0; i < map_height; i++){
      for(int j = 0; j < map_width; j++){
        this.wall[i][j] = true;
        this.npc[i][j] = false;
        this.exit[i][j] = 0;
      }
    }
    
    //this.npc[10][20] = true;
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
    if(p[0].charX == 0){
        left = false;
        p[0].charX += sqw;
        steps--;
      }
    }
    
    if(right){
    if(p[0].charX == width - sqw){
      
        right = false;
        p[0].charX -= sqw;
        steps--;
      }
    }
    
    if(up){
    if(p[0].charY == 0){
      
        up = false;
        p[0].charY += sqh;
        steps--;
      }
    }
    
    if(down){
    if(p[0].charY == height - sqh){
      
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
              
              floor_1[floor_room_id-1].exit[4][33] = 5;
              break;
              
            case 5:
              floor_1[floor_room_id-1].exit[17][33] = 4;
              floor_1[floor_room_id-1].exit[17][34] = 4;
              
              /******************************
              *  go up to floor 2 room 1
              ******************************/
              for(int i = 7;i<=12;i++)
              {
                floor_1[floor_room_id-1].exit[i][6] = 6;
              }
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
                
                floor_3[floor_room_id-1].exit[4][20] = 7;
                break;
          
          case 7:
                floor_3[floor_room_id-1].exit[16][18] = 6;
                floor_3[floor_room_id-1].exit[16][19] = 6;
                floor_3[floor_room_id-1].exit[16][20] = 6;
                floor_3[floor_room_id-1].exit[16][21] = 6;
                
                floor_3[floor_room_id-1].exit[4][20] = 8;
                break;
          
          case 8:
                floor_3[floor_room_id-1].exit[16][18] = 7;
                floor_3[floor_room_id-1].exit[16][19] = 7;
                floor_3[floor_room_id-1].exit[16][20] = 7;
                floor_3[floor_room_id-1].exit[16][21] = 7;
                
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
              floor_4[floor_room_id-1].exit[16][20] = 1;
              floor_4[floor_room_id-1].exit[16][21] = 1;
              
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
              for(int i = 18; i <= 22; i++){
                floor_4[floor_room_id-1].exit[16][i] = 5;
              }
              
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
              floor_5[floor_room_id-1].exit[17][18] = -7;
              floor_5[floor_room_id-1].exit[17][19] = -7;
              floor_5[floor_room_id-1].exit[17][20] = -7;
              
              for(int i = 6; i <= 8; i++){
                floor_5[floor_room_id-1].exit[i][9] = 3;
                floor_5[floor_room_id-1].exit[i][30] = 2;
              }
              
              
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
              
              floor_5[floor_room_id-1].exit[5][10] = 4;
              floor_5[floor_room_id-1].exit[5][11] = 4;
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
              floor_5[floor_room_id-1].exit[17][20] = 5;
              floor_5[floor_room_id-1].exit[17][21] = 5;
              
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

/********************************************
*  Map set up
********************************************/
void wall_set(){
  init_1F();
  init_2F();
  init_3F();
  init_4F();
  init_5F();
}

void init_1F(){
  for(int i = 0; i < floor_1.length; i++){          
    
    switch(i){
        case 0:
              for(int j = 5;j <= 15; j++)
              {
                for(int k = 12;k <= 25; k ++)
                {
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              
              for(int j = 9;j <= 10; j++)
              {
                for(int k = 26;k <= 29; k ++)
                {
                  floor_1[i].wall[j][k] = false;
                }
              }
                            
              break;
        
        case 1:
              for(int j = 10;j <= 11;j++)
              {
                for(int k = 8;k <= 10;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int j = 9;j <= 12;j++)
              {
                for(int k = 11;k<= 25;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int j = 10;j<= 11;j++)
              {
                for(int k = 26;k<= 28;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
                
          break;
        
        case 2:
              for(int j = 10;j <= 11;j++)
              {
                for(int k = 8;k <= 10;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int j = 9;j <= 12;j++)
              {
                for(int k = 11;k<= 25;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int j = 10;j<= 11;j++)
              {
                for(int k = 26;k<= 28;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              break;
        
        case 3:
                  floor_1[i].wall[4][33] = false;
              
              for(int j = 12;j<= 16;j++)
              {
                for(int k = 3;k<= 36;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int j = 5;j<= 16;j++)
              {
                for(int k = 30;k<= 36;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
          break;
       
        case 4:
                  
              
              for(int j = 7;j<= 12;j++)
              {
                for(int k = 6;k<= 36;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 15;j++)
              {
                for(int k = 30;k<= 36;k++){
                  floor_1[i].wall[j][k] = false;
                }
              }
              
              for(int k = 30;k<= 36;k++)
              {
                floor_1[i].wall[15][k] = false;
              }
              
              for(int k = 31;k<= 35;k++)
              {    
                  floor_1[i].wall[16][k] = false;
              }
              
              for(int k = 33;k<= 34;k++)
              {    
                  floor_1[i].wall[17][k] = false;
              }
          break;
    
    
    }
  }
}

void init_2F(){
  for(int i = 0; i < floor_2.length; i++){
    
    switch(i){
    
        case 0:
                  floor_2[i].wall[7][31] = false;
                  
                  floor_2[i].wall[5][19] = false;
                  

              for(int j = 6;j<= 8;j++)
              {
                for(int k = 9;k<= 30;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 16;j<= 18;j++)
              {
                for(int k = 13;k<= 26;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 16;j++)
              {
                for(int k = 16;k<= 23;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 8;j<= 16;j++)
              {
                for(int k = 13;k<= 14;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 8;j<= 16;j++)
              {
                for(int k = 25;k<= 26;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
          break;
        
        case 1:
              for(int j = 3;j<= 16;j++)
              {
                for(int k = 14;k<= 25;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 9;j<= 10;j++)
              {
                for(int k = 9;k<= 13;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 9;j<= 10;j++)
              {
                for(int k = 26;k<= 30;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 17;j<= 18;j++)
              {
                for(int k = 16;k<= 23;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
          break;
        
        case 2:
              for(int j = 9;j<= 10;j++)
              {
                for(int k = 11;k<= 14;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 14;j++)
              {
                for(int k = 15;k<= 16;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 14;j++)
              {
                for(int k = 25;k<= 27;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
             

                for(int k = 15;k<= 27;k++){
                  floor_2[i].wall[6][k] = false;
                }
              
              for(int j = 13;j<= 14;j++)
              {
                for(int k = 15;k<= 27;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
                  
                  for(int j = 7;j<= 12;j +=5)
              {
                for(int k = 17;k<= 24;k += 7){
                  floor_2[i].wall[j][k] = false;
                  floor_2[i].wall[j][k-1] = false;
                  floor_2[i].wall[j][k+1] = false;
                }
              }
          break;
        
        case 3:
              for(int j = 10;j<= 11;j++)
              {
                for(int k = 10;k<= 29;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 16;j++)
              {
                for(int k = 17;k<= 22;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
             
                for(int k = 13;k<= 26;k++){
                  floor_2[i].wall[16][k] = false;
                }
          break;
        
        case 4:
              for(int j = 9;j<= 10;j++)
              {
                for(int k = 26;k<= 28;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 15;j++)
              {
                for(int k = 11;k<= 25;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              
                for(int k = 11;k<= 25;k++){
                  floor_2[i].wall[6][k] = false;
                }

              
              for(int j = 7;j<= 11;j++)
              {
                for(int k = 11;k<= 16;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
              
              for(int j = 7;j<= 11;j++)
              {
                for(int k = 20;k<= 25;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
          break;
        
        case 5:
              for(int j = 12;j<= 13;j++)
              {
                for(int k = 10;k<= 28;k++){
                  floor_2[i].wall[j][k] = false;
                }
              }
          break;
    
    }
  }
}

void init_3F(){
  for(int i = 0; i < floor_3.length; i++){
    
    switch(i){
    
        case 0:
                  floor_3[i].wall[18][21] = false;
              
              for(int k = 16;k<= 26;k++)
              {
                  floor_3[i].wall[5][k] = false;
              }
        
              for(int j = 9;j<= 10;j++)
              {
                for(int k = 11;k<= 17;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 12;j++)
              {
                for(int k = 14;k<= 17;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 8;j++)
              {
                for(int k = 18;k<= 28;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 15;j++)
              {
                for(int k = 16;k<= 26;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 13;j++)
              {
                for(int k = 16;k<= 26;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 16;j<= 17;j++)
              {
                for(int k = 19;k<= 22;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 12;j++)
              {
                for(int k = 25;k<= 28;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
          break;
          
        case 1:
              for(int j = 11;j<= 12;j++)
              {
                for(int k = 9;k<= 30;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
                for(int k = 9;k<= 10;k++){
                  floor_3[i].wall[10][k] = false;
                }
                
              for(int j = 13;j<= 14;j++)
              {
                for(int k = 18;k<= 21;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              floor_3[i].wall[15][19] = false;

              
          break;
        
        case 2:
              for(int j = 6;j<= 15;j++)
              {
                for(int k = 14;k<= 17;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 15;j++)
              {
                for(int k = 20;k<= 24;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 14;j<= 15;j++)
              {
                for(int k = 12;k<= 24;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 16;j<= 17;j++)
              {
                for(int k = 17;k<= 21;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              floor_3[i].wall[18][19] = false;
          break;
        
        case 3:
              for(int j = 6;j<= 11;j++)
              {
                for(int k = 14;k<= 26;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
                for(int k = 15;k<= 19;k++){
                  floor_3[i].wall[12][k] = false;
                }

              
              for(int j = 13;j<= 14;j++)
              {
                for(int k = 16;k<= 19;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 9;j<= 11;j++)
              {
                for(int k = 27;k<= 30;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              floor_3[i].wall[15][18] = false;
              floor_3[i].wall[5][19] = false;
          break;
        
        case 4:
              for(int j = 9;j<= 11;j++)
              {
                for(int k = 9;k<= 29;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 13;j++)
              {
                for(int k = 14;k<= 26;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 7;j<= 9;j++)
              {
                for(int k = 13;k<= 25;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
                   floor_3[i].wall[7][26] = false;             

                for(int k = 14;k<= 26;k++){
                  floor_3[i].wall[6][k] = false;
                }

          break;
        
        case 5:
              for(int j = 5; j <= 15; j++){
                for(int k = 13; k <= 26; k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 9; j <= 11; j++){
                for(int k = 10; k <= 12; k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6; j <= 8; j++){
                for(int k = 14; k <= 16; k++){
                  floor_3[i].wall[j][k] = true;
                }
              }
              
              for(int j = 9; j <= 11; j++){
                for(int k = 19; k <= 21; k++){
                  floor_3[i].wall[j][k] = true;
                  floor_3[i].wall[j][k+5] = true;
                }
              }
              
              for(int j = 13; j <= 15; j++){
                for(int k = 14; k <= 16; k++){
                  floor_3[i].wall[j][k] = true;
                  floor_3[i].wall[j][k+5] = true;
                  floor_3[i].wall[j][k+10] = true;
                }
              }
              
              for(int j = 20; j <= 24; j++){
                floor_3[i].wall[5][j] = false;
              }
              
              floor_3[i].wall[4][20] = false;
          break;
        
        case 6:
              for(int j = 5; j <= 12; j++){
                for(int k = 13; k <= 26; k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6; j <= 11; j++){
                for(int k = 14; k <= 16; k++){
                  floor_3[i].wall[j][k] = true;
                }
              }
              
              for(int j = 9; j <= 11; j++){
                for(int k = 24; k <= 26; k++){
                  floor_3[i].wall[j][k] = true;
                }
              }
              
              for(int j = 13; j <= 15; j++){
                for(int k = 17; k <= 23; k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 13; j <= 15; j++){
                floor_3[i].wall[j][13] = false;
              }
              
              for(int j = 20; j <= 24; j++){
                floor_3[i].wall[5][j] = false;
              }
              
              for(int j = 18; j <= 21; j++){
                floor_3[i].wall[16][j] = false;
              }
              
              floor_3[i].wall[4][20] = false;
          break;
        
        case 7:
              for(int j = 9;j<= 11;j++)
              {
                for(int k = 10;k<= 12;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 6;j<= 12;j++)
              {
                for(int k = 13;k<= 27;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 13;j<= 15;j++)
              {
                for(int k = 15;k<= 25;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              
                for(int k = 18;k<= 22;k++){
                  floor_3[i].wall[16][k] = false;
                }
              
                for(int k = 15;k<= 25;k++){
                  floor_3[i].wall[5][k] = false;
                }
              
              floor_3[i].wall[4][20] = false;
          break;
          
        case 8:
              for(int j = 9;j<= 10;j++)
              {
                for(int k = 26;k<= 28;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 12;j<= 15;j++)
              {
                for(int k = 11;k<= 25;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              
                for(int k = 11;k<= 25;k++){
                  floor_3[i].wall[6][k] = false;
                }

              
              for(int j = 7;j<= 11;j++)
              {
                for(int k = 11;k<= 16;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
              
              for(int j = 7;j<= 11;j++)
              {
                for(int k = 20;k<= 25;k++){
                  floor_3[i].wall[j][k] = false;
                }
              }
          break;  
    }
  }
}

void init_4F(){
  for(int f = 0; f < floor_4.length; f++){
    switch(f){
        case 0:
          for(int i = 6; i <= 14; i++){
            for(int j = 14; j <= 28; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 6; i <= 14; i++){
            floor_4[f].wall[i][20] = true;
            floor_4[f].wall[i][21] = true;
          }
          
          //
          for(int i = 15; i <= 17; i++){
            for(int j = 19; j <= 23; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          //
          for(int i = 9; i <= 11; i++){
            for(int j = 11; j <= 13; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          //
          for(int i = 11; i <= 14; i++){
            floor_4[f].wall[i][20] = false;
            floor_4[f].wall[i][21] = false;
          }
          
          for(int i = 4; i <= 7; i++){
            floor_4[f].wall[i][21] = false;
          }
          
          floor_4[f].wall[6][20] = false;
          floor_4[f].wall[7][20] = false;
          floor_4[f].wall[18][21] = false;
          
          break;
          
        case 1:
          for(int i = 6; i <= 12; i++){
            for(int j = 11; j <= 25; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 13; i <= 15; i++){
            for(int j = 13; j <= 23; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 8; i <= 10; i++){
            floor_4[f].wall[i][17] = true;
            floor_4[f].wall[i][18] = true;
          }
          
          for(int i = 9; i <= 11; i++){
            for(int j = 8; j <= 10; j++){
              floor_4[f].wall[i][j] = false;
              floor_4[f].wall[i][j+18] = false;
            }
          }
          break;
          
        case 2:
          for(int i = 9; i <= 11; i++){
            for(int j = 26; j <= 28; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 4; i <= 15; i++){
            for(int j = 11; j <= 25; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          break;
          
        case 3:
          for(int i = 6; i <= 12; i++){
            for(int j = 14; j <= 28; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          floor_4[f].wall[10][20] = true;
          floor_4[f].wall[10][21] = true;
          
          for(int i = 13; i <= 15; i++){
            for(int j = 16; j <= 26; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 9; i <= 11; i++){
            for(int j = 11; j <= 13; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          floor_4[f].wall[16][20] = false;
          floor_4[f].wall[16][21] = false;
          break;
          
        case 4:
          for(int i = 6; i <= 12; i++){
            for(int j = 13; j <= 27; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 9; i <= 11; i++){
            for(int j = 16; j <= 22; j++){
              floor_4[f].wall[i][j] = true;
            }
          }
          
          for(int i = 13; i <= 15; i++){
            for(int j = 14; j <= 25; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 9; i <= 11; i++){
            for(int j = 10; j <= 12; j++){
              floor_4[f].wall[i][j] = false;
              floor_4[f].wall[i][j+18] = false;
            }
          }
          
          floor_4[f].wall[11][16] = false;
          floor_4[f].wall[5][20] = false;
          break;
          
        case 5:
          for(int i = 6; i <= 15; i++){
            for(int j = 11; j <= 25; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 7; i <= 11; i++){
            for(int j = 17; j <= 19; j++){
              floor_4[f].wall[i][j] = true;
            }
          }
          
          for(int i = 9; i <= 11; i++){
            for(int j = 26; j <= 28; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          break;
          
        case 6:
          for(int i = 6; i <= 13; i++){
            for(int j = 13; j <= 27; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 6; i <= 7; i++){
            floor_4[f].wall[i][14] = true;
            floor_4[f].wall[i][15] = true;
            floor_4[f].wall[i][24] = true;
            floor_4[f].wall[i][25] = true;
          }
          
          for(int i = 11; i <= 13; i++){
            floor_4[f].wall[i][14] = true;
            floor_4[f].wall[i][15] = true;
            floor_4[f].wall[i][24] = true;
            floor_4[f].wall[i][25] = true;
          }
          
          for(int i = 14; i <= 15; i++){
            for(int j = 13; j <= 27; j++){
              if(j != 16 && j != 17 && j != 23){
                floor_4[f].wall[i][j] = false;
              }
            }
          }
          
          for(int i = 9; i <= 11; i++){
            for(int j = 10; j <= 12; j++){
              floor_4[f].wall[i][j] = false;
            }
          }
          
          for(int i = 18; i <= 22; i++){
            floor_4[f].wall[16][i] = false;
          }
          
          floor_4[f].wall[5][20] = false;
          break;
          
        case 7:
           for(int i = 10; i <= 28; i++){
             floor_4[f].wall[12][i] = false;
             floor_4[f].wall[13][i] = false;
           }
          
          break;
    }
  }
}

void init_5F(){
  for(int f = 0; f < floor_5.length; f++){
    switch(f){
      case 0:
        for(int i = 6; i <= 8; i++){
          for(int j = 9; j <= 30; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        
        for(int i = 9; i <= 11; i++){
          floor_5[f].wall[i][13] = false;
          floor_5[f].wall[i][14] = false;
          floor_5[f].wall[i][25] = false;
          floor_5[f].wall[i][26] = false;
        }
        
        for(int i = 12; i <= 16; i++){
          for(int j = 13; j <= 26; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        
        for(int i = 12; i <= 15; i++){
          floor_5[f].wall[i][15] = true;
          floor_5[f].wall[i][24] = true;
        }
        
        floor_5[f].wall[17][18] = false;
        floor_5[f].wall[17][19] = false;
        floor_5[f].wall[17][20] = false;
        floor_5[f].wall[5][19] = false;
        break;
        
      case 1:
        for(int i = 6; i <= 15; i++){
          for(int j = 14; j <= 28; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        
        for(int i = 9; i <= 11; i++){
          for(int j = 11; j <= 13; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        break;
        
      case 2:
        for(int i = 10; i <= 18; i++){
          floor_5[f].wall[6][i] = false;
          floor_5[f].wall[7][i] = false;
        }
        for(int i = 23; i <= 26; i++){
          floor_5[f].wall[6][i] = false;
          floor_5[f].wall[7][i] = false;
        }
        for(int i = 13; i <= 18; i++){
          floor_5[f].wall[8][i] = false;
          floor_5[f].wall[9][i] = false;
          floor_5[f].wall[12][i] = false;
        }
        for(int i = 23; i <= 26; i++){
          floor_5[f].wall[8][i] = false;
          floor_5[f].wall[9][i] = false;
        }
        
        for(int i = 13; i <= 29; i++){
          floor_5[f].wall[10][i] = false;
          floor_5[f].wall[11][i] = false;
        }
        
        for(int i = 12; i <= 16; i++){
          for(int j = 18; j <= 26; j++){
            floor_5[f].wall[i][j] = false;
            floor_5[f].wall[i][j] = false;
          }
        }
        
        floor_5[f].wall[13][13] = false;
        floor_5[f].wall[13][14] = false;
        floor_5[f].wall[15][16] = false;
        floor_5[f].wall[15][17] = false;
        floor_5[f].wall[16][16] = false;
        floor_5[f].wall[16][17] = false;
        floor_5[f].wall[5][10] = false;
        floor_5[f].wall[5][11] = false;
        break;
        
        
      case 3:
        for(int i = 10; i <= 25; i++){
          floor_5[f].wall[11][i] = false;
          floor_5[f].wall[12][i] = false;
        }
        
        for(int i = 17; i <= 20; i++){
          floor_5[f].wall[13][i] = false;
          floor_5[f].wall[14][i] = false;
        }
        
        floor_5[f].wall[15][18] = false;
        floor_5[f].wall[15][19] = false;
        
        break;
        
      case 4:
        for(int i = 4; i <= 17; i++){
          for(int j = 18; j <= 22; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        
        for(int i = 5; i <= 8; i++){
          floor_5[f].wall[i][16] = false;
          floor_5[f].wall[i][17] = false;
          floor_5[f].wall[i][23] = false;
        }
        
        for(int i = 11; i <= 13; i++){
          floor_5[f].wall[i][16] = false;
          floor_5[f].wall[i][17] = false;
          floor_5[f].wall[i][23] = false;
        }
        
        floor_5[f].wall[2][19] = false;
        floor_5[f].wall[2][20] = false;
        floor_5[f].wall[3][19] = false;
        floor_5[f].wall[3][20] = false;
        floor_5[f].wall[18][20] = false;
        break;
        
      case 5:
        for(int i = 7; i <= 12; i++){
          for(int j = 14; j<= 27; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        
        for(int i = 15; i <= 26; i++){
          floor_5[f].wall[6][i] = false;
          
          for(int j = 13; j<= 16; j++){
            floor_5[f].wall[j][i] = false;
          }
        }
        
        floor_5[f].wall[6][19] = true;
        floor_5[f].wall[6][22] = true;
        floor_5[f].wall[10][13] = false;
        floor_5[f].wall[11][13] = false;
        floor_5[f].wall[17][20] = false;
        floor_5[f].wall[17][21] = false;
        break;
        
      case 6:
        for(int i = 11; i <= 13; i++){
          for(int j = 16; j <= 23; j++){
            floor_5[f].wall[i][j] = false;
          }
        }
        break;
    }
  }
}
