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
  int total_jobs = 6, floor = 1;
  int steps = 0, encounter;
  float side_margin, height_margin;
  int boxwidth,boxheight;
  int boxX,boxY;
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
    
    
    Monster[] m = new Monster[4];
    //Monster[] mob_list = new Monster[3];
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
        
    frameRate(30);
    
    colorMode(HSB, 100);
    
    loaditemimage();
    
    for(int i = 0; i < 4; i++){
      m[i] = new Monster();
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
      
      background(bg);
      map.draw_npc();
      structureline();
      
      move();
      //isBoundary();
      fill(17, 64, 98, 75);
      //rect(0,0,500, 900);
      rect(p[0].charX, p[0].charY, 40, 45);
        break;
      
      
      case 90:
               
        battle_UI(enemy_count);
              
        break;
            
      case 91:
        
        background(0,0,100);
        
        bag.display_bag();
        
        
        break;
        
      
      case 98:
      
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
    
    for (x=0;x<1600;x+=sqw)
    {
      line(x,y,x,y+900);
    }
    
    x=0;
    
    for (y =0;y<900;y+=sqh)
    {
      line (x,y,x+1600,y);
    }
    fill(255,100,100);
  }                    // close structureline() for showing pixel line
