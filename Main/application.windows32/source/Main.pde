/*******************************************
import library
********************************************/ 
  
  import processing.core.PFont;  
  import java.io.*;
  import java.util.Random;
  import java.lang.Math.*;
  import processing.sound.*;


 
 
/*******************************************
 Create reader and wirter
********************************************/ 
  PrintWriter output;
  BufferedReader read;
  String[] profile;
  

  
  
/*******************************************
 Create style
********************************************/   
  
  PImage bg, bag_img, princess, safe;
  PImage battle_bg, dead;
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
  
  boolean shop_set = false, cell_key = false, box_key = false;
  boolean[] npc_in_cell = {true, true, true, true, true, true};
  boolean boss_battle = false, skill = false;
  boolean play_bgm = true, play_battle = false, play_end = false;
  boolean moving = false, play_menu = true, play_aa = false;
  
  PImage[] buff_icon = new PImage[buff_count];
  PImage[] boss_img = new PImage[5];


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
    
    SoundFile boss_bgm[] = new SoundFile[5];
    SoundFile bgm, battle_bgm, ending, menu;
    //SoundFile move,aa, lv, gold, death, buy, win;
    
  
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
    

    
    img_Set();
    
    audio_init();
    
    load_items();
        
    
    
    hit_set();
    

    
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
  /************************************************
  try to check if save file can be loaded normally
  *************************************************/ 
    
    try{
      profile = loadStrings("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("LOAD FAILED");
    }
    
    map = floor_1[floor_room - 1];
    wall_set();
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
                  
                    if(play_menu){
                      menu.loop();
                      play_menu = false;
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
      npc_on_map();
      map.isBoundary();
      
      p[0].display();
      
      if(play_bgm){
        menu.stop();
        battle_bgm.stop();
        ending.stop();
        bgm.loop();
        play_bgm = false;
      }
        break;
        
      case 3:
        help_letter();
        
        break;
        
      case 4:
        fill(60,100,100);
        rect(width/2 - 200, height / 2 - 100, 400, 200);
        fill(0, 0, 100);
        textAlign(CENTER, CENTER);
        textSize(40);
        text("Door is locked", width/2, height/2);
        break;
        
      case 8:
        equipment_safe();
        break;
      
      case 11:
      
       if(frameCount - start_frame < 60)
       {
          display_gain();  
       }       
       else if(frameCount - start_frame < 120)
       {
          display_level_up();
       }
       
       else{
         
         victory = false;
         
         room = 2;
       }
       
       break;
       
       case 12:
      
       if(frameCount - start_frame < 60)
       {
          display_gain();        
       }              
       else{
         
         victory = false;
         
         room = 2;
       }
       
       break;
            
      case 80:
        
        background(bg);
        p[pid].charPanel();
        bag.display_bag();
        
        if(!select_item){
          item_desc(1);
        }
        
        break;
        
      
      case 81:
      
        background(bg);
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
        if(play_battle){
          ending.stop();
          bgm.stop();
          battle_bgm.loop();
          play_battle = false;
        }       
        battle_UI(enemy_count);
        
        break;
      
      //attack animation
      case 91:
      background(battle_bg);
      ani_draw(atk, battle_list[cur].get_type());
        attackanimation(atk, (battle_list[cur].get_type() + 1) % 2);
        break;
        
      //not enough mp
      case 94:
        fill(60,100,100);
        rect(width/2 - 150, height / 2 - 100, 300, 200);
        textSize(40);
        fill(0,0,100);
        textAlign(CENTER, CENTER);
        text("Not enough MP", width/2, height / 2);
        break;
        
      case 98:
        NPC_join();
        break;
        
      case 99:
        
        option();
        
        break;
        
      //game over
      case 900:
        background(loadImage("src/backgroundimage/evil_castle.jpg"));
        
        fill(60,100,100);
        rect(width/2 - 150, height / 2 - 100, 300, 200);
        textSize(40);
        fill(0,0,100);
        textAlign(CENTER, CENTER);
        text("GAME OVER!!!", width/2, height / 2);
        break;
       
      //ending
      case 999:
        fill(60,100,100);
        rect(width/2 - 150, height / 2 - 100, 300, 200);
        textSize(40);
        fill(0,0,100);
        textAlign(CENTER, CENTER);
        text("Thank you for saving me Adam.", width/2, height / 2);
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
  
