/*******************************************
import library
********************************************/ 
  
  import processing.core.PFont;  
  import java.io.*;
  import java.util.Random;
  import java.lang.Math.*;


 
 
/*******************************************
 Create reader and wirter
********************************************/ 
  PrintWriter output;
  BufferedReader read;
  String[] profile;
  

  
  
/*******************************************
 Create style
********************************************/   
  
  PImage bg, bag_img, indicator;
  PImage[] npc = new PImage[6];
  PFont font;
  
  int boss_defeated = 0;
  
  int total_jobs = 6, floor = 1, floor_room = 1;
  int buff_count = 20;
  
  int steps = 0, encounter;
  float side_margin, height_margin;
  float rate = 30;
  
  float dmg_x, dmg_y;
  int display_dmg, start_frame;
  int boxwidth,boxheight;
  int boxX,boxY;
  
  int grid_width = 40, grid_height = 45;
  int sqw = 40, sqh = 45;
  int width = 1600, height = 900;
  
  int max_pt = 4, c_pt = 1;
  int item_count = 102;
  int[] hit = new int[max_pt];
  
  int new_companion;
  
  boolean shop_set = false, cell_key = true;
  boolean[] npc_in_cell = {true, true, true, true, true, true};
  
  PImage[] buff_icon = new PImage[buff_count];


/*******************************************
  key variable to draw or action
********************************************/ 
  

   protected boolean saved = false;
   int room = 0; 
   int map_room = 0;


  /*******************************************
        init class object
  ********************************************/ 
    Random r = new Random();
    
    Item[] item_list = new Item[item_count];
    Units[] battle_list = new Units[max_pt*2];
    Monster[] m = new Monster[4];
    
    Map[] floor_1 = new Map[5];
    Map[] floor_2 = new Map[6];
    Map[] floor_3 = new Map[9];
    Map[] floor_4 = new Map[8];
    Map[] floor_5 = new Map[7];
    
    Player[] p = new Player[4];
    Bag bag = new Bag(8, 5);        //Bag(row,column)
    
    Normal normal = new Normal();
    Elite elite = new Elite();
    Boss boss = new Boss();
    
    Merchant shop = new Merchant();
  
  /*******************************************
    key variable to draw or action
  ********************************************/ 
  
      public void settings(){
        size(width, height);
        
        side_margin = width/2 - 60;
        
        height_margin = height/2;
      }                            //close settings()
  
  
  
  /*******************************************
    for setting some basic data
  ********************************************/ 
  
  public void setup(){
    
    frameRate(rate);
    background(0,0,100);
     text("Loading", 400, 400);
    colorMode(HSB, 100);
    indicator = loadImage("src/turn.png");
    
    npc[0] = loadImage("src/npc/knight.png");
    npc[1] = loadImage("src/npc/paladin.png");
    npc[2] = loadImage("src/npc/ranger.png");
    npc[3] = loadImage("src/npc/assassin.png");
    npc[4] = loadImage("src/npc/mage.png");
    npc[5] = loadImage("src/npc/priest.png");
    
    load_items();
    
    for(int i = 0; i < 4; i++){
      m[i] = new Monster();
    }
    
    for(int i = 0; i < floor_1.length; i++){
      floor_1[i] = new Map();
      floor_1[i].init_exit(1, (i+1));
    }
    
    for(int i = 0; i < floor_2.length; i++){
      floor_2[i] = new Map();
      floor_2[i].init_exit(2, (i+1));
    }
    
    for(int i = 0; i < floor_3.length; i++){
      floor_3[i] = new Map();
      floor_3[i].init_exit(3, (i+1));
    }
    
    for(int i = 0; i < floor_4.length; i++){
      floor_4[i] = new Map();
      floor_4[i].init_exit(4, (i+1));
    }
    
    for(int i = 0; i < floor_5.length; i++){
      floor_5[i] = new Map();
      floor_5[i].init_exit(5, (i+1));
    }
    
    wall_set();
    map = floor_1[floor_room - 1];
    
    hit_set();
    
    buff_icon[0] = loadImage("src/buff/def_up.png");
    buff_icon[1] = loadImage("src/buff/taunt.png");
    buff_icon[2] = loadImage("src/buff/patk_up.png");
    buff_icon[3] = loadImage("src/buff/bleed.png");
    buff_icon[4] = loadImage("src/buff/stun.png");
    buff_icon[5] = loadImage("src/buff/no_die.png");
    buff_icon[6] = loadImage("src/buff/heal.png");
    buff_icon[7] = loadImage("src/buff/sleep.png");
    buff_icon[8] = loadImage("src/buff/atk_up.png");
    buff_icon[9] = loadImage("src/buff/bind.png");
    buff_icon[10] = loadImage("src/buff/agi_up.png");
    buff_icon[11] = loadImage("src/buff/bleed.png");
    buff_icon[12] = loadImage("src/buff/patk_up.png");
    buff_icon[13] = loadImage("src/buff/sleep.png");
    buff_icon[14] = loadImage("src/buff/all_up.png");
    buff_icon[15] = loadImage("src/buff/all_up.png");
    
  /************************************************
  try to check if save file can be loaded normally
  *************************************************/ 
    
    
    
    try{
      profile = loadStrings("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("LOAD FAILED");
    }
    
    println(profile.length);
  }                                 //close setup()

  
  
  /************************************************************************
  all style works here, check roomlist to know which case response on what
  *************************************************************************/ 
  
  public void draw(){
    stroke(0);
    fill(0,100,100);
    
    //strokeWeight(1);
    //stroke(0,100,100);
    switch(room)
    {
          
      case 0:     
                  menu();
              
                  if(saved){
                    textAlign(CENTER);
                    text("No character detected, please start new game.", width/2, 150);
                  }
      
        break; 
    
      
      case 1:
            
      jobchoicestyle();
      
        break;
      
      
      case 2:
      //println(frameRate);
      map.drawmap(floor, floor_room);
      background(bg);
      //cur_room_npc();
      //structureline();
      change_room(floor_room);
      move();
      
      map.isBoundary();
      
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
      
      //fill(17, 64, 98, 75);
      //rect(0,0,500, 900);
      //rect(p[0].charX, p[0].charY, sqw, sqh);
      p[0].display();
        break;
      
      case 11:
      
       if(frameCount - start_frame < 100)
       {           
         display_level_up();
       }else{
         room = 2;
       }
       
       break;
      
            
      case 80:
        
        background(0,0,100);
        p[pid].charPanel();
        bag.display_bag();
        
        if(!select_item){
          item_desc(1);
        }
        
        break;
        
      
      case 81:
      
        background(0,0,100);
        p[pid].charPanel();
        bag.display_bag();
        
        bag_option();
        
        break;
      
      //bag full for shop
       case 84:
         fill(60,100,100);
         rect(width/2 - 150, height / 2 - 100, 300, 200);
         textSize(40);
         fill(0,0,100);
         textAlign(CENTER, CENTER);
         text("Bag is full!", width/2, height / 2);
         break;
       
       //confirm purchase
       case 86:
         fill(60,100,100);
         rect(width/2 - 150, height / 2 - 100, 300, 200);
         textSize(40);
         fill(0,0,100);
         textAlign(CENTER, CENTER);
         text("Purchase Complete", width/2, height / 2);
         break;
      
      //confirm save
      case 87:
        fill(60,100,100);
        rect(width/2 - 150, height / 2 - 100, 300, 200);
        textSize(40);
        fill(0,0,100);
        textAlign(CENTER, CENTER);
        text("Save Complete", width/2, height / 2);
        break;
      
      case 88:
        background(0,0,100);
        shop.display_shop();
        
        bag.display_bag();
        item_desc(3);
        break;
      
      case 89:
        shop_menu();
        recover();
        break;
        
      case 90:
               
        battle_UI(enemy_count);
        
        break;
      
      //attack animation
      case 91:
      background(0,0,100);
      ani_draw(atk, battle_list[cur].get_type());
        attackanimation(atk, (battle_list[cur].get_type() + 1) % 2);
        break;
        
      //not enough mp
      case 94:
        fill(0,0,70);
        rect(width/2 - 150, height / 2 - 100, 300, 200);
        textSize(40);
        fill(0,100,80);
        textAlign(CENTER, CENTER);
        text("Not enough MP", width/2, height / 2);
        break;
        
      case 98:
        NPC_join();
        break;
        
      case 99:
        
        option();
        
        break;
    
    }                    //close switch condition for room
 
    
  }                      //close draw()

  
  /*******************************************
  tools function 
  ********************************************/ 
  
  
  
  public void structureline()
  {
    int x,y;
    
    y=0;
    strokeWeight(1);
    stroke(0,100,100);
    textAlign(CENTER, CENTER);
    for (x=0;x<1600;x+=sqw)
    {
      line(x,y,x,y+900);
       stroke(0,0,100);
      text(x/40, x+20, y+10);
    }
    
    x=0;
    
    for (y =0;y<900;y+=sqh)
    {
      line (x,y,x+1600,y);
       stroke(0,0,100);
      text(y/45, x+20, y+10);
    }
    fill(255,100,100);
  }                    // close structureline() for showing pixel line
  
