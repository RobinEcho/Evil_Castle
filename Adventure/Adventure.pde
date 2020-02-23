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
  
  PImage bg, bag_img;
  PFont font;
  int boss_defeated = 0;
  int total_jobs = 6, floor = 1, floor_room = 1;
  int steps = 0, encounter;
  float side_margin, height_margin;
  float rate = 60;
  int boxwidth,boxheight;
  int boxX,boxY;
  int item_count = 102;
  int grid_width = 40, grid_height = 45;
  int sqw = 40, sqh = 45;
  int width = 1600, height = 900;  
   
   
  
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
    Monster[] m = new Monster[4];
    
    Map[] floor_1 = new Map[5];
    Map[] floor_2 = new Map[6];
    Map[] floor_3 = new Map[9];
    Map[] floor_4 = new Map[8];
    Map[] floor_5 = new Map[7];
    
    Player[] p = new Player[4];
    Bag bag = new Bag(8, 5);        //Bag(row,column)
  
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
  /************************************************
  try to check if save file can be loaded normally
  *************************************************/ 
    
    try{
      output = createWriter("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("SAVE FAILED");
    }
    
    try{
      profile = loadStrings("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      text("LOAD FAILED", 100, 200);
    }
    
    
  }                                 //close setup()

  
  
  /************************************************************************
  all style works here, check roomlist to know which case response on what
  *************************************************************************/ 
  
  public void draw(){
    structureline();
    switch(room)
    {
          
      case 0:     
                  menu();
              
                  if(saved){
                    text("No character detected, please start new game.", 220, 150);
                  }
      
        break; 
    
      
      case 1:
            
      jobchoicestyle();
      
        break;
      
      
      case 2:
      
      map.drawmap(floor, floor_room);
      background(bg);
      //cur_room_npc();
      structureline();
      change_room();
      move();
      
      //isBoundary();
      fill(17, 64, 98, 75);
      //rect(0,0,500, 900);
      rect(p[0].charX, p[0].charY, 40, 45);
        break;
      
      
      case 90:
               
        battle_UI(enemy_count);
        
        break;
            
      case 80:
        
        background(0,0,100);
        
        bag.display_bag();
        
        
        break;
        
      
      case 81:
      
        background(0,0,100);
        
        bag.display_bag();
        
        bag_option();
        
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
