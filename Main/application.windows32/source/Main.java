import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.core.PFont; 
import java.io.*; 
import java.util.Random; 
import java.lang.Math.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {

/*******************************************
import library
********************************************/ 
  
    
  
  
  
  


 
 
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
        size(1600, 900);
        
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
  
public void audio_init(){      
  for(int i = 0; i < 5; i++){
    boss_bgm[i] = new SoundFile(this, "boss" + (i+1) + ".mp3");
  }
  
    bgm = new SoundFile(this, "BGM.mp3");
    battle_bgm = new SoundFile(this, "battle.mp3");
    ending = new SoundFile(this, "end.mp3");
    menu = new SoundFile(this, "main_menu.mp3");
}
boolean inBag = false;
boolean  bagopt = false;

  /*******************************************
  Class Bag
  ********************************************/ 
class Bag{
  
  
  public int[][] inv;
  public int row, col;
  int UI_width, UI_height, UI_dis;
  int vertical_margin, horizontal_margin;
  float square_width, square_height, vs, hs;
  
  public Bag(int row, int col){
    
    inv = new int[row][col];
    this.row = row;
    this.col = col;
    UI_width = 500;
    UI_height = 800;
    UI_dis = 100;
    vertical_margin = (height - UI_height)/2;
    horizontal_margin = (width - 2*UI_width - UI_dis)/2;
    
    for(int i = 0; i < row; i++){
      for(int j = 0; j < col; j++)
      {
        
        //image(item_list[j%3], (j+1)*hs + (j*square_width) + (width + UI_dis)/2, (i+1)*vs + (i * square_height) + vertical_margin, square_width, square_height);
        //inv[i][j] = r.nextInt(item_count);
        inv[i][j] = item_count - 1;
        //inv[i][j] = i * col + j;
        
        if(i == 0 & j ==0){
          inv[i][j] = 90;
        }
        if(i == 0 & j ==1){
          inv[i][j] = 93;
        }
      }    //for loop(j)
    }    //for loop (i)
    
    //inv[0][4] = 50;
    //inv[1][4] = 70;
    //inv[2][4] = 85;
  }                    //close Bag()
  
  
  /*******************************************
  To display bag
  ********************************************/ 

  public void display_bag(){
    BagSquare(1);
    if(move_item){
      image(item_list[temp_item_code].img, mouseX - (bag.square_width/2), mouseY - (bag.square_height/2), bag.square_width, bag.square_height);
    }
  }                    //close display_bag()
  
/*-----------------------------------------------------------------------------------------------------*/


  /*******************************************
  BagSquare base on rows and column
  ********************************************/ 

  public void BagSquare(int bag_mode){
    
    square_width = (float)UI_width / (float)(col+((col+1)/2.0f));
    square_height = (float)UI_height / (float)(row+((row+1)/2.0f));
    vs = square_height / 2;
    hs = square_width / 2;
    
    noStroke();
    fill(60, 100, 100);
    
    switch(bag_mode){
      case 1:
        rect((width + UI_dis)/2, vertical_margin, UI_width, UI_height);
        
        fill(0, 0, 100);
        
        for(int i = 0; i < row; i++){
          for(int j = 0; j < col; j++)
          {
            image(item_list[inv[i][j]].img, (j+1)*hs + (j*square_width) + (width + UI_dis)/2, (i+1)*vs + (i * square_height) + vertical_margin, square_width, square_height);
            
          }    //for loop(j)
        }    //for loop (i)
        break;
        
        case 2:
          rect(width/2 - UI_width, vertical_margin, UI_width * 2, (( (row / 2 + row % 2) + 1) *vs + (row / 2 + ((row) % 2)) * square_height));
        fill(0, 0, 100);
        
        for(int i = 0; i < row; i++){
          for(int j = 0; j < col; j++)
          {
            if(i > row / 2 - ((row + 1) % 2)){
              image(item_list[inv[i][j]].img, (j+1)*hs + (j*square_width) + width/2, ((i+1-(row / 2 + row % 2))*vs + ((i-(row / 2 + ((row) % 2))) * square_height))+ vertical_margin, square_width, square_height);
            }else{
              image(item_list[inv[i][j]].img, (j+1)*hs + (j*square_width) + width/2 - UI_width, ((i+1)*vs + (i * square_height))+ vertical_margin, square_width, square_height);
            }
            
          }    //for loop(j)
        }    //for loop (i)
        
        break;
      }
    }                    //close BagSquare()
   
}                    //cloase class Bag
/*******************************************
 have battle with monster
********************************************/

boolean dodge, esc = true;
boolean inBattle = false, victory = false;
boolean show_damage = false, skill_used = false;;
boolean arrive = false, returned = false;
int battle_UI_margin = 10;
float c_width = (width - battle_UI_margin * 5)/4, c_height = height/3 - 2 * battle_UI_margin;
float cx, cy = height*2/3 + battle_UI_margin;
  float attacker_x, attacker_y;
  float defender_x, defender_y;
  float distance_x, distance_y;
  int atk, def, mob_skill;
  int total_exp = 0,total_gold = 0;

/*******************************************
 calculation damage
********************************************/

public void dmg(float x, int rec, int rec_type){
  show_damage = true;
  start_frame = frameCount;
  
  if(rec_type == 1){
    hit[0] = rec;
    p[rec].dec_hp(x);
    p[rec].calc_stats();
    
    dmg_x = rec * pc_width/2.0f + pcx + pc_width/2;
    dmg_y = rec*pc_height*1.5f + pcy + pc_height;
    display_dmg = (int)x;
  }else{
    hit[0] = rec;
    m[rec].dec_hp(x);
    m[rec].calc_stats();
    
    enemy_start_x = battle_UI_margin + (float)enemy_width;
    enemy_start_y = battle_UI_margin + enemy_height/2.0f;
    enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
    enemy_y = enemy_start_y;
    for(int i = 0; i < enemy_count; i++){
      if(i != 0){
        if(i % 2 == 0){
          enemy_x += enemy_width * m[i-1].get_mod();
        }else{
          enemy_x -= enemy_width * m[i-1].get_mod();
        }
      }
      
      if(rec == i){
          dmg_x = enemy_x + enemy_width * m[rec].get_mod();
          dmg_y = enemy_y + enemy_height * m[rec].get_mod();
      }
    
      enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
    }
    display_dmg = (int)x;
  }
}

//def_type 1 = player, 0 = monster
public void attack(int attacker, int defender, int def_type){
  start_frame = frameCount;
  float damage = 0.0f;
  play_aa = true;
  
  if(def_type == 0){
    pid = attacker;
    mid = defender;
    
    atk = attacker;
    def = defender;
    attacker_x = p[attacker].battle_x;
    attacker_y = p[attacker].battle_y;
    defender_x = m[defender].battle_x;
    defender_y = m[defender].battle_y;
    distance_x = attacker_x - defender_x + m[defender].get_mod() * enemy_width;
    distance_y = attacker_y - defender_y;
    
    damage = p[attacker].get_patk() - m[defender].get_pdef();
    //println("a patk: " + p[attacker].get_patk() + " m pdef: " + m[defender].get_pdef());
    if(m[mid].buff_list[7] > 0){
        m[mid].buff_round[7] = 0;        
    }
    
    if(m[mid].buff_list[13]> 0){
        m[mid].buff_round[13] = 0;        
    } 
    
  //monster normal attack
  }else{
    mid = attacker;
    pid = defender;
    
    atk = attacker;
    def = defender;
    attacker_x = m[attacker].battle_x;
    attacker_y = m[attacker].battle_y;
    defender_x = p[defender].battle_x;
    defender_y = p[defender].battle_y;
    distance_x = defender_x - attacker_x + m[attacker].get_mod() * enemy_width;
    distance_y = defender_y - attacker_y;
    println("atk: " + attacker + "def: " + defender);
    damage = m[attacker].get_patk() - p[defender].get_pdef();
    
    
}
  
  if(damage < 1){
    damage = 1;
  }
  
    dodge = false;
  
   if_dodge(attacker,defender, (def_type + 1)% 2);
  
  if(dodge){
    
    damage = 0;
    
    dmg(damage, defender, def_type);
}
  /*
  
   
  */  
  else{
  
    dmg(damage, defender, def_type);
  
  }
  
  room= 91;
}


public void skill(int releaser, int receiver, int def_type, int skill_id){
  skill_used = true;
  atk = releaser;
  def = receiver;
  start_frame = frameCount;
  skill = true;
  float damage;
  if(def_type == 0){
    
    switch(p[releaser].skills.skill[skill_id].dmg_type){
        // cause true damage
        case 0:              
              if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                pid = releaser;
                mid = receiver;
                hit[0] = receiver;
                
                p[releaser].skills.skill[skill_id].skilldamage();
                
                damage = p[releaser].skills.skill[skill_id].damage;
                
                if(damage < 1){
                        damage = 1;
                      }
                      
                if(m[mid].buff_list[7] > 0){
                        m[mid].buff_round[7] = 0;        
                    }
                    
                    if(m[mid].buff_list[13]> 0){
                        m[mid].buff_round[13] = 0;        
                    }      
                
                p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,receiver,def_type);
                p[releaser].calc_stats();     
                
                room = 91;
          
            }else{
              room = 94;
                select_target = false;
            }

         break;
              // cause physical damage
        case 1:
              if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                pid = releaser;
                mid = receiver;
                hit[0] = receiver;

                p[releaser].skills.skill[skill_id].skilldamage();
                
                damage = p[releaser].skills.skill[skill_id].damage-m[receiver].get_pdef();
                
                if(damage < 1){
                        damage = 1;
                      }
                      
                if(m[mid].buff_list[7] > 0){
                        m[mid].buff_round[7] = 0;        
                    }
                    
                    if(m[mid].buff_list[13]> 0){
                        m[mid].buff_round[13] = 0;        
                    } 
                
                p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,receiver,def_type);
                p[releaser].calc_stats();  
                
                room = 91;
                
          //not enough mp      
          }else{
                room = 94;
                select_target = false;
              }
          break;
                // cause magical damage
        case 2:
              if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                pid = releaser;
                mid = receiver;
                hit[0] = receiver;
                
                p[releaser].skills.skill[skill_id].skilldamage();                
                
                damage = p[releaser].skills.skill[skill_id].damage - m[receiver].get_mdef();
                
                if(damage < 1){
                        damage = 1;
                      }
                      
                if(m[mid].buff_list[7] > 0){
                        m[mid].buff_round[7] = 0;        
                    }
                    
                    if(m[mid].buff_list[13]> 0){
                        m[mid].buff_round[13] = 0;        
                    } 
                
                p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,receiver,def_type);
                p[releaser].calc_stats();
                
                room = 91;
            
          //not enough mp  
          }else{
                room = 94;
                select_target = false;
              }
              
          break;
                  // recovery mp or hp
       case 3:
             if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                 pid = receiver;
                p[releaser].skills.skill[skill_id].skilldamage();
                
                       if(p[releaser].skills.skill[skill_id].healing){
                         p[receiver].rec_hp( p[releaser].skills.skill[skill_id].heal);
                         p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);
                         p[releaser].calc_stats();
                         p[receiver].calc_stats();
                     }
                     else{
                         p[receiver].rec_mp(p[releaser].skills.skill[skill_id].heal);
                         p[releaser].dec_mp(p[releaser].skills.skill[skill_id].mp_dec);
                         p[releaser].calc_stats();
                         p[receiver].calc_stats();
                     }
                     
                     room = 91;
             }
             else{
               room = 94;
                select_target = false;
             }
           break;
                     // buff set
      case 4:
            if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                pid = receiver;
                p[releaser].skills.skill[skill_id].skilldamage();
                
                       p[releaser].skills.skill[skill_id].skillUsed();
                       p[releaser].calc_stats();

                       
                       p[releaser].dec_mp(p[releaser].skills.skill[skill_id].mp_dec);
                       p[releaser].calc_stats();   
                       
                       room = 91;
             }
             else{
               room = 94;
                select_target = false;
             }
                         
           break;
    }
  }
  
  else{
    //m[attacker].skills.skill[skill_id].skilldamage();
     mob_skill = skill_id;
     //println("monster use skill");
     
     mid = releaser;
     
     pid = receiver;

    switch(m[releaser].skills.skill[skill_id].dmg_type){
              // cause physical damage
        case 1:
              if(m[releaser].get_cur_mp() - m[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                hit[0] = receiver;

                m[releaser].skills.skill[skill_id].skilldamage();
                
                damage = m[releaser].skills.skill[skill_id].damage - p[receiver].get_pdef();
                
                if(damage < 1){
                        damage = 1;
                      }
               
                m[releaser].dec_mp( m[releaser].skills.skill[skill_id].mp_dec);  
                
                dmg(damage,receiver,def_type);
                
                m[releaser].calc_stats();
                p[receiver].calc_stats();
                
                room = 91;
               
          }
              else{
                select_target = false;
              }
          break;
                // cause magical damage
        case 2:
              if(m[releaser].get_cur_mp() - m[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                hit[0] = receiver;
                
                m[releaser].skills.skill[skill_id].skilldamage();                
                
                damage = m[releaser].skills.skill[skill_id].damage - p[receiver].get_mdef();
                
                if(damage < 1){
                        damage = 1;
                      }

                m[releaser].dec_mp( m[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,receiver,def_type);
                m[releaser].calc_stats();
                p[receiver].calc_stats();
                
                room = 91;
            
          }
              else{
                select_target = false;
              }
              
          break;
                  // recovery mp or hp
       case 3:
             if(m[releaser].get_cur_mp() - m[releaser].skills.skill[skill_id].mp_dec >= 0){
               
                m[releaser].skills.skill[skill_id].skilldamage();
                
                       if(m[releaser].skills.skill[skill_id].healing){
                         m[releaser].rec_hp( m[releaser].skills.skill[skill_id].heal);
                         m[releaser].dec_mp( m[releaser].skills.skill[skill_id].mp_dec);
                         m[releaser].calc_stats();
                         m[receiver].calc_stats();
                     }
                     else{
                         m[releaser].rec_mp(m[releaser].skills.skill[skill_id].heal);
                         m[releaser].dec_mp(m[releaser].skills.skill[skill_id].mp_dec);
                         m[releaser].calc_stats();
                         m[receiver].calc_stats();
                     }
                     
                     room = 91;
             }
             else{
                select_target = false;
             }
           break;
    }
  }
}

public void ani_draw(int cover, int type){
  textSize(40);
  pc_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt + 1);
  pc_height = (height*2/3 - 3.0f * battle_UI_margin)/ (float)(max_pt + 2);
  pcx = width*2/3.0f + battle_UI_margin + (float)(max_pt/2.0f) * pc_width;
  pcy = battle_UI_margin + pc_height/2.0f;
  
  enemy_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt+1);
  enemy_height = (height*2/3.0f - 3.0f * battle_UI_margin)/ (float)(max_pt+2);
  enemy_start_x = battle_UI_margin + (float)enemy_width;
  enemy_start_y = battle_UI_margin + enemy_height/2.0f;
  enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
  enemy_y = enemy_start_y;
  
  //Draw enemies
  noStroke();
  for(int i = 0; i < enemy_count; i++){
    if(i == 0){
      if(m[0].is_alive()){
        if(type == 0){
          if(cover != i){
            image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
            m[i].battle_x = enemy_x;
            m[i].battle_y = enemy_y;
          }
        }else{
          image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
          m[i].battle_x = enemy_x;
          m[i].battle_y = enemy_y;
        }
      }else{
        image(dead, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
      }
    }else{
      
      if(i % 2 == 0){
        enemy_x += enemy_width * m[i-1].get_mod();
      }else{
        enemy_x -= enemy_width * m[i-1].get_mod();
      }
      
      if(m[i].is_alive()){
        if(type == 0){
          if(cover != i){
            image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
            m[i].battle_x = enemy_x;
            m[i].battle_y = enemy_y;
          }
        }else{
          image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
          m[i].battle_x = enemy_x;
          m[i].battle_y = enemy_y;
        }
      }else{
        image(dead, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }
    }
    
    enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
    //println("enemy y: " + enemy_y + " i: " + i);
    //println("mob lv: " + m[i].get_level() + " patk: " + m[i].get_patk());
  }
  
  //Draw player status boxes
  p_box();
  
  //Draw player images and player status
  for(int i = 0; i < c_pt; i++){
    
      p[i].battle_x = i*pc_width/2.0f + pcx;
      p[i].battle_y = i*pc_height*1.5f + pcy;
      
    if(p[i].is_alive()){
      
      if(type == 1){
        if(cover != i){
          image(p[i].battle_img, p[i].battle_x, p[i].battle_y, pc_width, pc_height);
        }
      }else{
        image(p[i].battle_img, p[i].battle_x, p[i].battle_y, pc_width, pc_height);
      }
      
      //over head hp bar
      hp_percent = (float)p[i].get_cur_hp() / (float)p[i].get_max_hp();
      strokeWeight(1);
      stroke(0,100,0);
      fill(0,0,100);
      rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width, battle_UI_margin, 50);
      fill(0,100,100);
      rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width * hp_percent, battle_UI_margin, 50);
    }else{
      image(dead, p[i].battle_x, p[i].battle_y, pc_width, pc_height);
    }
      
        //player stats
        p_stats(i);
      
    }
}

public void attackanimation(int attacker, int def_type){
  
  display_buff_icons();
  
  if(skill){
    
    if(frameCount - start_frame < 60){
      pc_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt + 1);
      pc_height = (height*2/3 - 3.0f * battle_UI_margin)/ (float)(max_pt + 2);
      pcx = width*2/3.0f + battle_UI_margin + (float)(max_pt/2.0f) * pc_width;
      pcy = battle_UI_margin + pc_height/2.0f;
      
      enemy_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt+1);
      enemy_height = (height*2/3.0f - 3.0f * battle_UI_margin)/ (float)(max_pt+2);
      enemy_start_x = battle_UI_margin + (float)enemy_width;
      enemy_start_y = battle_UI_margin + enemy_height/2.0f;
      enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
      enemy_y = enemy_start_y;
    
      //monster use skill
      if(def_type == 1){
        
        for(int i = 0; i < enemy_count; i++){
          if(i != 0){
            
            if(i % 2 == 0){
              enemy_x += enemy_width * m[i-1].get_mod();
            }else{
              enemy_x -= enemy_width * m[i-1].get_mod();
            }
            
          }
          
          if(battle_list[cur].get_id() == m[i].get_id()){
            
              image(m[i].battle_img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
            
          }
          enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
        }
       
      //player skill  
      }else{
        
        for(int i = 0; i < c_pt; i++){
      
          p[i].battle_x = i*pc_width/2.0f + pcx;
          p[i].battle_y = i*pc_height*1.5f + pcy;
          
          if(battle_list[cur].get_id() == p[i].get_id()){
            if(battle_list[cur].get_id() == 0){
            
              image(loadImage("src/player/battle/Player_attack.png"), p[i].battle_x, p[i].battle_y, pc_width, pc_height);
            }else{
              image(loadImage("src/player/battle/" + p[i].job.name + "_attack.png"), p[i].battle_x, p[i].battle_y, pc_width, pc_height);
            }
            
            image(battle_list[cur].skills.skill[command].icon, p[i].battle_x - pc_width - 10, p[i].battle_y, pc_width, pc_height);
            
          }
        }
      }
    }else{
      skill = false;
      room = 90;  
    }
    
    
  //normal attack animation
  }else{
    if(def_type == 0){
      noStroke();
      //fill(0,0,100);
      //rect(p[attacker].battle_x, p[attacker].battle_y, pc_width, pc_height);
      
      if(!arrive){
        if(attacker_x > defender_x + m[def].get_mod() * enemy_width){
          //println("move");
          //println("atk_x: " + attacker_x + " atk_y: " + attacker_y);
          image(p[attacker].battle_img, attacker_x, attacker_y, pc_width, pc_height);
        
          attacker_x -= distance_x/rate;
          attacker_y -= distance_y/rate;
        }else{
          arrive = true;
        }
      }else{
        if(attacker_x < p[attacker].battle_x){
          image(p[attacker].battle_img, attacker_x, attacker_y, pc_width, pc_height);
        
          attacker_x += distance_x/rate;
          attacker_y += distance_y/rate;
        }else{
          returned = true;
        }
      }
      
      if(returned){
        room = 90;
        battle_mode = 10;
        arrive = false;
        returned = false;
      }
      
      //println("monster x: " + m[def].battle_x + " px : " + attacker_x);
      //println("monster y: " + m[def].battle_y + " py : " + attacker_y);
    }else{
      //println("monster attack");
      noStroke();
      //fill(0,0,100);
      //rect(p[attacker].battle_x, p[attacker].battle_y, pc_width, pc_height);
      
      if(!arrive){
        //println("monster go");
        if(attacker_x + m[atk].get_mod() * enemy_width < defender_x ){
          
          image(m[attacker].img, attacker_x, attacker_y, m[atk].get_mod() * enemy_width, m[atk].get_mod() * enemy_height);
        
          attacker_x += distance_x/rate;
          attacker_y += distance_y/rate;
        }else{
          arrive = true;
        }
        
      }else{
        //println("monster back");
        if(attacker_x > m[atk].battle_x){
          image(m[attacker].img, attacker_x, attacker_y, m[atk].get_mod() * enemy_width, m[atk].get_mod() * enemy_height);
        
          attacker_x -= distance_x/rate;
          attacker_y -= distance_y/rate;
        }else{
          returned = true;
        }
      }
      
      if(returned){
        room = 90;
        battle_mode = 10;
        arrive = false;
        returned = false;
      }
    }
    
  }

}

public void escape(){
  
    int escape = r.nextInt(100);
    
    if(escape >= 60){
      
      inBattle = false;
      esc = true;
  
      for(int i = 0; i < boss_bgm.length; i++){
        boss_bgm[i].stop();
      }
      
      battle_bgm.stop();
      
      room = map.get_map_room();
    }
    
    else{

      
      cur = (cur + 1) % (c_pt + enemy_count);
      //println("escape fail, cur: " + cur);
      esc = false;
      if(battle_list[cur].get_type() == 0){
        battle_mode = -1;
      }else{
        battle_mode = 0;
      }
    
    }
      
}

public void if_dodge(int attacker,int defender, int attacker_type){
    
       float dodge_rate;
       
       if(attacker_type == 1){
         dodge_rate = (m[defender].get_spd()-p[attacker].get_spd())/m[defender].get_spd();
       }else{
         dodge_rate = (p[defender].get_spd()-m[attacker].get_spd())/p[defender].get_spd();
       }
       
        if(r.nextInt(10000) < dodge_rate * 10000)
        {
          dodge = true;
        
        }else{
          dodge = false;
        }
     
}

public void enemy_setup(){
  for(int i = 0; i < enemy_count; i++){
    m[i].set_id(i);
    
    if(elite_count - i > 0){
      m[i].setMType(2);
      m[i].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[i].init_stats();
    }else{
      m[i].setMType(1);
      m[i].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[i].init_stats();
    }
  }
}

public Units[] round_order(){
  Units[] u  = new Units[enemy_count + c_pt];
  Units temp;
  
  for(int i = 0; i < u.length; i++){
    if(i < c_pt){
      u[i] = p[i];
    }else{
      u[i] = m[i - c_pt];
    }
  }
  
  for(int i = 0; i < u.length - 1; i++){
    for(int j = 1; j < u.length; j++){
      if(u[i].get_spd() < u[j].get_spd()){
        temp = u[i];
        u[i] = u[j];
        u[j] = temp;
      }
    }
  }
  
  return u;
}

public void battle_end(){
  int player_dead_count = 0, monster_dead_count = 0;
  
  for(int i = 0; i < c_pt; i++){
    if(!p[i].is_alive()){
      player_dead_count++;
    }
  }
  
  for(int i = 0; i < enemy_count; i++){
    if(!m[i].is_alive()){
      monster_dead_count++;
    }
  }
  
  if(player_dead_count == c_pt){
    
    room = 900;
    
    inBattle = false;
    
    room = 2;
  }
  else if(monster_dead_count == enemy_count)
  {
    //println("Victory!");
    
    start_frame = frameCount;
    
    inBattle = false;
    
    victory = true;
    
    room = 12;
    
    total_exp = 0;
    total_gold = 0;
    
    //gain exp and gold while victory
    for(int i = 0; i < c_pt; i++)
    {
      for(int j = 0;j<enemy_count;j++)
      {
         total_exp += m[i].getExp();
         total_gold += m[i].get_gold();      
       }     
       p[i].gainExp(total_exp);
    }
     p[0].gold_inc(total_gold);
      
     display_gain(); 
      
    //caculate buff
    for(int i = 0; i < c_pt; i++)
    {
      for(int j = 0;j<buff_count;j++)
      {
        p[i].buff_list[j] = 0;
        p[i].buff_round[j] = 0;
      }
    }
    
    for(int i = 0; i < enemy_count; i++)
    {
      for(int j = 0;j < buff_count;j++)
      {
        m[i].buff_list[j] = 0;
        m[i].buff_round[j] = 0;
      }
    }
    
    if(boss_battle){
      
      
      boss_battle = false;
      boss_defeated++;
      
      switch(floor){
        case 1:
          //remove boss
          floor_1[1].del_npc(11,10);
          
          // open door
          floor_1[1].del_npc(27,10);
          floor_1[1].del_npc(27,11);
          floor_1[1].del_npc(27,12);
          break;
          
        case 2:
          //remove boss
          floor_2[3].del_npc(20,6);
          //println("remove 2");
          
          //open door to floor 3
          floor_2[0].del_npc(19,5);
          break;
          
        case 3:
          //remove boss
          floor_3[2].del_npc(15,7);
          floor_3[2].del_npc(16,7);
          floor_3[2].del_npc(15,8);
          floor_3[2].del_npc(16,8);
          //println("remove 3");
          
          // open door to floor 4
          floor_3[7].del_npc(20,4);
          break;
          
        case 4:
          //remove boss
          floor_4[6].del_npc(20,9);
          
          // open door to floor 5
          floor_4[6].del_npc(20,5);
        break;
        
        case 5:
          //remove boss
          floor_5[5].del_npc(20,6);
          floor_5[5].del_npc(21,6);
          floor_5[5].del_npc(20,7);
          floor_5[5].del_npc(21,7);
          
          //open door to princess
          floor_5[5].del_npc(13,10);
          floor_5[5].del_npc(13,11);
          break;
      }
      
      
        if(!cell_key){
          for(int i = 0; i < bag.inv.length; i++){
            for(int j = 0; j < bag.inv[i].length; j++){
              if(bag.inv[i][j] == item_count - 1){
                bag.inv[i][j] = 99;
                i = bag.inv.length - 1;
                j = bag.inv[i].length - 1;
              }
            }
          }
          
          cell_key = true;
        }
        
        
       if(floor > 1){ 
        if(!box_key){
          for(int i = 0; i < bag.inv.length; i++){
            for(int j = 0; j < bag.inv[i].length; j++){
              if(bag.inv[i][j] == item_count - 1){
                bag.inv[i][j] = 100;
                i = bag.inv.length - 1;
                j = bag.inv[i].length - 1;
              }
            }
          }
          
          box_key = true;
        }
      }
    }
    
      loot();

    for(int i = 0; i < boss_bgm.length; i++){
      boss_bgm[i].stop();
    }
    
    battle_bgm.stop();
    
    play_bgm = true;
  }
}

public void display_damage(int target, int def_type){
  //println("display damage");
  fill(60,100,100);
  noStroke();
  rect(width/4, bag.vertical_margin + battle_UI_margin * 3, width/2, command_radius * 1.5f, 20);
  
  stroke(0,0,100);
  strokeWeight(2);
  textSize(30);
  fill(0,0,100);
  if(!esc){
    text("Escape Failed!" , width/2 , bag.vertical_margin + battle_UI_margin * 7);
  }
  switch(def_type){
    case 0:
      if(skill_used){
        if(battle_list[cur].skills.skill[command].dmg_type == 3){
          text(battle_list[cur].name + " Used " + battle_list[cur].skills.skill[command].name + " on " + p[target].name, width/2, bag.vertical_margin + battle_UI_margin * 10);
        }else{
          text(battle_list[cur].name + " Used " + battle_list[cur].skills.skill[command].name + " on " + m[target].name, width/2, bag.vertical_margin + battle_UI_margin * 10);
          text(battle_list[cur].name + " dealt " + display_dmg + " to " + m[target].name, width/2, bag.vertical_margin + battle_UI_margin * 13);
        }
      }else{
        text(battle_list[cur].name + " dealt " + display_dmg + " to " + m[target].name, width/2, bag.vertical_margin + battle_UI_margin * 10);
      }
      break;
    case 1:
    
      if(skill_used){
        if(battle_list[cur].skills.skill[mob_skill].dmg_type == 3){
          text(battle_list[cur].name + " used " + battle_list[cur].skills.skill[mob_skill].name + " on " + m[target].name, width/2, bag.vertical_margin + battle_UI_margin * 10);
        }else{
          text(battle_list[cur].name + " used " + battle_list[cur].skills.skill[mob_skill].name + " on " + p[target].name, width/2, bag.vertical_margin + battle_UI_margin * 10);
          text(battle_list[cur].name + " dealt " + display_dmg + " to " + p[pid].name, width/2, bag.vertical_margin + battle_UI_margin * 13);
        }
      }else{
        text(battle_list[cur].name + " dealt " + display_dmg + " to " + p[pid].name, width/2, bag.vertical_margin + battle_UI_margin * 10);
      }
      break;
  }
  skill_used = false;
}

public void hit_set(){
    for(int i = 0; i < max_pt; i++){
      hit[i] = -1;
    }
}
class Item{
  public int id;
  PImage img;
  public int level = 1, gold = 0;
  protected int str = 0, con = 0, intel = 0, wis = 0, agi = 0, patk = 0, pdef = 0, matk = 0, mdef = 0, spd = 0, hp = 0, mp = 0, rec_hp = 0, rec_mp = 0;
  public String name;
  protected String type;
  
  public Item(){
    
  }
  
/*****************************
*  initial stats for all items
******************************/ 
  public void init_stats(){
    switch(this.id){
      /*****************************
      *  HP consumable
      ******************************/ 
      case 11:
        this.name = "Small HP Potion";
        this.rec_hp = 100;
        this.rec_mp = 0;
        this.gold = 50;
        break;
      case 12:
        this.name = "Medium HP Potion";
        this.rec_hp = 500;
        this.rec_mp = 0;
        this.gold = 150;
        break;
      case 13:
        this.name = "Large HP Potion";
        this.rec_hp = 1000;
        this.rec_mp = 0;
        this.gold = 400;
        break;
    
    
      /*****************************
      *  MP consumable
      ******************************/ 
      case 21:
        this.name = "Small MP Potion";
        this.rec_mp = 100;
        this.rec_hp = 0;
        this.gold = 50;
        break;
      case 22:
        this.name = "Small MP Potion";
        this.rec_mp = 500;
        this.rec_hp = 0;
        this.gold = 150;
        break;
      case 23:
        this.name = "Small MP Potion";
        this.rec_mp = 1000;
        this.rec_hp = 0;
        this.gold = 400;
        break;
        
      /*****************************
      *  max potion
      ******************************/ 
      case 31:
        this.name = "Max Potion";
        this.rec_hp = 99999;
        this.rec_mp = 99999;
        this.gold = 1000;
        break;
        
      /*****************************
      *  revive potion
      ******************************/ 
      case 39:
        this.name = "Revive";
        this.rec_hp = 10;
        this.rec_mp = 0;
        this.gold = 100;
        break;
       
      /*****************************
      *  Special Items
      ******************************/ 
      case 90:
        this.name = "Chest";
        break;
      
      case 91:
        this.name = "Prison Cell Key";
        break;
        
      case 92:
        this.name = "Golden Key";
        break;
      /*****************************
      *  Knight equipment
      ******************************/
      //weapon
      case 111:
        this.name = "Old Sword";
        str = 2; con = 5; intel = 0; wis = 0; agi = 0; patk = 5; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 112:
        this.name = "Great Sword";
        str = 6; con = 10; intel = 0; wis = 0; agi = 0; patk = 15; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 113:
        this.name = "Knight Sword";
        str = 12; con = 15; intel = 0; wis = 0; agi = 0; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 114:
        this.name = "Light Saber";
        str = 20; con = 20; intel = 0; wis = 0; agi = 0; patk = 70; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 115:
        this.name = "Devil's Sword - Dante";
        str = 30; con = 30; intel = 0; wis = 0; agi = 0; patk = 90; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 121:
        this.name = "Worn Breastplate";
        str = 0; con = 10; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 5; spd = 0; hp = 50; mp = 0;
        break;
      case 122:
        this.name = "Knight Armour";
        str = 0; con = 15; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 10; spd = 0; hp = 80; mp = 0;
        break;
      case 123:
        this.name = "Shining Silver Breastplate";
        str = 0; con = 25; intel = 0; wis = 1; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 20; spd = 0; hp = 105; mp = 0;
        break;
      case 124:
        this.name = "Dragonscale Breastplate";
        str = 0; con = 30; intel = 0; wis = 2; agi = 0; patk = 0; pdef = 70; matk = 0; mdef = 35; spd = 0; hp = 140; mp = 0;
        break;
      case 125:
        this.name = "Imperial Armour";
        str = 0; con = 40; intel = 0; wis = 3; agi = 0; patk = 0; pdef = 100; matk = 0; mdef = 60; spd = 0; hp = 250; mp = 0;
        break;
      
      //accessory
      case 131:
        this.name = "Ordinary Handguard";
        str = 0; con = 4; intel = 0; wis = 0; agi = 0; patk = 10; pdef = 10; matk = 0; mdef = 5; spd = 0; hp = 30; mp = 30;
        break;
      case 132:
        this.name = "Guardian";
        str = 0; con = 8; intel = 0; wis = 0; agi = 0; patk = 20; pdef = 20; matk = 0; mdef = 10; spd = 0; hp = 60; mp = 40;
        break;
      case 133:
        this.name = "Blood Hanguard";
        str = 5; con = 12; intel = 0; wis = 0; agi = 0; patk = 30; pdef = 30; matk = 0; mdef = 15; spd = 0; hp = 90; mp = 50;
        break;
      case 134:
        this.name = "Mysterious Hanguard";
        str = 10; con = 16; intel = 0; wis = 0; agi = 0; patk = 40; pdef = 40; matk = 0; mdef = 20; spd = 0; hp = 120; mp = 60;
        break;
      case 135:
        this.name = "Emperor's Hand";
        str = 15; con = 20; intel = 0; wis = 0; agi = 0; patk = 50; pdef = 50; matk = 0; mdef = 25; spd = 0; hp = 300; mp = 70;
        break;
      
      /*****************************
      *  Paladin equipment
      ******************************/ 
      //weapon
      case 211:
        this.name = "Old Shield";
        str = 2; con = 2; intel = 2; wis = 1; agi = 0; patk = 3; pdef = 0; matk = 3; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 212:
        this.name = "Silve Shield";
        str = 3; con = 3; intel = 3; wis = 2; agi = 0; patk = 4; pdef = 0; matk = 4; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 213:
        this.name = "Holy Shield";
        str = 4; con = 4; intel = 4; wis = 3; agi = 0; patk = 5; pdef = 0; matk = 5; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 214:
        this.name = "Magic Shield";
        str = 5; con = 5; intel = 5; wis = 4; agi = 0; patk = 6; pdef = 0; matk = 6; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 215:
        this.name = "Captain America's Shield";
        str = 6; con = 6; intel = 6; wis = 5; agi = 0; patk = 7; pdef = 0; matk = 7; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 221:
        this.name = "Old Armour";
        str = 1; con = 3; intel = 1; wis = 2; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 0; hp = 30; mp = 10;
        break;
      case 222:
        this.name = "Standard Armour";
        str = 2; con = 4; intel = 2; wis = 3; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 40; mp = 20;
        break;
      case 223:
        this.name = "Cruciform Armour";
        str = 3; con = 5; intel = 3; wis = 4; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 50; mp = 30;
        break;
      case 224:
        this.name = "Black Dragon Armour";
        str = 4; con = 6; intel = 4; wis = 5; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 60; mp = 40;
        break;
      case 225:
        this.name = "Archangel's Blessing";
        str = 5; con = 7; intel = 5; wis = 6; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 70; mp = 50;
        break;
      
      //accessory
      case 231:
        this.name = "Low-Tier Gemstone";
        str = 0; con = 2; intel = 0; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 20; mp = 20;
        break;
      case 232:
        this.name = "Common Gemstone";
        str = 0; con = 3; intel = 0; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 30; mp = 30;
        break;
      case 233:
        this.name = "High-Tier Gemstone";
        str = 1; con = 4; intel = 1; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 2; hp = 40; mp = 40;
        break;
      case 234:
        this.name = "Excellent Gemstone";
        str = 2; con = 5; intel = 2; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 4; hp = 50; mp = 50;
        break;
      case 235:
        this.name = "Super Rare Gemstone";
        str = 3; con = 6; intel = 3; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 6; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Ranger equipment
      ******************************/ 
      //weapon
      case 311:
        this.name = "Old Bow";
        str = 2; con = 0; intel = 2; wis = 0; agi = 4; patk = 20; pdef = 0; matk = 20; mdef = 0; spd = 10; hp = 0; mp = 0;
        break;
      case 312:
        this.name = "Wooden Bow";
        str = 3; con = 0; intel = 3; wis = 0; agi = 5; patk = 30; pdef = 0; matk = 30; mdef = 0; spd = 20; hp = 0; mp = 0;
        break;
      case 313:
        this.name = "Long Bow";
        str = 4; con = 0; intel = 4; wis = 0; agi = 6; patk = 40; pdef = 0; matk = 40; mdef = 0; spd = 30; hp = 0; mp = 0;
        break;
      case 314:
        this.name = "Phathom Bow";
        str = 5; con = 0; intel = 5; wis = 0; agi = 7; patk = 50; pdef = 0; matk = 50; mdef = 0; spd = 40; hp = 0; mp = 0;
        break;
      case 315:
        this.name = "Bow of Wind";
        str = 6; con = 0; intel = 6; wis = 0; agi = 8; patk = 60; pdef = 0; matk = 60; mdef = 0; spd = 50; hp = 0; mp = 0;
        break;
      
      //armour
      case 321:
        this.name = "Old Cloak";
        str = 0; con = 2; intel = 0; wis = 0; agi = 1; patk = 0; pdef = 10; matk = 0; mdef = 20; spd = 10; hp = 30; mp = 0;
        break;
      case 322:
        this.name = "Magic Cloak";
        str = 0; con = 3; intel = 0; wis = 0; agi = 2; patk = 0; pdef = 20; matk = 0; mdef = 30; spd = 20; hp = 40; mp = 0;
        break;
      case 323:
        this.name = "Silver Cloak";
        str = 0; con = 4; intel = 0; wis = 0; agi = 3; patk = 0; pdef = 30; matk = 0; mdef = 40; spd = 30; hp = 50; mp = 0;
        break;
      case 324:
        this.name = "Devil's Cloak";
        str = 0; con = 5; intel = 0; wis = 0; agi = 4; patk = 0; pdef = 40; matk = 0; mdef = 50; spd = 40; hp = 60; mp = 0;
        break;
      case 325:
        this.name = "Elven Cloak";
        str = 0; con = 6; intel = 0; wis = 0; agi = 5; patk = 0; pdef = 50; matk = 0; mdef = 60; spd = 50; hp = 70; mp = 0;
        break;
      
      //accessory
      case 331:
        this.name = "Old Ring";
        str = 1; con = 1; intel = 1; wis = 0; agi = 2; patk = 5; pdef = 0; matk = 5; mdef = 0; spd = 2; hp = 20; mp = 20;
        break;
      case 332:
        this.name = "Speed Ring";
        str = 2; con = 2; intel = 2; wis = 0; agi = 3; patk = 6; pdef = 0; matk = 6; mdef = 0; spd = 3; hp = 30; mp = 30;
        break;
      case 333:
        this.name = "Mysterious Ring";
        str = 3; con = 3; intel = 3; wis = 0; agi = 4; patk = 7; pdef = 0; matk = 7; mdef = 0; spd = 4; hp = 40; mp = 40;
        break;
      case 334:
        this.name = "Purple Dragon Ring";
        str = 4; con = 4; intel = 4; wis = 0; agi = 5; patk = 8; pdef = 0; matk = 8; mdef = 0; spd = 5; hp = 50; mp = 50;
        break;
      case 335:
        this.name = "Wind's Ring";
        str = 5; con = 5; intel = 5; wis = 0; agi = 6; patk = 9; pdef = 0; matk = 9; mdef = 0; spd = 6; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Assassin equipment
      ******************************/ 
      //weapon
      case 411:
        this.name = "Old Dagger";
        str = 5; con = 0; intel = 0; wis = 0; agi = 5; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 10; hp = 0; mp = 0;
        break;
      case 412:
        this.name = "Common Dagger";
        str = 6; con = 0; intel = 0; wis = 0; agi = 6; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 20; hp = 0; mp = 0;
        break;
      case 413:
        this.name = "Military Dagger";
        str = 7; con = 0; intel = 0; wis = 0; agi = 7; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 30; hp = 0; mp = 0;
        break;
      case 414:
        this.name = "Paw Dagger";
        str = 8; con = 0; intel = 0; wis = 0; agi = 8; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 40; hp = 0; mp = 0;
        break;
      case 415:
        this.name = "Godlike Dagger";
        str = 9; con = 0; intel = 0; wis = 0; agi = 9; patk = 50; pdef = 0; matk = 0; mdef = 0; spd = 50; hp = 0; mp = 0;
        break;
      
      //armour
      case 421:
        this.name = "Mask";
        str = 0; con = 3; intel = 0; wis = 1; agi = 2; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 10; hp = 10; mp = 0;
        break;
      case 422:
        this.name = "Thief's Mask";
        str = 0; con = 4; intel = 0; wis = 2; agi = 3; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 20; hp = 20; mp = 0;
        break;
      case 423:
        this.name = "Red Scarf";
        str = 0; con = 5; intel = 0; wis = 3; agi = 4; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 30; hp = 30; mp = 0;
        break;
      case 424:
        this.name = "Mysterious Scarf";
        str = 0; con = 6; intel = 0; wis = 4; agi = 5; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 40; hp = 40; mp = 0;
        break;
      case 425:
        this.name = "Kakashi's Mask";
        str = 0; con = 7; intel = 0; wis = 5; agi = 6; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 50; hp = 50; mp = 0;
        break;
      
      //accessory
      case 431:
        this.name = "Traveller's Shoes";
        str = 10; con = 1; intel = 0; wis = 0; agi = 10; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 10; hp = 10; mp = 10;
        break;
      case 432:
        this.name = "Iron Secret Boots";
        str = 20; con = 2; intel = 0; wis = 0; agi = 20; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 20; hp = 20; mp = 20;
        break;
      case 433:
        this.name = "Boots Of Speed";
        str = 30; con = 3; intel = 0; wis = 0; agi = 30; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 30; hp = 30; mp = 30;
        break;
      case 434:
        this.name = "Secret Boots";
        str = 40; con = 4; intel = 0; wis = 0; agi = 40; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 40; hp = 40; mp = 40;
        break;
      case 435:
        this.name = "Flying Boots";
        str = 50; con = 5; intel = 0; wis = 0; agi = 50; patk = 50; pdef = 0; matk = 0; mdef = 0; spd = 50; hp = 50; mp = 50;
        break;
        
        
      /*****************************
      *  Mage equipment
      ******************************/ 
      //weapon
      case 511:
        this.name = "Magic Book";
        str = 0; con = 0; intel = 10; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 0; mp = 10;
        break;
      case 512:
        this.name = "Ancient Magic Book";
        str = 0; con = 0; intel = 20; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 0; mp = 20;
        break;
      case 513:
        this.name = "Magic Clover";
        str = 0; con = 0; intel = 30; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 0; mp = 30;
        break;
      case 514:
        this.name = "Lucky Clover";
        str = 0; con = 0; intel = 40; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 0; mp = 40;
        break;
      case 515:
        this.name = "Death Note";
        str = 0; con = 0; intel = 50; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 60; mdef = 0; spd = 0; hp = 0; mp = 50;
        break;
      
      //armour
      case 521:
        this.name = "Old Robe";
        str = 0; con = 3; intel = 4; wis = 2; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 0; hp = 20; mp = 20;
        break;
      case 522:
        this.name = "Traveller's Robe";
        str = 0; con = 4; intel = 5; wis = 3; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 523:
        this.name = "Smurf's Robe";
        str = 0; con = 5; intel = 6; wis = 4; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 524:
        this.name = "Mysterious Robe";
        str = 0; con = 6; intel = 7; wis = 5; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 525:
        this.name = "Robe Of Hellfire";
        str = 0; con = 7; intel = 8; wis = 6; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
      
      //accessory
      case 531:
        this.name = "Common Magic Ball";
        str = 0; con = 2; intel = 4; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 10; mdef = 0; spd = 0; hp = 20; mp = 20;
        break;
      case 532:
        this.name = "Green Magic Ball";
        str = 0; con = 3; intel = 5; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 30; mp = 30;
        break;
      case 533:
        this.name = "Blue Magic Ball";
        str = 0; con = 4; intel = 6; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 40; mp = 40;
        break;
      case 534:
        this.name = "Dark Magic Ball";
        str = 0; con = 5; intel = 7; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 50; mp = 50;
        break;
      case 535:
        this.name = "Infernal Magic Ball";
        str = 0; con = 6; intel = 8; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Priest equipment
      ******************************/ 
      //weapon
      case 611:
        this.name = "Old Wand";
        str = 0; con = 0; intel = 3; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 10; mdef = 0; spd = 0; hp = 0; mp = 20;
        break;
      case 612:
        this.name = "Wand Of Forest";
        str = 0; con = 0; intel = 4; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 0; mp = 30;
        break;
      case 613:
        this.name = "Crystal Wand";
        str = 0; con = 0; intel = 5; wis = 7; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 0; mp = 40;
        break;
      case 614:
        this.name = "Magical Wand";
        str = 0; con = 0; intel = 6; wis = 8; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 0; mp = 50;
        break;
      case 615:
        this.name = "Poseidon's Triden";
        str = 0; con = 0; intel = 7; wis = 9; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 0; mp = 60;
        break;
      
      //armour
      case 621:
        this.name = "Worn Robe";
        str = 0; con = 5; intel = 1; wis = 6; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 622:
        this.name = "Monk's Robe";
        str = 0; con = 6; intel = 2; wis = 7; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 623:
        this.name = "Servant's Robe";
        str = 0; con = 7; intel = 3; wis = 8; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 624:
        this.name = "Holy Robe";
        str = 0; con = 8; intel = 4; wis = 9; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
      case 625:
        this.name = "Angel's Descent";
        str = 0; con = 9; intel = 5; wis = 10; agi = 0; patk = 0; pdef = 60; matk = 0; mdef = 60; spd = 0; hp = 70; mp = 70;
        break;
      
      //accessory
      case 631:
        this.name = "Gold Necklace";
        str = 0; con = 2; intel = 1; wis = 3; agi = 1; patk = 0; pdef = 10; matk = 10; mdef = 10; spd = 0; hp = 20; mp = 20;
        break;
      case 632:
        this.name = "Crystal Necklace";
        str = 0; con = 3; intel = 2; wis = 4; agi = 2; patk = 0; pdef = 20; matk = 20; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 633:
        this.name = "Arcane Necklace";
        str = 0; con = 4; intel = 3; wis = 5; agi = 3; patk = 0; pdef = 30; matk = 30; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 634:
        this.name = "Guardian's Cross";
        str = 0; con = 5; intel = 4; wis = 6; agi = 4; patk = 0; pdef = 40; matk = 40; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 635:
        this.name = "Millennium Puzzle";
        str = 0; con = 6; intel = 5; wis = 7; agi = 5; patk = 0; pdef = 50; matk = 50; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
        
    }//close switch
    
    //level requirement for item
    if(id > 100){
      this.level = (id % 10) * 5;
      this.gold = (id % 10) * 50;
    }else{
      this.level = 1;
    }
  }
  
  /******************
  Setter
  ******************/
  public void set_img(String path){
    img = loadImage(path);
  }
  
  public void set_id(int x){
    this.id = x;
    
    if(this.id / 100 > 0){
      set_type("Equipment");
    }else{
      switch(this.id % 10){
        case 1:
        case 2:
        case 3:
          set_type("Consumable");
          break;
          
        default:
          set_type("Special");
          break;
      }
    }
  }
  
  protected void set_type(String s){
    this.type = s;
  }
  
  public void set_str(int x){
    this.str = x;
  }
  
  public void set_con(int x){
    this.con = x;
  }
  
  public void set_intel(int x){
    this.intel = x;
  }
  
  public void set_wis(int x){
    this.wis = x;
  }
  
  public void set_agi(int x){
    this.agi = x;
  }
  
  public void set_patk(int x){
    this.patk = x;
  }
  
  public void set_pdef(int x){
    this.pdef = x;
  }
  
  public void set_matk(int x){
    this.matk = x;
  }
  
  public void set_mdef(int x){
    this.mdef = x;
  }
  
  public void set_spd(int x){
    this.spd = x;
  }
  
  public void set_hp(int x){
    this.hp = x;
  }
  
  public void set_mp(int x){
    this.mp = x;
  }
  
  public void set_rec_hp(int x){
    this.rec_hp = x;
  }
  
  public void set_rec_mp(int x){
    this.rec_mp = x;
  }
  
  /**********************************
    Getters
  **********************************/
  
  public int get_id(){
    return this.id;
  }
  
  public String get_type(){
    return this.type;
  }
  
  public int get_str(){
    return this.str;
  }
  
  public int get_con(){
    return this.con;
  }
  
  public int get_intel(){
    return this.intel;
  }
  
  public int get_wis(){
    return this.wis;
  }
  
  public int get_agi(){
    return this.agi;
  }
  
  public int get_patk(){
    return this.patk;
  }
  
  public int get_pdef(){
    return this.pdef;
  }
  
  public int get_matk(){
    return this.matk;
  }
  
  public int get_mdef(){
    return this.mdef;
  }
  
  public int get_spd(){
    return this.spd;
  }
  
  public int get_hp(){
    return this.hp;
  }
  
  public int get_mp(){
    return this.mp;
  }
  
  public int get_rec_hp(){
    return this.rec_hp;
  }
  
  public int get_rec_mp(){
    return this.rec_mp;
  }
  
  public void desc(float display_x, float display_y, int dg){
    int count = 0, not_displayed = 0;
    String[] attr = {"Level: ", "Strength: ", "Constitution: ", "Intelligence: ", "Wisdom: ", "Agility: ", 
                    "Physical Attack: ", "Physical Defense: ", "Magical Attack: ", "Magical Defense: ", 
                    "Speed: ", "HP: ", "MP: ", "Recover HP: ", "Recover MP: ", "Gold: "};
                    
    int[] pt = {this.level, this.str, this.con, this.intel, this.wis, this.agi, 
                this.patk, this.pdef, this.matk, this.mdef, this.spd, this.hp, this.mp, 
                this.rec_hp, this.rec_mp, this.gold};
    
    for(int i = 0; i < pt.length - dg; i++){
      if(pt[i] != 0){
        count++;
      }
    }
    
    noStroke();
    fill(52,50,75);
    textAlign(CENTER, CENTER);
    textSize(20);
    rect(display_x, display_y, bag.square_width * 3, (count + 1) * 30);
    
    fill(0,100,100);
    stroke(0,100,100);
    textAlign(CENTER, CENTER);
    textSize(20);
    //println("ID: " + this.id);
    text(this.name, display_x + bag.square_width * 1.5f, display_y + 15);
    
    if(count > 0){
      for(int i = 0; i < pt.length - dg; i++){
        if(pt[i] != 0){
          text(attr[i] + pt[i], display_x + bag.square_width * 1.5f, display_y + 15 + (i+1 - not_displayed) * 30);
        }else{
          not_displayed++;
        }
      }
    }
    
  }// end function desc
  
  public void use(int target){
    int temp_item;
    
    
      if(this.id < 50){
        if(this.id == 39){
          if(!p[target].is_alive()){
            p[target].ress();
            p[target].rec_hp(this.rec_hp);
            p[target].rec_mp(this.rec_mp);
            bag.inv[bag_y][bag_x] = item_count - 1;
          }
        }else{
          if(p[target].get_cur_hp() < p[target].get_max_hp()){
            p[target].rec_hp(this.rec_hp);
            p[target].rec_mp(this.rec_mp);
            bag.inv[bag_y][bag_x] = item_count - 1;
          }
        }
        
        p[target].calc_stats();
      }else if(this.id > 100){
        if(p[target].job_code == (this.id / 100)){
          if(p[target].level >= item_list[bag.inv[bag_y][bag_x]].level){
            temp_item = p[target].equipment[((this.id % 100) / 10) - 1];
            
            update_player_bonus(target, temp_item, bag.inv[bag_y][bag_x]);
            
            p[target].equipment[((this.id % 100) / 10) - 1] = bag.inv[bag_y][bag_x];
            bag.inv[bag_y][bag_x] = temp_item;
          }else{
            println("You don't meet the level requirement for this item!");
          }
        }else{
          println("Wrong Job equipment!");
        }
      }
    
  }
  
  
  public void update_player_bonus(int target, int prev_eq_code, int new_eq_code){
    //decrease player stats added by previous equipment
    p[target].inc_str(-1 * item_list[prev_eq_code].get_str());
    p[target].inc_con(-1 * item_list[prev_eq_code].get_con());
    p[target].inc_int(-1 * item_list[prev_eq_code].get_intel());
    p[target].inc_wis(-1 * item_list[prev_eq_code].get_wis());
    p[target].inc_agi(-1 * item_list[prev_eq_code].get_agi());
    p[target].inc_patk(-1 * item_list[prev_eq_code].get_patk());
    p[target].inc_pdef(-1 * item_list[prev_eq_code].get_pdef());
    p[target].inc_matk(-1 * item_list[prev_eq_code].get_matk());
    p[target].inc_mdef(-1 * item_list[prev_eq_code].get_mdef());
    p[target].inc_spd(-1 * item_list[prev_eq_code].get_spd());
    p[target].inc_hp(-1 * item_list[prev_eq_code].get_hp());
    p[target].inc_mp(-1 * item_list[prev_eq_code].get_mp());
    //println("dec stats");
    //println("str:  " + item_list[prev_eq_code].get_str());
    //println("con:  " + item_list[prev_eq_code].get_con());
    //println("hp:  " + item_list[prev_eq_code].get_hp());
    
    //increase player stats by new equipment bonuses
    p[target].inc_str(item_list[new_eq_code].get_str());
    p[target].inc_con(item_list[new_eq_code].get_con());
    p[target].inc_int(item_list[new_eq_code].get_intel());
    p[target].inc_wis(item_list[new_eq_code].get_wis());
    p[target].inc_agi(item_list[new_eq_code].get_agi());
    p[target].inc_patk(item_list[new_eq_code].get_patk());
    p[target].inc_pdef(item_list[new_eq_code].get_pdef());
    p[target].inc_matk(item_list[new_eq_code].get_matk());
    p[target].inc_mdef(item_list[new_eq_code].get_mdef());
    p[target].inc_spd(item_list[new_eq_code].get_spd());
    p[target].inc_hp(item_list[new_eq_code].get_hp());
    p[target].inc_mp(item_list[new_eq_code].get_mp());
    //println("dec stats");
    //println("str:  " + item_list[new_eq_code].get_str());
    //println("con:  " + item_list[new_eq_code].get_con());
    //println("hp:  " + item_list[new_eq_code].get_hp());
    
    p[target].calc_stats();
  }
}//end Item class



public void load_items(){
  for(int i = 0; i < item_count; i++)
  {
     item_list[i] = new Item();
      
    /*****************************
    *  Knight equipment
    ******************************/
    if(i < 5){
      item_list[i].set_id(111 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 10){
      item_list[i].set_id(121 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 15){
      item_list[i].set_id(131 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Paladin equipment
    ******************************/
    }else if(i < 20){
      item_list[i].set_id(211 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 25){
      item_list[i].set_id(221 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 30){
      item_list[i].set_id(231 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Ranger equipment
    ******************************/
    }else if(i < 35){
      item_list[i].set_id(311 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 40){
      item_list[i].set_id(321 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 45){
      item_list[i].set_id(331 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Assassin equipment
    ******************************/
    }else if(i < 50){
      item_list[i].set_id(411 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 55){
      item_list[i].set_id(421 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_armour_" + ((i%5)+1) + ".jpg");

    }else if(i < 60){
      item_list[i].set_id(431 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Mage equipment
    ******************************/
    }else if(i < 65){
      item_list[i].set_id(511 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 70){
      item_list[i].set_id(521 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 75){
      item_list[i].set_id(531 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_accessory_" + ((i%5)+1) + ".jpg");
      
    /*****************************
    *  Priest equipment
    ******************************/ 
    }else if(i < 80){
      item_list[i].set_id(611 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 85){
      item_list[i].set_id(621 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 90){
      item_list[i].set_id(631 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_accessory_" + ((i%5)+1) + ".jpg");
      
    /*****************************
    *  HP consumable
    ******************************/ 
    }else if(i < 93){
      item_list[i].set_id(11 + (i%10));
      item_list[i].set_img("src/item/consumable/hp_" + ((i%10)+1) + ".jpg");
      
    /*****************************
    *  MP consumable
    ******************************/ 
    }else if(i < 96){
      item_list[i].set_id(18 + (i%10));
      item_list[i].set_img("src/item/consumable/mp_" + (((i%10)+18) % 10) + ".jpg");
      
    /*****************************
    *  max potion
    ******************************/ 
    }else if(i < 97){
      item_list[i].set_id(31);
      item_list[i].set_img("src/item/consumable/max_potion.jpg");
      
    /*****************************
    *  revive potion
    ******************************/ 
    }else if(i < 98){
      item_list[i].set_id(39);
      item_list[i].set_img("src/item/consumable/revive.jpg");
     
    /*****************************
    *  Keys
    ******************************/ 
    }else if(i < 101){
      item_list[i].set_id(i - 8);
      item_list[i].set_img("src/item/special/key_" + (i - 97) + ".jpg");
      
      
    }else{
      item_list[i].set_id(0);
      item_list[i].set_img("src/item/empty.jpg");
    }//end if
    
    item_list[i].init_stats();
  }//end for
}

public void item_desc(int bag_mode){
  for(int i = 0; i < bag.row; i++){
    for(int j = 0; j < bag.col; j++){
      switch(bag_mode){
        case 1:
          if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2) + bag.square_width
            && mouseY >= ((i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin) && mouseY <= ((i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin) + bag.square_height){
              
              if(bag.inv[i][j] != item_count - 1){
                item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY, 1);
              }
              
          }
          break;
          
        case 2:
          if(i > bag.row / 2 - ((bag.row + 1) % 2)){
            if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + width/2) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 + bag.square_width)
              && mouseY >= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin 
              && mouseY <= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin + bag.square_height){
                
                if(bag.inv[i][j] != item_count - 1){
                    item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY, 1);
                }
            }    
          }else{
              if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width + bag.square_width) 
                && mouseY >= ( ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin ) && mouseY <= ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin + bag.square_height){
                  
                   if(bag.inv[i][j] != item_count - 1){
                       item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY, 1);
                   }
              }    
          }
          break;
      }
            
    }    //for loop(j)
  }    //for loop (i)
  
  //shop
  if(bag_mode == 3){
    
    item_desc(1);
    
    shop.dis_y = bag.vertical_margin + bag.vs;
    for(int i = 0; i < shop.sale_count; i++){
      if(i % 5 == 0){
        shop.dis_y += bag.vs + bag.square_height;
      }
      
      if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
        && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
        && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
          
          if(shop.sell[i] != item_list[item_count - 1]){
            shop.sell[i].desc(mouseX - bag.square_width * 3, mouseY, 0);
          }
          
      }
    }//end shop for
            
    shop.dis_y = bag.UI_height / 2 - bag.vs;
    for(int i = 0; i < shop.sale_count; i++){
      if(i % 5 == 0){
        shop.dis_y += bag.vs + bag.square_height;
      }
      
      if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
        && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
        && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
          
          if(shop.cart[i] != item_list[item_count - 1]){
            shop.cart[i].desc(mouseX - bag.square_width * 3, mouseY, 0);
          }
          
      }
              
    }//end cart for
    
    
  }
}
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
              
              //door locked
              floor_1[floor_room_id-1].npc[10][27] = true;
              floor_1[floor_room_id-1].npc[11][27] = true;
              floor_1[floor_room_id-1].npc[12][27] = true;
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
              //locked door
              floor_2[floor_room_id-1].npc[5][19] = true;
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
              
              //equipment safe
              floor_2[floor_room_id-1].npc[13][10] = true; 
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
                
                //boss
                floor_3[floor_room_id-1].npc[7][15] = true;
                floor_3[floor_room_id-1].npc[7][16] = true;
                floor_3[floor_room_id-1].npc[8][15] = true;
                floor_3[floor_room_id-1].npc[8][16] = true;
                
                //equipment safe
                floor_3[floor_room_id-1].npc[6][22] = true; 
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
                // door locked
                floor_3[floor_room_id-1].npc[4][20] = true;
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
              
              //boss
              floor_4[floor_room_id-1].npc[9][20] = true;
              
              // to 5th floor, go up 
              floor_4[floor_room_id-1].exit[5][20] = 9;
              // door locked
              floor_4[floor_room_id-1].npc[5][20] = true;
              break;
          
          case 8:
              floor_4[floor_room_id-1].exit[12][28] = 7;
              floor_4[floor_room_id-1].exit[13][28] = 7;
              
              //equipment safe
              floor_4[floor_room_id-1].npc[13][10] = true; 
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
              
              //equipment safe
              floor_5[floor_room_id-1].npc[12][10] = true; 
              break;
            
            case 5:
              floor_5[floor_room_id-1].exit[18][20] = 1;
              
              floor_5[floor_room_id-1].exit[2][19] = 6;
              floor_5[floor_room_id-1].exit[2][20] = 6;
              break;
            
            case 6:
              floor_5[floor_room_id-1].exit[17][20] = 5;
              floor_5[floor_room_id-1].exit[17][21] = 5;
              
              //to princess room
              floor_5[floor_room_id-1].exit[10][13] = 7;
              floor_5[floor_room_id-1].exit[11][13] = 7;
              
              //door locked
              floor_5[floor_room_id-1].npc[10][13] = true;
              floor_5[floor_room_id-1].npc[11][13] = true;
              
              //boss
              floor_5[floor_room_id-1].npc[6][20] = true;
              floor_5[floor_room_id-1].npc[6][21] = true;
              floor_5[floor_room_id-1].npc[7][20] = true;
              floor_5[floor_room_id-1].npc[7][21] = true;
              break;
            
            case 7:
              floor_5[floor_room_id-1].exit[11][23] = 6;
              floor_5[floor_room_id-1].exit[12][23] = 6;
              floor_5[floor_room_id-1].exit[13][23] = 6;
              
              floor_5[floor_room_id-1].npc[10][19] = true;
              break;
            
        }
        break;
    }
  }
  
}

public void cur_room_npc(){
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
public void wall_set(){
  init_1F();
  init_2F();
  init_3F();
  init_4F();
  init_5F();
}

public void init_1F(){
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
              
              //boss
              floor_1[i].npc[10][11] = true;
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
              
              //NPC set up
              floor_1[i].npc[8][13] = true;
              floor_1[i].npc[8][18] = true;
              floor_1[i].npc[8][23] = true;
              floor_1[i].npc[13][13] = true;
              floor_1[i].npc[13][18] = true;
              floor_1[i].npc[13][23] = true;
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

public void init_2F(){
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
                
                //boss
                floor_2[i].npc[6][20] = true;
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
              
              for(int j = 7; j <= 11; j++){
                for(int k = 17; k <= 19; k++){
                  floor_2[i].npc[j][k] = true;
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

public void init_3F(){
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
              
              for(int j = 7; j <= 11; j++){
                for(int k = 17; k <= 19; k++){
                  floor_3[i].npc[j][k] = true;
                }
              }
          break;  
    }
  }
}

public void init_4F(){
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
          
          for(int i = 7; i <= 11; i++){
            for(int j = 17; j <= 19; j++){
              floor_4[f].npc[i][j] = true;
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

public void init_5F(){
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
        
        //shop npc
        floor_5[f].npc[11][26] = true;
        floor_5[f].npc[12][26] = true;
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
boolean in_shop = false;

class Merchant{
  int item_code, rand;
  int sale_count = 10;
  Item[] sell = new Item[sale_count];
  Item[] cart = new Item[sale_count];
  int buy = 0;
  int gold_req = 0;
  float dis_y;
  
  public Merchant(){
    
  }
  
  public void set_up(int floor){
    buy = 0;
    
    for(int i = 0; i < sell.length; i++){
      cart[i] = item_list[item_count - 1];
      rand = r.nextInt((item_count - 4) * 3) % (item_count - 4);
      
      if(item_list[rand].level <= (floor - 1) * 5){
        sell[i] = item_list[rand];
      }else{
        i--;
      }
      
    }
    
    shop_set = true;
  }
  
  //shop display
  public void display_shop(){
    this.buy = 0;
    this.gold_req = 0;
    
    for(int i = 0; i < this.cart.length; i++){
      if(this.cart[i] != item_list[item_count - 1]){
        this.buy++;
      }
    }
    
    if(!shop_set){
      set_up(floor);
      for(int i = 0; i < sale_count; i++){
        cart[i] = item_list[item_count - 1];
      }
    }
    
    
    
    noStroke();
    fill(40, 100, 100);
    rect(bag.horizontal_margin, bag.vertical_margin, bag.UI_width, bag.UI_height);
    
    stroke(0);
    fill(66,100,100);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("SHOP", bag.horizontal_margin + bag.UI_width/2, bag.vertical_margin + bag.square_height);
    
    dis_y = bag.vertical_margin + bag.vs;
    for(int i = 0; i < sale_count; i++){
      if(i % 5 == 0){
        dis_y += bag.vs + bag.square_height;
      }
      //println("x : " + (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + " y: " + dis_y);
      image(sell[i].img, (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width), dis_y, bag.square_width, bag.square_height);
    }
    
    stroke(0);
    fill(66,100,100);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("CART", bag.horizontal_margin + bag.UI_width/2, bag.UI_height/2);
    
    dis_y = bag.UI_height / 2 - bag.vs;
    for(int i = 0; i < sale_count; i++){
      if(i % 5 == 0){
        dis_y += bag.vs + bag.square_height;
      }
      //println("x : " + (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + " y: " + dis_y);
      image(cart[i].img, (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width), dis_y, bag.square_width, bag.square_height);
      
      this.gold_req += cart[i].gold;
    }
    
    noStroke();
    //left box for displaying total gold needed to buy items
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.hs, bag.UI_height - bag.vertical_margin - bag.square_height, bag.square_width * 3, bag.square_height);
    fill(0,100,0);
    textAlign(LEFT, CENTER);
    text("Total: " + gold_req, bag.horizontal_margin + bag.square_width, bag.UI_height - bag.vertical_margin - bag.square_height + bag.square_height/2);
    
    //right box for displaying player's gold
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.hs + bag.square_width * 4, bag.UI_height - bag.vertical_margin - bag.square_height, bag.square_width * 3, bag.square_height);
    fill(0,100,0);
    textAlign(LEFT, CENTER);
    text("Gold: " + p[0].get_gold(), bag.horizontal_margin + bag.square_width * 5, bag.UI_height - bag.vertical_margin - bag.square_height + bag.square_height/2);
    
    //confirmation box
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.square_width, height - bag.vertical_margin - bag.square_height, bag.square_width * 2, bag.square_height / 2);
    fill(0,100,0);
    textAlign(CENTER, CENTER);
    text("Buy", bag.horizontal_margin + bag.square_width * 2, height - bag.vertical_margin - bag.square_height + bag.square_height/4);
    
    //cancel and quit box
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.UI_width/2 + bag.square_width, height - bag.vertical_margin - bag.square_height, bag.square_width * 2, bag.square_height / 2);
    fill(0,100,0);
    textAlign(CENTER, CENTER);
    text("Cancel", bag.horizontal_margin + bag.UI_width/2 + bag.square_width * 2, height - bag.vertical_margin - bag.square_height + bag.square_height/4);
  }
}

  /*******************************************
  Monster status setting
  ********************************************/ 

String f1_normal[] = {"Slime","Bat","Skeleton Soldier"};
String f1_boss = "Skeleton Warden";

String f2_normal[] = {"Poison Rat","Stoveg Host","Briquettes"};
String f2_elite = "Skeleton Guard";
String f2_boss = "Demon Librarian";

String f3_normal[] = {"Little Demon","Poison Spider","Pumpkin Demon"};
String f3_elite = "Devil Butler";
String f3_boss = "Bloodthirsty Butcher";

String f4_normal[] = {"Greenface","Wild crocodile","Puppet"};
String f4_elite = "Vampire warrior";
String f4_boss = "War adviser";

String f5_normal[] = {"Green devil snake","Unicorn Beetle","Ghost warrior","Bloodthirsty bird"};
String f5_elite = "Dracula's avatar";
String f5_boss = "Dracula";


class Monster extends Units{
  protected int m_type;
  protected String monster_type = "Normal";
  protected float mod = 1.0f;
  PImage battle_img;
  
  public Monster(){
    type = 0;
    
    this.skillset = new int[4];
  }
  
  public Monster(int t){
    this.m_type = t;
    
    type = 0;
  }
  
	public Monster(int t, int lv){
    this.m_type = t;
		this.level = lv;
    type = 0;
  
    init_stats();
	}

  
  public void init_stats(){
    
    
    this.alive = true;
    
    int type = 0;
    
    type = r.nextInt(3)+1;
    
    switch(m_type){
      case 1:
        this.monster_type = "Normal";
        this.mod = 1.0f;
        switch(floor){
          
          case 1:
            this.img = loadImage("src/monster/normal/floor_1/n" + type + ".png");
            this.battle_img = loadImage("src/monster/normal/floor_1/n" + type + "_battle.png");
            
            this.name = f1_normal[type-1];
            break;
          
          case 2:
            this.img = loadImage("src/monster/normal/floor_2/n" + type + ".png");
            this.battle_img = loadImage("src/monster/normal/floor_2/n" + type + "_battle.png");
            
            this.name = f2_normal[type-1];
            
            break;
          
          case 3:
            this.img = loadImage("src/monster/normal/floor_3/n" + type + ".png");
            this.battle_img = loadImage("src/monster/normal/floor_3/n" + type + "_battle.png");
            
            this.name = f3_normal[type-1];
            
            break;
          case 4:
            this.img = loadImage("src/monster/normal/floor_4/n" + type + ".png");
            this.battle_img = loadImage("src/monster/normal/floor_4/n" + type + "_battle.png");
            
            this.name = f4_normal[type-1];
            
            break;
          case 5:
            
            type = r.nextInt(4)+1;;
            
            this.img = loadImage("src/monster/normal/floor_5/n" + type + ".png");
            this.battle_img = loadImage("src/monster/normal/floor_5/n" + type + "_battle.png");
            
            this.name = f5_normal[type-1];
            
            break;
        }
        this.skill_count = 1;
        this.skillset[0] = r.nextInt(6);
        this.skills = new Normal_Skill();
        break;
      
      case 2:
        this.monster_type = "Elite";
        this.mod = 1.5f;
        switch(floor){
          case 1:
            this.img = loadImage("src/monster/elite/floor_1/e1.png");
            this.battle_img = loadImage("src/monster/elite/floor_1/e1_battle.png");
            break;
          case 2:
            
            this.img = loadImage("src/monster/elite/floor_2/e1.png");
            this.battle_img = loadImage("src/monster/elite/floor_2/e1_battle.png");
            
            this.name = f2_elite;
            break;
          case 3:
            this.img = loadImage("src/monster/elite/floor_3/e1.png");
            this.battle_img = loadImage("src/monster/elite/floor_3/e1_battle.png");
            
            this.name = f3_elite;
            break;
          case 4:
            this.img = loadImage("src/monster/elite/floor_4/e1.png");
            this.battle_img = loadImage("src/monster/elite/floor_4/e1_battle.png");
            
            this.name = f4_elite;
            break;
          case 5:
            this.img = loadImage("src/monster/elite/floor_5/e1.png");
            this.battle_img = loadImage("src/monster/elite/floor_5/e1_battle.png");
            
            this.name = f5_elite;
            break;
        }
        this.skill_count = 2;
        
        for(int i = 0; i < skill_count; i++){
          this.skillset[i] = r.nextInt(7);
        }
        
        this.skills = new Elite_Skill();
        break;
        
      
      case 3:
        this.monster_type = "Boss";
        this.mod = 2.0f;
        switch(floor){
          case 1:
            this.img = loadImage("src/monster/boss/floor_1/b1.png");
            this.battle_img = loadImage("src/monster/boss/floor_1/b1_battle.png");
            
            this.name = f1_boss;
            break;
          case 2:
            this.img = loadImage("src/monster/boss/floor_2/b1.png");
            this.battle_img = loadImage("src/monster/boss/floor_2/b1_battle.png");
            
            this.name = f2_boss;
            break;
          case 3:
            this.img = loadImage("src/monster/boss/floor_3/b1.png");
            this.battle_img = loadImage("src/monster/boss/floor_3/b1_battle.png");
            
            this.name = f3_boss;
            break;
          case 4:
            this.img = loadImage("src/monster/boss/floor_4/b1.png");
            this.battle_img = loadImage("src/monster/boss/floor_4/b1_battle.png");
            
            this.name = f4_boss;
            break;
          case 5:
            this.img = loadImage("src/monster/boss/floor_5/b1.png");
            this.battle_img = loadImage("src/monster/boss/floor_5/b1_battle.png");
            
            this.name = f5_boss;
            break;
        }
        
        this.skill_count = 4;
        
        switch(floor){
          case 2:
            this.skills = new Boss_Skill_floor_2();
            break;
            
          case 3:
            this.skills = new Boss_Skill_floor_3();
            break;
            
          case 4:
            this.skills = new Boss_Skill_floor_4();
            break;
            
          case 5:
            this.skills = new Boss_Skill_floor_5();
            break;
            
        }
        
        
        break;
      
    }
    
    this.patk = (level * 5) * mod;
    this.pdef = (level * 3) * mod;
    this.matk = (level * 5) * mod;
    this.mdef = (level * 3) * mod;
    this.spd = (level * 2) * mod;
    this.max_hp = (level * 10) * mod;
    this.max_mp = (level * 10) * mod;
    this.cur_hp = (level * 10) * mod;
    this.cur_mp = (level * 10) * mod;
    this.hp_dec = 0;
    this.mp_dec = 0;    
    
  }
	
	public void calc_stats(){
    this.calc_buff();
    this.alive = true;
		this.patk = patk + bonus_patk;
		this.pdef = pdef + bonus_pdef;
		this.matk = matk + bonus_matk;
		this.mdef = mdef + bonus_mdef;
		this.spd = spd + bonus_spd;
		this.max_hp = max_hp + bonus_hp;
		this.max_mp = max_mp + bonus_mp;
    this.cur_hp = max_hp - hp_dec + bonus_hp;
    if(this.cur_hp <= 0){
      dead();
      hp_dec = max_hp;
      cur_hp = 0;
    }
    if(this.cur_hp > max_hp){
      cur_hp = max_hp;
      hp_dec = 0;
    }
    
    this.cur_mp = max_mp - mp_dec + bonus_mp;
    if(this.cur_mp <= 0){
      mp_dec = max_mp;
      cur_mp = 0;
    }
    if(this.cur_mp > max_mp){
      cur_mp = max_mp;
      mp_dec = 0;
    }
	}

  public void setMType(int x){
    this.m_type = x;
  }
  
  public void setMonsterType(String s){
    this.monster_type = s;
  }
  
  public int getMType(){
    return this.m_type;
  }
  
  public String getMonsterType(){
    return this.monster_type;
  }
  
  public float get_mod(){
    return this.mod;
  }
	
  public float getExp(){
    
    this.exp = (this.level * 2) * this.mod;
    
    //println("exp monster: "+this.exp);
    
    return this.exp;
  }
  
  public int get_gold(){
    
    this.gold = (this.level * 20) + r.nextInt(50);
    
    return this.gold;
  }

	/***********************
	*test print
	***********************/
	public void display_stats(){
		System.out.println("Monster status: ");
		System.out.println("LEVEL: " + this.level);
		System.out.println("HP: " + this.cur_hp);
		System.out.println("MP: " + this.cur_mp);
		System.out.println("MAXHP: " + this.max_hp);
		System.out.println("MAXMP: " + this.max_mp);
		System.out.println("PATK: " + this.patk);
		System.out.println("PDEF: " + this.pdef);
		System.out.println("MATK: " + this.matk);
		System.out.println("MDEF: " + this.mdef);
		System.out.println("SPD: " + this.spd);
	}
}
class Monster_AI{
  protected int target, mode;
  
  public int get_target(){
    return this.target;
  }
  
  public void attack_mode(){
  }
}

class Normal extends Monster_AI{
  public Normal(){
    mode = 1;
  }
  
  @Override
  public void attack_mode(){
    //println("Monster: " + battle_list[cur].id);
    //println("taunt round: " + battle_list[cur].buff_round[1]);
    if(battle_list[cur].buff_round[1] > 0){
      mode = 9;
      //println("taunted");
    }else{
      //println("attack! ");
      mode = r.nextInt(100) % 2;
      //mode = 0;
    }
    
    switch(mode){
      case 0:
        do{
          this.target = (r.nextInt(100) % c_pt);
        }while(!p[this.target].is_alive());
        
        //println("target: " + target);
        pid = target;
        attack(battle_list[cur].get_id(), target, 1);
      break;
      
      case 1:
        int use_skill = r.nextInt(battle_list[cur].skill_count);
        if(battle_list[cur].cur_mp > battle_list[cur].skills.skill[battle_list[cur].skillset[use_skill]].mp_dec){
          do{
            this.target = (r.nextInt(100) % c_pt);
            //println("target is alive: " + p[this.target].is_alive());
          }while(!p[this.target].is_alive());
          
          println("monster " + battle_list[cur].id + " used " + battle_list[cur].skills.skill[battle_list[cur].skillset[use_skill]].monster_skill_name[r.nextInt(10) % 2]);
          skill(battle_list[cur].id, this.target, 1, battle_list[cur].skillset[use_skill]);
        }else{
          attack_mode();
        }
        break;
      
      //when taunted
      case 9:
        //println("taunted attack " + p[(int)battle_list[cur].buff_list[1]].name);
        attack(battle_list[cur].get_id(), (int)battle_list[cur].buff_list[1], 1);
        break;
    }
  }
}

/**************************************
*  elite monster AI
**************************************/
class Elite extends Monster_AI{
  public Elite(){
    mode = 1;
  }
  
  @Override
  public void attack_mode(){
    float[] hp_percent = new float[c_pt];
    int min = 0, max = 0;
    
    /*****************************
    *  check for low hp target
    *****************************/
    for(int i = 0; i < c_pt; i++){
      if(p[i].is_alive()){
        hp_percent[i] = p[i].get_cur_hp() / p[i].get_max_hp();
      }else{
        hp_percent[i] = 0;
      }
    }
    
    for(int i = 0; i < c_pt; i++){
      if(hp_percent[i] > 0){
        if(hp_percent[min] > 0){
          
          if(hp_percent[min] > hp_percent[i]){
            min = i;
          }
          
        }else{
          min = i;
        }
        
        if(hp_percent[max] < hp_percent[i]){
          max = i;
        }
      }
    }
    
    //if person with hp lower than 30% 
    //attack that target with highest damage possible
    //else attack or use skill on random target
    if(battle_list[cur].buff_round[1] > 0){
      mode = 9;
    }else if(hp_percent[min] < 30){
      mode = 2;
    }else{
      //mode = r.nextInt(100) % 2;
      mode = 0;
    }
    
    switch(mode){
      case 0:
        do{
          this.target = r.nextInt(100) % c_pt;
        }while(!p[this.target].is_alive());
        
        //println("target: " + target);
        pid = target;
        attack(mid, target, 1);
      break;
      
      case 1:
        int use_skill = r.nextInt(battle_list[cur].skill_count);
        
        if(battle_list[cur].cur_mp > battle_list[cur].skills.skill[battle_list[cur].skillset[use_skill]].mp_dec){
          do{
            this.target = r.nextInt(100) % c_pt;
          }while(!p[this.target].is_alive());
          
          skill(battle_list[cur].get_id(), this.target, 1, battle_list[cur].skillset[use_skill]);
        }else{
          attack_mode();
        }
        break;
        
      case 2:
        target = min;
        max = 0;
        
        for(int i = 0; i < battle_list[cur].skill_count; i++){
          if(battle_list[cur].get_cur_mp() > battle_list[cur].skills.skill[battle_list[cur].skillset[i]].mp_dec){
            if(battle_list[cur].skills.skill[battle_list[cur].skillset[i]].mod > battle_list[cur].skills.skill[max].mod){
              max = battle_list[cur].skillset[i];
            }
          }
        }
        
        if(battle_list[cur].cur_mp > battle_list[cur].skills.skill[max].mp_dec){
          skill(battle_list[cur].id, this.target, 1, max);
        }else{
          attack(battle_list[cur].id, target, 1);
        }
        break;
      
      //when taunted
      case 9:
        println("taunted attack " + p[(int)battle_list[cur].buff_list[1]].name);
        attack(battle_list[cur].get_id(), (int)battle_list[cur].buff_list[1], 1);
        break;
    }
  }
}

class Boss extends Monster_AI{
  int aoe = 0;
  @Override
  public void attack_mode(){
    switch(floor){
      
      case 1:
        attack(0,0,1);
        break;
        
      case 2:
        do{
          this.target = r.nextInt(100) % c_pt;
        }while(!p[this.target].is_alive());
        
        aoe = r.nextInt(100) % 10;
        
        //on first round ignore taunt
        if(round == 1){
          if(aoe > 7){
            skill(battle_list[cur].id, this.target, 1, 3);
          }else if(aoe > 6){
            skill(battle_list[cur].id, this.target, 1, 1);
          }else if(aoe > 1){
            skill(battle_list[cur].id, this.target, 1, 0);
          }else{
            attack(battle_list[cur].id, this.target, 1);
          }
          
        //if taunted
        }else if(battle_list[cur].buff_round[1] > 0){
          attack(battle_list[cur].id, (int)battle_list[cur].buff_list[1], 1);
          
        //if mp < 40% recover
        }else if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() < 0.4f){
          skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
          
        //if hp > 90% 
        }else if(battle_list[cur].get_cur_hp() / battle_list[cur].get_max_hp() > 0.9f){
          attack(battle_list[cur].id, this.target, 1);
          
        //if hp > 60% % <= 90%
        }else if(battle_list[cur].get_cur_hp() / battle_list[cur].get_max_hp() > 0.6f){
          if(aoe == 0){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.4f){
              skill(battle_list[cur].id, this.target, 1, 3);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
            
          }else if(aoe == 1){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.4f){
              skill(battle_list[cur].id, this.target, 1, 1);
            }else{
              attack(battle_list[cur].id, this.target, 1);
            }
            
          }else if(aoe == 2){
            attack(battle_list[cur].id, this.target, 1);
            
          }else{
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.3f){
              skill(battle_list[cur].id, this.target, 1, 0);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
          }
          
        //if hp >= 20% % <= 60%
        }else if(battle_list[cur].get_cur_hp() / battle_list[cur].get_max_hp() >= 0.2f){
          if(aoe == 0){
            attack(battle_list[cur].id, this.target, 1);
            
          }else if(aoe < 3){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.4f){
              skill(battle_list[cur].id, this.target, 1, 1);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
            
          }else if(aoe < 5){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.4f){
              skill(battle_list[cur].id, this.target, 1, 3);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
            
          }else{
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.3f){
              skill(battle_list[cur].id, this.target, 1, 0);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
          }
          
        //last stage boss has 80% chance to use recover skill
        }else{
          if(aoe < 3){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.4f){
              skill(battle_list[cur].id, this.target, 1, 1);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
            
          }else if(aoe < 5){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.4f){
              skill(battle_list[cur].id, this.target, 1, 3);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
            
          }else if(aoe < 9){
            if(battle_list[cur].get_cur_mp() / battle_list[cur].get_max_mp() > 0.3f){
              skill(battle_list[cur].id, this.target, 1, 0);
            }else{
              skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
            }
          }else{
            skill(battle_list[cur].id, battle_list[cur].id, 1, 2);
          }
        }
        break;
        
      case 3:
        
      case 4:
        
      case 5:
      
        float[] hp_percent = new float[c_pt];
        int min = 0, max = 0;
        
        /*****************************
        *  check for low hp target
        *****************************/
        for(int i = 0; i < c_pt; i++){
          if(p[i].is_alive()){
            hp_percent[i] = p[i].get_cur_hp() / p[i].get_max_hp();
          }else{
            hp_percent[i] = 0;
          }
        }
        
        for(int i = 0; i < c_pt; i++){
          if(hp_percent[i] > 0){
            if(hp_percent[min] > 0){
              
              if(hp_percent[min] > hp_percent[i]){
                min = i;
              }
              
            }else{
              min = i;
            }
            
            if(hp_percent[max] < hp_percent[i]){
              max = i;
            }
          }
        }
        
        //if person with hp lower than 30% 
        //attack that target with highest damage possible
        //else attack or use skill on random target
        if(battle_list[cur].buff_round[1] > 0){
          mode = 9;
        }else if(hp_percent[min] < 30){
          mode = 2;
        }else{
          //mode = r.nextInt(100) % 2;
          mode = 0;
        }
        
        switch(mode){
          case 0:
            do{
              this.target = r.nextInt(100) % c_pt;
            }while(!p[this.target].is_alive());
            
            //println("target: " + target);
            pid = target;
            attack(mid, target, 1);
          break;
          
          case 1:
            int use_skill = r.nextInt(battle_list[cur].skill_count);
            
            if(battle_list[cur].cur_mp > battle_list[cur].skills.skill[battle_list[cur].skillset[use_skill]].mp_dec){
              do{
                this.target = r.nextInt(100) % c_pt;
              }while(!p[this.target].is_alive());
              
              skill(battle_list[cur].get_id(), this.target, 1, battle_list[cur].skillset[use_skill]);
            }else{
              attack_mode();
            }
            break;
            
          case 2:
            target = min;
            max = 0;
            
            for(int i = 0; i < battle_list[cur].skill_count; i++){
              if(battle_list[cur].get_cur_mp() > battle_list[cur].skills.skill[battle_list[cur].skillset[i]].mp_dec){
                if(battle_list[cur].skills.skill[battle_list[cur].skillset[i]].mod > battle_list[cur].skills.skill[max].mod){
                  max = battle_list[cur].skillset[i];
                }
              }
            }
            
            if(battle_list[cur].cur_mp > battle_list[cur].skills.skill[max].mp_dec){
              skill(battle_list[cur].id, this.target, 1, max);
            }else{
              attack(battle_list[cur].id, target, 1);
            }
            break;
          
          //when taunted
          case 9:
            //println("taunted attack " + p[(int)battle_list[cur].buff_list[1]].name);
            attack(battle_list[cur].get_id(), (int)battle_list[cur].buff_list[1], 1);
            break;
        }
      
        break;
        
    }
  }

}

  /***********************
  set player data
  ***********************/


class Player extends Units{
	protected float str = 1, con = 1, intel = 1, wis = 1, agi = 1;
  //public float str_mod = 1, con_mod = 1, intel_mod = 1, wis_mod = 1, agi_mod = 1;
  protected float flat_str = 1, flat_con = 1, flat_intel = 1, flat_wis = 1, flat_agi = 1;
  protected int job_code;
  public int dir = 2, AP = 3;
  
  public boolean level_up = false;
	Job job;
  int[] equipment = {item_count - 1, item_count - 1, item_count - 1};
  
  /**************************************
  *  CW
  **************************************/
  int Avatarsq_num = 4;
  int Bigsq_num = 3 ;
  
  int Wpsq_num = 3;
  
  int Strip_num = 5 ;
  
  int All_stripnum = 11;
  int UI_width = 500;
  int UI_height = 800;
  int UI_dis = 100;
  int vertical_margin = (height - UI_height)/2;
  int horizontal_margin = (width - 2*UI_width - UI_dis)/2;
  
  float sq_distance = UI_width / (Avatarsq_num*2 + 1);
  
  float Avatarsq_sl = sq_distance;
  
  float strip_distance = (UI_height -  Avatarsq_sl) / (All_stripnum*2 + 1);
  
  float Big_sl = 0.3f*UI_height;
  
  float Wp_distance = Big_sl / (Wpsq_num * 3 +1);
  
  float Wpsq_sl = 2*Wp_distance;
  
  float Strip_height = strip_distance;
  
  float addsq_sl = Strip_height;
  
  float Strip_width = (UI_width - 4*sq_distance - addsq_sl) / 2;
  
  float v_a = 0.05f*UI_height;
  /**************************************
  *  CW end
  **************************************/	

	public Player(){
	}

	public Player(int x){
    this.level = 1;
    this.job_code = x;
    job = new Job(x);
    this.battle_img = loadImage("src/player/battle/" + this.job.name + ".png");
    this.icon = loadImage("src/player/icon/" + this.job_code + ".png");
    this.avatar = loadImage("src/player/avatar/" + this.job_code + ".png");
    type = 1;
    init_stats();
    calc_stats();
    init_skillset();
	}

	public Player(int x, int lv, float st, float co, float in, float wi, float ag){
    type = 1;
    this.job_code = x;
    job = new Job(x);
		this.level = lv;
		this.flat_str = st;
		this.flat_con = co;
		this.flat_intel = in;
		this.flat_wis = wi;
		this.flat_agi = ag;
	}

  public void init_skillset(){
    switch(this.job_code){
      case 1:
        skills = new Knight_skill_list();
        break;
        
      case 2:
        skills = new Paladin_skill_list();
        break;
        
      case 3:
        skills = new Ranger_skill_list();
        break;
        
      case 4:
        skills = new Assassin_skill_list();
        break;
        
      case 5:
        skills = new Mage_skill_list();
        break;
        
      case 6:
        skills = new Priest_skill_list();
        break;     
    }
  }

  public void init_stats(){
    this.alive = true;
    this.flat_str = job.stats[0];
    this.flat_con = job.stats[1];
    this.flat_intel = job.stats[2];
    this.flat_wis = job.stats[3];
    this.flat_agi = job.stats[4];
  }
	
  public void change_map_img(){
    if(move_count == 0){
      this.img = loadImage("src/player/player_" + this.dir + ".png");
    }else{
      this.img = loadImage("src/player/player_" + this.dir + "_" + (move_count % 2) + ".png");
    }
  }

	//stats calculations
	public void calc_stats(){
    calc_buff();
    
		this.str = (flat_str + bonus_str);
		this.con = (flat_con + bonus_con);
		this.intel = (flat_intel + bonus_intel);
		this.wis = (flat_wis + bonus_wis);
		this.agi = (flat_agi + bonus_agi);

		this.flat_patk = str * job.amplifier[0] + level * (2 + job.amplifier[0]);
		this.flat_pdef = con * job.amplifier[1]  + level * (5 + job.amplifier[1]);
		this.flat_matk = intel * job.amplifier[2]  + level * (2 + job.amplifier[2]);
		this.flat_mdef = wis * job.amplifier[3] + level * (3.5f + job.amplifier[3]);
		this.flat_spd = agi * job.amplifier[4] + level * (1 + job.amplifier[4]);
		this.flat_max_hp = flat_con * (3 + job.amplifier[5]) * 2  + level * (8 + job.amplifier[5]);
		this.flat_max_mp = flat_wis * (2 + job.amplifier[6])  + level * (3 + job.amplifier[6]);
    this.bonus_hp = bonus_con * (3 + job.amplifier[5]) * 2 ;
    this.bonus_mp = bonus_wis * (2 + job.amplifier[6]);

    this.patk = (flat_patk + bonus_patk) * this.patk_mod;
    this.pdef = (flat_pdef + bonus_pdef) * this.pdef_mod;
    this.matk = (flat_matk + bonus_matk) * this.matk_mod;
    this.mdef = (flat_mdef + bonus_mdef) * this.mdef_mod;
    this.spd = (flat_spd + bonus_spd) * this.spd_mod;
    this.max_hp = (flat_max_hp + bonus_hp) * this.hp_mod;
    this.max_mp = (flat_max_mp + bonus_mp) * this.mp_mod;
    
		this.cur_hp = max_hp - hp_dec;
    
    if(this.hp_dec >= this.max_hp){
      println("die!");
      this.cur_hp = 0;
      this.hp_dec = this.max_hp;
      this.dead();
    }
    //println("max_hp: " + this.max_hp + " hp dec: " + this.hp_dec + " cur hp: " + this.cur_hp);
    
    if(this.cur_hp > max_hp){
      this.cur_hp = this.max_hp;
      this.hp_dec = 0;
    }
    
		this.cur_mp = max_mp - mp_dec + bonus_mp;
    if(this.cur_mp <= 0){
      cur_mp = 0;
    }
    if(this.cur_mp > max_mp){
      cur_mp = max_mp;
    }

    //println("lv: "+level+" patk= "+patk+" pdef = "+pdef+" matk = "+matk+" mdef = "+mdef+" spd = "+spd+" hp = "+max_hp+" mp = "+max_mp);
    
	}
	
	//temporary stats increments for equipments and buffs
  public void levelUp(){
    
         this.level++;       

         this.AP += 3;
         
         room = 11;
         
         println("room: "+room);
         
           for(int i =0;i<stats_count;i++)
           {
             this.job.stats[i] += this.job.stats_inc[i];
         }
           
           this.init_stats();
           
           this.hp_dec = 0;
           
           this.mp_dec = 0;
           
           this.calc_stats(); 
           // println("Level up!, level now: "+this.level+" hp now: "+this.cur_hp+" mp now: "+this.cur_mp);   
 }
   
  
  public void gainExp(float ex){
    
    this.exp += ex;
    
    float exp_expect = this.level * 10;
    
    if(this.level == 25)
    {
        this.exp = exp_expect;
    }
    
    else{        
        do{
          
          if(this.exp - exp_expect >= 0)
          {
            if(this.exp - exp_expect == 0){
              this.exp = 0;
            }else{
              this.exp = this.exp - exp_expect;
            }
              levelUp();
              
              level_up = true;
          }
          
        }
        while(this.exp >= exp_expect && this.level < 25);    
    }
  }
 
	
	public void inc_str(float a){
		this.bonus_str += a;
	}
	
	public void inc_con(float a){
		this.bonus_con += a;
	}
	
	public void inc_int(float a){
		this.bonus_intel += a;
	}
	
	public void inc_wis(float a){
		this.bonus_wis += a;
	}
	
	public void inc_agi(float a){
		this.bonus_agi += a;
	}
	
	//setters

  public void set_str(float x){
    this.str = x;
  }
  
  public void set_con(float x){
    this.con = x;
  }
  
  public void set_intel(float x){
    this.intel = x;
  }
  
  public void set_wis(float x){
    this.wis = x;
  }
  
  public void set_agi(float x){
    this.agi = x;
  }
	
	public void set_flat_str(float x){
		this.flat_str = x;
	}
	
	public void set_flat_con(float x){
		this.flat_con = x;
	}
	
	public void set_flat_intel(float x){
		this.flat_intel = x;
	}
	
	public void set_flat_wis(float x){
		this.flat_wis = x;
	}
	
	public void set_flat_agi(float x){
		this.flat_agi = x;
	}
	
  public void set_flat_patk(float x){
    this.flat_patk = x;
  }
  
  public void set_flat_pdef(float x){
    this.flat_pdef = x;
  }
  
  public void set_flat_matk(float x){
    this.flat_matk = x;
  }
  
  public void set_flat_mdef(float x){
    this.flat_mdef = x;
  }
  
  public void set_flat_spd(float x){
    this.flat_spd = x;
  }
  
  public void set_flat_hp(float x){
    this.flat_max_hp = x;
  }
  
  public void set_flat_mp(float x){
    this.flat_max_mp = x;
  }
	/***************************
	*	Getters
	***************************/
	public int get_job_code(){
    return this.job_code;
  }
  
	public float get_str(){
		return this.str;
	}
	
	public float get_con(){
		return this.con;
	}
	
	public float get_intel(){
		return this.intel;
	}
	
	public float get_wis(){
		return this.wis;
	}
	
	public float get_agi(){
		return this.agi;
	}

  public float get_flat_str(){
    return this.flat_str;
  }
  
  public float get_flat_con(){
    return this.flat_con;
  }
  
  public float get_flat_intel(){
    return this.flat_intel;
  }
  
  public float get_flat_wis(){
    return this.flat_wis;
  }
  
  public float get_flat_agi(){
    return this.flat_agi;
  }
  
  public float get_flat_max_hp(){
    return this.flat_max_hp;
  }
  
  public float get_flat_max_mp(){
    return this.flat_max_mp;
  }


/********************
interaction
********************/
public int[] interact(){
  int coords[] = new int[2];
  
  switch(dir){
    //facing up
    case 0:
      coords[0] = (int) this.charX / sqw;
      coords[1] = ((int) this.charY / sqh) - 1;
      break;
      
    //facing right
    case 1:
      coords[0] = ((int) this.charX / sqw) + 1;
      coords[1] = (int) this.charY / sqh;
      break;
      
    //facing down
    case 2:
      coords[0] = (int) this.charX / sqw;
      coords[1] = ((int) this.charY / sqh) + 1;
      break;
      
    //facing left
    case 3:
      coords[0] = ((int) this.charX / sqw) - 1;
      coords[1] = (int) this.charY / sqh;
      break;
    
  }
  
  return coords;
}
	
	/***********************
	*test print
	***********************/
	public void display_stats(){
		System.out.println("Character status: ");
    System.out.println("Job: " + this.job.name);
		System.out.println("LEVEL: " + this.level);
		System.out.println("EXP: " + this.exp);
		System.out.println("STR: " + this.str);
		System.out.println("CON: " + this.con);
		System.out.println("INT: " + this.intel);
		System.out.println("WIS: " + this.wis);
		System.out.println("AGI: " + this.agi);
		System.out.println("HP: " + this.cur_hp);
		System.out.println("MP: " + this.cur_mp);
		System.out.println("MAXHP: " + this.max_hp);
		System.out.println("MAXMP: " + this.max_mp);
    System.out.println("CURHP: " + this.max_hp);
    System.out.println("CURMP: " + this.max_mp);
		System.out.println("PATK: " + this.patk);
		System.out.println("PDEF: " + this.pdef);
		System.out.println("MATK: " + this.matk);
		System.out.println("MDEF: " + this.mdef);
		System.out.println("SPD: " + this.spd);
	}
  
  /**************************************
  *  CW
  **************************************/
  public void PropertyPanel(){
    noStroke();
    fill((this.job_code - 1) * 12, 100, 100);
    
    rect(horizontal_margin, vertical_margin, UI_width, UI_height,10);
    
  }                    //close PropertyPanel()

  /**************************************
  *  CW
  **************************************/
  public void PropertySquare(){
    
    //fill((this.job_code - 1) * 12, 100, 60);
    fill(0, 0, 100);
    
    for(int n = 0; n < c_pt; n++){
      image(p[n].icon, horizontal_margin + (n+1)*sq_distance + n*Avatarsq_sl,vertical_margin + strip_distance,Avatarsq_sl,Avatarsq_sl);
    } 
    
    image(this.avatar, horizontal_margin + sq_distance + Big_sl *0.1f,vertical_margin + Avatarsq_sl + 2*v_a - Big_sl * 0.1f,Big_sl * 0.8f,Big_sl* 0.8f);
    
    fill(0,0,100);
    stroke((this.job_code - 1) * 12, 100, 60);
    for(int n=1 ; n <=Wpsq_num ; n++ ){
      
      rect(horizontal_margin + sq_distance + n*Wp_distance + (n-1)*Wpsq_sl - 1,vertical_margin + Avatarsq_sl + 2*sq_distance + 3*Wpsq_sl - 1,Wpsq_sl+1,Wpsq_sl+1);
      image(item_list[equipment[n-1]].img, horizontal_margin + sq_distance + n*Wp_distance + (n-1)*Wpsq_sl,vertical_margin + Avatarsq_sl + 2*sq_distance + 3*Wpsq_sl, Wpsq_sl, Wpsq_sl);
    }
    
    textSize(20);
    
    textAlign(CENTER);
    noStroke();
    for(int n = 1; n < Strip_num; n++){
      
    fill(0,0,100);
    
    rect(horizontal_margin + sq_distance + Big_sl + sq_distance,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance,Strip_width,Strip_height,10);
    
    //stroke(0);
    
    fill((this.job_code - 1) * 12, 100, 60);
    
    textSize(30);
    
      switch(n){
      
        case 1:
        
        text(this.name,horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5f*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75f*Strip_height);
        
        break;
        
        case 2:
        
        text(this.job.name,horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5f*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75f*Strip_height);
        
        break;
        
        case 3:
        
        text("Level: "+this.get_level(),horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5f*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75f*Strip_height);
        
        break;
        
        case 4:
        
        text("Exp: "+(int)this.get_exp(),horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5f*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75f*Strip_height);
        
        break;
        
      
      }
    
    }
    
    fill(0,0,100);
    
    rect(sq_distance + horizontal_margin,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + Strip_height,Strip_width,Strip_height,10);
    
    rect(horizontal_margin + Strip_width + 1.2f*sq_distance + addsq_sl,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + Strip_height,Strip_width,Strip_height,10);
    
    //stroke(0);
    
    fill((this.job_code - 1) * 12, 100, 60);
    
    text("Hp: "+(int)this.get_cur_hp(),sq_distance + horizontal_margin + 0.5f*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.75f*Strip_height);
    
    text("Mp: "+(int)this.get_cur_mp(),horizontal_margin + Strip_width + 1.2f*sq_distance + addsq_sl + 0.5f*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.75f*Strip_height);
    
    fill(0,0,100);
    
    ellipse(horizontal_margin + Strip_width + sq_distance + addsq_sl + Strip_width + 1.5f*sq_distance,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.5f*Strip_height,1.2f*sq_distance,1.2f*sq_distance);
    
    fill((this.job_code - 1) * 12, 100, 60);
    text(this.AP, horizontal_margin + Strip_width + sq_distance + addsq_sl + Strip_width + 1.5f*sq_distance,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.5f*Strip_height);
    
    fill(0,0,100);
    for(int n = 1; n <= Strip_num; n++){
      
      for(int l=1; l <=2 ;l++){
        fill(0,0,100);
    rect(horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance),vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance,Strip_width,Strip_height,10);
        
    //stroke(0);
    
    fill((this.job_code - 1) * 12, 100, 60);
    
    if(n==1){
    
      if(l==1){
      
        text("Str: "+(int)this.get_str(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
      
      }
      
      else{
      
        text("Patk: "+(int)this.get_patk(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
      
      }
      
    }
      
    if(n==2){
      
      if(l==1){
    
      text("Con: "+(int)this.get_con(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
    
      }
      
      else{
      
      text("Pdef: "+(int)this.get_pdef(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
      
      }
      
    }
    
    if(n==3){
      
      if(l==1){
    
      text("Intel: "+(int)this.get_intel(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
    
      }
      
      else{
      
      text("Matk: "+(int)this.get_matk(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
      
      }
      
    }
    
    if(n==4){
      
      if(l==1){
    
      text("Wis: "+(int)this.get_wis(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
    
      }
      
      else{
      
      text("Mdef: "+(int)this.get_mdef(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
      
      }
      
    }
    
    if(n==5){
      
      if(l==1){
    
      text("Agi: "+(int)this.get_agi(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
    
      }
      
      else{
      
      text("Spd: "+(int)this.get_spd(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5f*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75f*Strip_height);
      
      }
      
    }
    
       fill(0,0,100);
    
     }
     
     //stroke(0);
    
     rect(horizontal_margin + sq_distance + Strip_width + sq_distance,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance,addsq_sl,addsq_sl,10);
     
     fill((this.job_code - 1) * 12, 100, 60);
     
     text("+",horizontal_margin + sq_distance + Strip_width + sq_distance + 0.5f*addsq_sl,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance +0.75f*addsq_sl);
     
     fill(0,0,100);
     
     text("Gold: " + p[0].gold, horizontal_margin + UI_width/2, height - vertical_margin - Strip_height/2 - battle_UI_margin);
    
    }
    
    for(int n=1 ; n <=Wpsq_num ; n++ ){  
      if(mouseX >= (horizontal_margin + sq_distance + n*Wp_distance + (n-1)*Wpsq_sl)
        && mouseX <= (horizontal_margin + sq_distance + n*Wp_distance + (n-1)*Wpsq_sl) + Wpsq_sl 
        && mouseY >= (vertical_margin + Avatarsq_sl + 2*sq_distance + 3*Wpsq_sl)
        && mouseY <= (vertical_margin + Avatarsq_sl + 2*sq_distance + 3*Wpsq_sl) + Wpsq_sl){
          if(this.equipment[n-1] != item_count - 1){
            item_list[this.equipment[n-1]].desc(mouseX - bag.square_width * 3, mouseY, 1);
          }
      }
      
    }
    
  }

  /**************************************
  *  CW
  **************************************/
  public void charPanel(){
  
    PropertyPanel();
    
    PropertySquare();
  }
  /**************************************
  *  CW end
  **************************************/
}


  /******************************************

    show stats change while level up

******************************************/

 public void display_level_up(){

            stroke(0);
            
            smooth();
            
            for(int i = 0; i < c_pt;i++)
            {   
              
                if(p[i].level_up)
                {
                  fill(60,100,100);
                
                  rect(width*3/8 ,height/4 + 100*i,width/4,height/8);
                  
                  textAlign(CENTER);
                  
                  textSize(30);
                  
                  fill(0,0,100);
                  
                  text(p[i].name+"'s level up! Level now: "+p[i].level,width/2,  height*5/16 + 100*i);
                  
                  if(p[i].level % 5 == 0 && (int)(p[i].level / 5) >= 1 )
                  {
                    textSize(20);
                    
                    p[i].skills.skill_count++;
                    
                    text(p[i].name + " have learned " + p[i].skills.skill[(int)(p[i].level / 5)].name,  width/2 ,height*5/16 + 20+ 100*i);
                  }
                  
                  p[i].level_up = false;                
                }
                
          }         
}

public void display_gain(){

            stroke(0);
            
            smooth();
            
            if(victory)
          {
            for(int i = 0; i < c_pt;i++)
            {   
              
                
                  fill(60,100,100);
                
                  rect(width*3/8 ,height/4 + 100*i,width/4,height/8);
                  
                  textAlign(CENTER);
                  
                  textSize(30);
                  
                  fill(0,0,100);
                  
                  text(p[i].name+" has gain "+ total_exp +" exp",width/2,  height*5/16 + 100*i);
                  
                  textSize(20);  
                  
                  text("Team has gain "+ total_gold +" gold",  width/2 ,height*5/16 + 20);                            
          }           
       }          
}
//changed
/*******************************************************************
class units to set some basic data about unit
*********************************************************************/


class Units{
  protected int id, type, skill_count;
  public int[] skillset;
  public int active_buffs = 0;
  public String name;
  public float battle_x, battle_y;
  public float patk_mod = 1, pdef_mod = 1, matk_mod = 1, mdef_mod = 1, hp_mod = 1, mp_mod = 1, spd_mod = 1;
  public float[] buff_list = new float[buff_count];
  public int[] buff_round = new int[buff_count];
  protected int level,gold;
  protected boolean alive = true, can_move = true, can_die = true;
	protected float patk, pdef, matk, mdef, max_hp, max_mp, cur_hp, cur_mp, spd, exp;;
  protected float flat_patk, flat_pdef, flat_matk, flat_mdef, flat_max_hp, flat_max_mp, flat_spd;
	protected float hp_dec = 0, mp_dec = 0;
	protected float bonus_str = 0, bonus_con = 0, bonus_intel = 0, bonus_wis = 0, bonus_agi = 0;
	protected float bonus_patk = 0, bonus_pdef = 0, bonus_matk = 0, bonus_mdef = 0, bonus_hp = 0, bonus_mp = 0, bonus_spd = 0;
  protected int charX, charY;
  PImage img, battle_img, icon, avatar;
  Skill skills;
	
  public Units(){

	}

  public void display(){
    image(this.img, this.charX - sqw/4, this.charY - sqh/3, sqw + sqw/4, sqh + sqh/3);
  }
  
  public void calc_buff(){
    reset_mod();
    
    //Knight buffs
    //pdef, mdef
    if(this.buff_round[0] > 0){
      this.pdef_mod += this.buff_list[0];
      this.mdef_mod += this.buff_list[0];
    }
    
    //patk
    if(this.buff_round[2] > 0){
      this.patk_mod += this.buff_list[2];
    }
    
    //bleed
    if(this.buff_round[3] > 0){
      this.dec_hp(this.buff_list[3]);
      if(this.max_hp < hp_dec){
        this.hp_dec = max_hp;
        this.dead();
      }
    
      if(this.max_hp == this.hp_dec){
        this.dead();
      }
      
      println(this.name + " bleed " + this.buff_list[3]);
    }
    
    //Paladin buffs
    //stun 4 = paladin stun, 7 = paladin sleep stun, 9 = ranger stun, 13 = mage stun
    if(this.buff_round[4] > 0 || this.buff_round[7] > 0 || this.buff_round[9] > 0 || this.buff_round[13] > 0){
      this.can_move = false;
    }else{
      this.can_move = true;
    }
    
    if(this.buff_round[7] > 0){
      this.dec_hp(this.buff_list[7]);
    }
    
    if(this.buff_round[13] > 0){
      this.rec_hp(this.buff_list[13]);
    }
    
    //deny death
    if(this.buff_round[5] > 0){
      this.can_die = false;
    }else{
      this.can_die = true;
    }
    
    //HOT
    if(this.buff_round[6] > 0){
      this.rec_hp(this.buff_list[6]);
    }
    
    //Ranger
    //patk matk inc
    if(this.buff_round[8] >= 0){
      this.bonus_patk += this.buff_list[8];
      this.bonus_matk += this.buff_list[8];
    }
    
    //Assassin
    //agi inc
    if(this.buff_round[10] >= 0){
      this.bonus_patk += this.buff_list[8];
      this.bonus_matk += this.buff_list[8];
    }
     
    //bleed
    if(this.buff_round[11] > 0){
      this.dec_hp(this.buff_list[11]);
    }
    
    if(this.buff_round[12] > 0){
      this.patk_mod += this.buff_list[12];
    }
    
    //priest
    //stats inc
    if(this.buff_round[14] > 0){
      this.patk_mod += this.buff_list[14];
      this.pdef_mod += this.buff_list[14];
      this.matk_mod += this.buff_list[14];
      this.mdef_mod += this.buff_list[14];
      this.spd_mod += this.buff_list[14];
    }
    
    if(this.buff_round[15] > 0){
      this.patk_mod += this.buff_list[15];
      this.pdef_mod += this.buff_list[15];
      this.matk_mod += this.buff_list[15];
      this.mdef_mod += this.buff_list[15];
      this.spd_mod += this.buff_list[15];
    }
    
    this.active_buffs = 0;
    
    for(int i = 0; i < buff_count; i++){
      if(buff_round[i] > 0){
        active_buffs++;
      }
    }
  }
  
  public void reset_mod(){
    patk_mod = 1;
    pdef_mod = 1;
    matk_mod = 1;
    mdef_mod = 1;
    hp_mod = 1;
    mp_mod = 1;
    spd_mod = 1;
  }
	
	//temporary stats increments for equipments and buffs
	public void inc_patk(float a){
		this.bonus_patk += a;
	}
	
	public void inc_pdef(float a){
		this.bonus_pdef += a;
	}
	
	public void inc_matk(float a){
		this.bonus_matk += a;
	}
	
	public void inc_mdef(float a){
		this.bonus_mdef += a;
	}
	
	public void inc_spd(float a){
		this.bonus_spd += a;
	}
	
	public void inc_hp(float a){
		this.bonus_hp += a;
	}
	
	public void inc_mp(float a){
		this.bonus_mp += a;
	}
	
	public void rec_hp(float a){
		if(this.hp_dec >= a){
			this.hp_dec -= a;
		}else{
			this.hp_dec = 0;
		}
	}
	
	public void rec_mp(float a){
		if(this.mp_dec >= a){
			this.mp_dec -= a;
		}else{
			this.mp_dec = 0;
		}
	}
	
	//temporary decrease
	public void dec_hp(float a){
		this.hp_dec += a;
	}
	
	public void dec_mp(float a){
		this.mp_dec += a;
	}

  //dead and alive
  public void dead(){
    if(this.can_die){
      //death.play();
      this.alive = false;
    }else{
      this.alive = true;
      this.buff_round[5] = 0;
      this.cur_hp = 1;
      this.hp_dec = this.max_hp - 1;
      this.can_die = true;
    }
  }
  
  public void ress(){
    println("alive|");
     this.alive = true;
     
     this.cur_hp = 1;
     this.hp_dec = 0;
  }
  
  //attack
  public void attack(){
  }
  
  // gold increase
  public void gold_inc(int a){
     this.gold += a;
  }
  
	
	//Setter
  
  public void set_img(String s, int type){
    switch(type){
      case 1:  
        img = loadImage("src/player/" + s + ".png");
        break;
      case 2:
        img = loadImage("src/boss/" + s + ".png");
        break;
      case 3:  
        img = loadImage("src/elite/" + s + ".png");
        break;
      case 4:
        img = loadImage("src/mobs/" + s + ".png");
        break;
    }
  }
  
  public void set_gold(int x){
    this.gold = x;
  }
  
  public void set_id(int x){
    this.id = x;
  }
  
  public void set_skill_count(int x){
    this.skill_count = x;
  }

  public void set_x(int x){
    this.charX = x;
  }
  
  public void set_y(int y){
    this.charY = y;
  }
  
  public void set_loc(int x, int y){
    this.charX = x;
    this.charY = y;
  }
  
  public void set_type(int x){
    this.type = x;
  }
  
	public void set_level(int x){
		this.level = x;
	}

  public void set_exp(float x){
    this.exp = x;
  }
	
	public void set_patk(float x){
		this.patk = x;
	}
	
	public void set_pdef(float x){
		this.pdef = x;
	}
	
	public void set_matk(float x){
		this.matk = x;
	}
	
	public void set_mdef(float x){
		this.mdef = x;
	}
	
	public void set_spd(float x){
		this.spd = x;
	}
	
	public void set_max_hp(float x){
		this.max_hp = x;
	}
	
	public void set_max_mp(float x){
		this.max_mp = x;
	}
	
	//Getter
  public boolean is_alive(){
    return this.alive;
  }
  
  public int get_id(){
    return this.id;
  }
  
  public int get_type(){
    return this.type;
  }
  
	public int get_level(){
		return this.level;
	}

  public float get_exp(){
    return this.exp;
  }
	
	public float get_patk(){
		return this.patk;
	}
	
	public float get_pdef(){
		return this.pdef;
	}
	
	public float get_matk(){
		return this.matk;
	}
	
	public float get_mdef(){
		return this.mdef;
	}
	
	public float get_spd(){
		return this.spd;
	}
	
	public float get_cur_hp(){
		return this.cur_hp;
	}
	
	public float get_cur_mp(){
		return this.cur_mp;
	}
	
	public float get_max_hp(){
		return this.max_hp;
	}
	
	public float get_max_mp(){
		return this.max_mp;
	}

  public float get_hp_dec(){
    return this.hp_dec;
  }
  
  public int get_gold(){
    return this.gold;
  }
}
/*******************************************
drawfunction, base on variable room to know where we are
********************************************/ 
int battle_mode = 0;
String [] options = {"Main Menu", "Load", "Quit"};
String[] job_list = {"Knight", "Paladin", "Ranger", "Assassin", "Mage", "Priest"};
int mainY, saveY, exitY, text_height;
float bagoptX, bagoptY;
float pc_width, pc_height, pcx, pcy, hp_percent;
  float enemy_width, enemy_height, enemy_start_x, enemy_start_y, enemy_x, enemy_y;
  float command_x, command_y, command_radius;
  float target_diameter;
  float tri_width, tri_height;
  boolean no_move = false;
  

  /*******************************************
            Main menu
  ********************************************/


 public void menu(){
  
    font = loadFont("menu_font.vlw");
    
    textAlign(CENTER,CENTER);
    textFont(font);
    
  //should be replaced by image
    bg = loadImage("src/backgroundimage/evil_castle.jpg");
    image(bg, 0, 0, width, height);
  //
  
    textSize(60);
    text("Evil Castle",side_margin,height_margin/2);
                                  
    textSize(30);
    text("New Game", side_margin, height_margin);
                                  
    textSize(30);
    text("Load Game", side_margin, height_margin+150);
                                  
    textSize(30);
    text("Exit", side_margin, height_margin+300);
 
    
  }                    //close menu()
  
  
  /*******************************************
            job choice while newgame()
  ********************************************/
  
  public void jobchoicestyle(){
    image(bg, 0, 0, width, height);
   
    text_height =25;
    boxwidth = 240;
    boxheight = 360;
    
    boxX = (width-boxwidth)/2;
    boxY = (height-boxheight)/2;
    
    fill(0,0,100);
    textSize(45);
    text("Please choose your job",boxX+boxwidth/2,50);
    
    fill(60,100,100);
    noStroke();
    rect(boxX,boxY,boxwidth,boxheight,9);
    stroke(0);
    textAlign(CENTER, CENTER);
    textSize(text_height);
    fill(0,0,100);
    for(int i =0; i<total_jobs;i++)
    {
      
      text(job_list[i],boxX+boxwidth/2,i*60+boxY+40);     
    }
              
  }                  //close jobchoicestyle()
  
  
  public void option(){
    
    text_height = 40;
    
    fill(60, 100, 100, 60);
    noStroke();
    rect(boxX,boxY,boxwidth,boxheight,30);
    
    fill(90, 80, 80, 80);
    textSize(text_height);
    textAlign(CENTER);
    for(int i =0; i<3;i++)
    {
      text(options[i],boxX+(boxwidth/2),boxY+i*(text_height+30)+boxheight/3);
    }
    
    mainY = boxY+boxheight/3;
    saveY = mainY + 70;
    exitY = saveY + 70;
  }                    //close option()
  
  
  public void bag_option(){
    strokeWeight(1);
    fill(12,100,100);
    rect(bagoptX,bagoptY,bag.square_width*3,bag.square_height*3);
    
    textAlign(CENTER, CENTER);
    fill(255,100,100);
    stroke(4);
    textSize(24);
    text("USE",bagoptX + bag.square_width*1.5f, bagoptY + bag.square_height*0.5f);
    line(bagoptX, bagoptY + bag.square_height, bagoptX+ bag.square_width*3, bagoptY + bag.square_height);
    text("DROP",bagoptX + bag.square_width*1.5f, bagoptY + bag.square_height*1.5f);
    line(bagoptX, bagoptY + bag.square_height*2, bagoptX + bag.square_width* 3, bagoptY + bag.square_height*2);
    text("CANCEL",bagoptX + bag.square_width*1.5f, bagoptY + bag.square_height*2.5f);
     
  }                    //close bag_option()
  
  /*******************************************
       UI while battle
  ********************************************/
      
  public void battle_UI(int enemy_count){
  battle_end();
  
  pc_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt + 1);
  pc_height = (height*2/3 - 3.0f * battle_UI_margin)/ (float)(max_pt + 2);
  pcx = width*2/3.0f + battle_UI_margin + (float)(max_pt/2.0f) * pc_width;
  pcy = battle_UI_margin + pc_height/2.0f;
  
  enemy_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt+1);
  enemy_height = (height*2/3.0f - 3.0f * battle_UI_margin)/ (float)(max_pt+2);
  enemy_start_x = battle_UI_margin + (float)enemy_width;
  enemy_start_y = battle_UI_margin + enemy_height/2.0f;
  enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
  enemy_y = enemy_start_y;
  
  command_radius = (width/3.0f - 4.0f * battle_UI_margin)/ 4.0f;
  command_x = width/2.0f;
  command_y = height/3.0f + battle_UI_margin/2.0f; 
  
  textSize(40);
  background(battle_bg);
  /*
  fill(66, 100, 100);
  rect(battle_UI_margin, battle_UI_margin, width/2 - 2 * battle_UI_margin, height*2/3 - 2 * battle_UI_margin);
  
  fill(40, 100, 100);
  rect(width/2 + battle_UI_margin, battle_UI_margin, width/2 - 2 * battle_UI_margin, height*2/3 - 2 * battle_UI_margin);
  */
  
  //Draw enemies
  noStroke();
  for(int i = 0; i < enemy_count; i++){
    if(i == 0){
      if(m[0].is_alive()){
        image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }else{
        image(dead, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
      }
    }else{
      
      if(i % 2 == 0){
        enemy_x += enemy_width * m[i-1].get_mod();
      }else{
        enemy_x -= enemy_width * m[i-1].get_mod();
      }
      
      if(m[i].is_alive()){
        image(m[i].img, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }else{
        image(dead, enemy_x, enemy_y, enemy_width * m[i].get_mod(), enemy_height * m[i].get_mod());
        m[i].battle_x = enemy_x;
        m[i].battle_y = enemy_y;
      }
    }
    
    enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
    //println("mob lv: " + m[i].get_level() + " patk: " + m[i].get_patk());
  }
  
  //Draw player status boxes
  p_box();
  
  //Draw player images and player status
  for(int i = 0; i < c_pt; i++){
    
      p[i].battle_x = i*pc_width/2.0f + pcx;
      p[i].battle_y = i*pc_height*1.5f + pcy;
      
    if(p[i].is_alive()){  
      
      image(p[i].battle_img, p[i].battle_x, p[i].battle_y, pc_width, pc_height);
      
      //over head hp bar
      hp_percent = (float)p[i].get_cur_hp() / (float)p[i].get_max_hp();
      strokeWeight(1);
      stroke(0,100,0);
      fill(0,0,100);
      rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width, battle_UI_margin, 50);
      fill(0,100,100);
      rect(i*pc_width/2.0f + pcx, i*pc_height*1.5f + pcy - battle_UI_margin * 2, pc_width * hp_percent, battle_UI_margin, 50);
    }else{
      
      image(dead, p[i].battle_x, p[i].battle_y, pc_width, pc_height);
      
    }
      
        //player stats
        p_stats(i);
      
    }
    
    stroke(0, 100, 100);
    fill(0, 100, 100);
    textSize(30);
    textAlign(CENTER);
    text("ROUND: " + round, width/2, p[0].vertical_margin/2);
    
    unit_turn();
    display_buff_icons();
    /*****************************
    *  battle round starts
    *****************************/
    switch(battle_mode){
      //player turn start draw commands
      case 0:
        if(battle_list[cur].is_alive()){
          if(battle_list[cur].can_move){
            no_move = false;
            battle_command_UI();
          }else{
            no_move = true;
            battle_mode = 10;
          }
        }else{
          battle_mode = 10;
          println("player dead");
        }
        break;
        
      //player chooses attack target
      //image(m[i].img, enemy_x - i*enemy_width/2.0f, enemy_y + i*enemy_height*1.5f, enemy_width, enemy_height);
      case 1:
        enemy_selection();
        
        break;
      
      //player uses skill
      case 2:
        battle_command_UI();
        skill_box_width = command_radius * 1.5f;
        skill_box_height = height * 2 / (command_radius/4.0f);
        //println("cur: " + battle_list[cur].name);
        for(int i = 0; i < p[battle_list[cur].get_id()].skills.skill_count; i++){
           fill(65, 100, 100);
           rect(command_x + command_radius * 1.5f + battle_UI_margin, command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5f)), skill_box_width, skill_box_height);
           fill(0,0,100);
           textSize(skill_box_height/3);
           textAlign(CENTER, CENTER);
           text(p[battle_list[cur].get_id()].skills.skill[i].name, command_x + command_radius * 1.5f + battle_UI_margin + skill_box_width/2, command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5f)) + skill_box_height/2);
        }
        skill_desc();
      break;
      
      //player uses item
      case 3:
        select_item = false;
        bag.BagSquare(2);
        if(!usable){
          not_usable();
        }
        
        if(!select_item)
        {
           item_desc(2);
        }
        break;
      
      //player selects target
      case 4:
        ally_selection();
        
        break;
        
      case -1:
        if(battle_list[cur].is_alive()){
          if(battle_list[cur].can_move){
            no_move = false;
            println("monster round");
            switch(m[mid].getMType()){
              case 1:
                normal.attack_mode();
                break;
              case 2:
              elite.attack_mode();
                break;
              case 3:
              boss.attack_mode();
                break;
            }
          }else{
            no_move = true;
          }
        }else{
          println("monster dead");
        }
        battle_mode = 10;
        break;
      
      
      //battle turn & round end
      case 10:
        
        if(frameCount - start_frame < 100){
            for(int i = 0; i < max_pt; i++){
              if(hit[i] != -1){
                display_damage(hit[i], ((battle_list[cur].get_type() + 1) % 2));
              }
            }
            
            //for(int i = 0; i < c_pt; i++){
            //  println("Name: " + p[i].name + " is alive: " + p[i].is_alive());
            //}
        }
        else{
          esc = true;
          arrive = false;
          returned = false;
          if(battle_list[cur].buff_round[12] <= 0){
            cur++;
            if(cur >= (c_pt + enemy_count)){
              cur = 0;
              round++;
              
              check_buff_status();
              hit_set();
              
              for(int i = 0; i < (c_pt + enemy_count); i++){
                battle_list[i] = round_order()[i];
              }
              //println("cur pdef: " + p[0].get_pdef());
            }
            
          //Assassin delay move buff
          }else{
            Units temp;
            battle_list[cur].calc_buff();
            for(int i = cur; i < (c_pt + enemy_count) - 1; i++){
                temp = battle_list[i];
                battle_list[i] = battle_list[i + 1];
                battle_list[i + 1] = temp;
              }
          }
          
          if(battle_list[cur].get_type() == 0){
            mid = battle_list[cur].get_id();
            battle_mode = -1;
          }else{
            pid = battle_list[cur].get_id();
            battle_mode = 0;
          }
        }
        
      break;     
    }
  
}

/*************************************************
*  Draw Battle Command UI
**************************************************/
public void battle_command_UI(){
    strokeWeight(battle_UI_margin);
    stroke(24, 100, 100);
    fill(12, 50,100,20);
    ellipse(command_x, command_y, command_radius * 2, command_radius * 2);
    for(int i = 0; i < 4; i++){
      if(i % 2 == 0){
        noStroke();
        fill(65, 100, 100);
        ellipse(command_x, command_y + (i - 1) * command_radius, command_radius, command_radius);
      }else{
        noStroke();
        fill(65, 100, 100);
        ellipse(command_x + (i - 2) * command_radius, command_y, command_radius, command_radius);
      }
      
      switch(i){
        case 0:
          textSize(command_radius/ 3.0f);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Attack", command_x, command_y + (i - 1) * command_radius);
          break;
        case 1:
          textSize(command_radius/ 3.0f);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Item", command_x + (i - 2) * command_radius, command_y);
          break;
        case 2:
          textSize(command_radius/ 3.0f);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Flee", command_x, command_y + (i - 1) * command_radius);
          break;
        case 3:
          textSize(command_radius/ 3.0f);
          textAlign(CENTER, CENTER);
          fill(0,0,100);
          text("Skill", command_x + (i - 2) * command_radius, command_y);
          break;
      }
    }
}
      /*******************************************
             alies and player status pannel
      ********************************************/
  
public void p_box(){
  fill(80, 80, 100);
  
  for(int i = 0; i < max_pt; i++){
    cx = c_width*i + (i+1)*battle_UI_margin;
    rect(cx, cy, c_width, c_height);
  }
}

  public void p_stats(int c){
    cx = c_width*c + (c+1)*battle_UI_margin;
    fill(0,0,100);
    textAlign(CENTER);
    text(p[c].name, cx + c_width/2, cy + c_height/4);
    text("HP: " + (int)p[c].cur_hp + " / " + (int)p[c].max_hp, cx + c_width/2, cy + c_height/2);
    text("MP: " + (int)p[c].cur_mp + " / " + (int)p[c].max_mp, cx + c_width/2, cy + c_height*3/4);
  }
  
  /*****************************************************
  *  select enemy circle
  *****************************************************/
public void enemy_selection(){
  enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
        enemy_y = enemy_start_y;
        target_diameter = (float)Math.sqrt( 2*(Math.pow((double)enemy_width,2.0f)) );
        strokeWeight(3);
        stroke(0,100,100);
        fill(0,100,100,0);
        
        for(int i = 0; i < enemy_count; i++){
          if(i > 0){
            if(i % 2 == 0){
              enemy_x += enemy_width * m[i-1].get_mod();
            }else{
              enemy_x -= enemy_width * m[i-1].get_mod();
            }
          }
          
          if(m[i].is_alive()){
            ellipse(enemy_x + (enemy_width/2.0f * m[i].get_mod()), enemy_y + enemy_height/2.0f * m[i].get_mod(), target_diameter * m[i].get_mod(), target_diameter * m[i].get_mod());
          }
          enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
        }
}

    /*****************************************************
  *  select ally triangle
  *****************************************************/
public void ally_selection(){
  noStroke();
        fill(32, 80, 100);
        tri_width = c_width * 0.1f;
        tri_height = tri_width * 1.5f;
        
        //when using skill
        if(command != 7){
          //0 use on self only, 1 use on ally
          switch(battle_list[cur].skills.skill[command].type){
              case 0:
                for(int i = 0; i < c_pt; i++){
                  cx = c_width*i + (i+1)*battle_UI_margin;
                  if(p[i] == battle_list[cur]){
                    triangle(cx + c_width/2, cy - battle_UI_margin, cx + c_width/2 - tri_width, cy - battle_UI_margin - tri_height, cx + c_width/2 + tri_width, cy - battle_UI_margin - tri_height);
                  }  
                }
                break;
                
              case 1:
                for(int i = 0; i < c_pt; i++){
                  cx = c_width*i + (i+1)*battle_UI_margin;
                  
                  //if priest uses revive
                  if(p[battle_list[cur].get_id()].job_code == 6 && command == 5){
                    if(!p[i].is_alive()){
                      triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
                    }
                    
                  //if other skills
                  }else{
                    if(p[i].is_alive()){
                      triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
                    }
                  }
                }
                break;
          }
          
        //when using item
        }else{
          for(int i = 0; i < c_pt; i++){
            cx = c_width*i + (i+1)*battle_UI_margin;
            
            if(item_list[bag.inv[bag_y][bag_x]].id != 39){
              if(p[i].is_alive()){
                triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
              }
            }else{
              if(!p[i].is_alive()){
                triangle(cx + c_width/2 - tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2 + tri_width/2, cy - tri_height - battle_UI_margin, cx + c_width/2, cy - battle_UI_margin);
              }
            }
          }
        }
}


    public void help_letter(){
      
      fill(60,100,100);
      
      int size = 25;
      
      rect(width/4,height/4,width/2,height/2,50);
      
      float text_x = width/4+10;
      
      float text_y = height/4;
      
      textSize(size);
      
      textAlign(LEFT);
      
      fill(0,0,100);
      
      text("Hello Adam:", text_x +size ,text_y + size);
      
      size = 30;
      
      text("I am your firend Wang, I got your message and finally found your sister. She was caught",text_x , text_y + 2*size);
      
      text("by the king of vampire - Dracula, also the lord of the evil castle. About the reason, I",text_x, text_y + 3*size);
      
      text("think is your family's Bloodline. Your sister's blood can keep him alive even with light.",text_x, text_y + 4*size);
      
      text("I have ask my friend send you in, but you need to defeat all his Subordinates. Your",text_x, text_y + 5*size);
      
      text("sister in on the top floor. I think you can find people in castle who was caught like your",text_x, text_y + 6*size);
      
      text("sister.",text_x, text_y + 7*size);
      
      text("Good Luck",text_x, text_y + 8*size);
      
      text("keycode 'O' for tiny menu",text_x, text_y + 11*size);
      
      text("keycode 'F' for interactive",text_x, text_y + 12*size);
      
      text("keycode 'B' for open backpack",text_x, text_y + 13*size);  
      
      text("keycode 'H' for open this letter again                                       Made by KOGD team",text_x, text_y + 14*size);    
  }
String [] shop_option = {"Shop", "Save", "Leave"};
   /*******************************************
     function about game data
  ********************************************/ 
 
 
 public void newGame(){
    
     font = loadFont("main_font.vlw");
     textFont(font);
    
    saved = false;
    
    room = 1;
    jobchoicestyle();   
  }                    //close newGame()
  
  
  public void load(){
    
    try{
      profile = loadStrings("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("LOAD FAILED");
    }
    
    println(profile.length);
    
    font = loadFont("main_font.vlw");
    textFont(font);
    
    if(profile.length > 0){
      boss_defeated = Integer.parseInt(profile[0]);
      floor = Integer.parseInt(profile[1]);
      floor_room = Integer.parseInt(profile[2]);
      c_pt = Integer.parseInt(profile[3]);
      
       
      for(int i = 0; i < c_pt; i++){
        p[i] = new Player(Integer.parseInt(profile[4 + (i * 12)]));
        p[i].name = p[i].job.name;
        p[i].set_id(i);
        p[i].set_level(Integer.parseInt(profile[5 + (i * 12)]));
        p[i].set_exp(Float.parseFloat(profile[6 + (i * 12)]));
        p[i].set_flat_str(Float.parseFloat(profile[7 + (i * 12)]));
        p[i].set_flat_con(Float.parseFloat(profile[8 + (i * 12)]));
        p[i].set_flat_intel(Float.parseFloat(profile[9 + (i * 12)]));
        p[i].set_flat_wis(Float.parseFloat(profile[10 + (i * 12)]));
        p[i].set_flat_agi(Float.parseFloat(profile[11 + (i * 12)]));
        p[i].AP = Integer.parseInt(profile[12 + (i * 12)]);
        p[i].equipment[0] = Integer.parseInt(profile[13 + (i * 12)]);
        p[i].equipment[1] = Integer.parseInt(profile[14 + (i * 12)]);
        p[i].equipment[2] = Integer.parseInt(profile[15 + (i * 12)]);
        p[i].skills.skill_count = (p[i].get_level() / 5) + 1;
      }
        
        p[0].gold = Integer.parseInt(profile[(4 + c_pt * 12) + 1]);
        
        for(int i = 0; i < bag.inv.length; i++){
          for(int j = 0; j < bag.inv[i].length; j++){
            bag.inv[i][j] = Integer.parseInt(profile[(4 + c_pt * 12) + 1 + i * bag.inv[0].length + j]);
          }
        }
        
        
      p[0].set_img("player_2",1);
      p[0].name = "Adam";
      p[0].battle_img = loadImage("src/player/battle/Player.png");
      p[0].icon = loadImage("src/player/icon/Player.png");
      p[0].avatar = loadImage("src/player/avatar/player.png");
      p[0].set_loc(20*sqw,9*sqh);
      
      if(c_pt > 0){
        for(int i = 1; i < c_pt; i++){
          npc_in_cell[p[i].get_job_code() - 1] = false;
          
          switch(p[i].get_job_code()){
            case 1:
              floor_1[2].del_npc(13, 8);
              break;
              
            case 2:
              floor_1[2].del_npc(18, 8);
              break;
              
            case 3:
              floor_1[2].del_npc(23, 8);
              break;
              
            case 4:
              floor_1[2].del_npc(13, 13);
              break;
              
            case 5:
              floor_1[2].del_npc(18, 13);
              break;
              
            case 6:
              floor_1[2].del_npc(23, 13);
              break;
          }
        }
      }
      
      switch(floor){
        case 1:
          map = floor_1[floor_room - 1];
          break;
          
        case 2:
          map = floor_2[floor_room - 1];
          break;
          
        case 3:
          map = floor_3[floor_room - 1];
          break;
          
        case 4:
          map = floor_4[floor_room - 1];
          break;
          
        case 5:
          map = floor_1[floor_room - 1];
                  
          p[0].set_loc(26*sqw,11*sqh);
          break;
      }
      
      room = 2;
      saved = false;
      println("load save finish");
                  
    }else{
      println("no save");
      saved = true;
      
    }
    
  }                    //close load()
  
  
  public void saveData(){
    File f = new File(dataPath("bin/characterdata"), "saveddata.txt");
    f.delete();
    try{
      output = createWriter("bin/characterdata/saveddata.txt");
    }catch(Exception e){
      System.out.println("SAVE FAILED");
    }
    
    output.println(boss_defeated);
    output.println(floor);
    output.println(floor_room);
    output.println(c_pt);
    
    for(int i = 0; i < c_pt; i++){
      output.println(p[i].get_job_code());
      output.println(p[i].get_level());
      output.println(p[i].get_exp());
      output.println(p[i].get_flat_str());
      output.println(p[i].get_flat_con());
      output.println(p[i].get_flat_intel());
      output.println(p[i].get_flat_wis());
      output.println(p[i].get_flat_agi());
      output.println(p[i].AP);
      
      output.println(p[i].equipment[0]);
      output.println(p[i].equipment[1]);
      output.println(p[i].equipment[2]);
    }
    
    output.println(p[0].gold);
    
    for(int i = 0; i < bag.inv.length; i++){
      for(int j = 0; j < bag.inv[i].length; j++){
        output.println(bag.inv[i][j]);
      }
    }
    
    output.close();
  }                    //close saveData()
  
public void check_buff_status(){
    
    for(int i = 0; i < (c_pt + enemy_count); i++){
      for(int j = 0; j < buff_count; j++){
        
        if(battle_list[i].buff_round[j] > 0){
          battle_list[i].calc_buff();
          //println(battle_list[i].name + " buff round --");
          battle_list[i].buff_round[j]--;
          
          //println("buff " + i + " round left: " + battle_list[i].buff_round[j]);
          
          if(battle_list[i].buff_round[j] == 0){
            buff_end(i, j);
          }
        }
      }
    }
}

public void buff_end(int target, int loc){
    
    //println("end buff");
    battle_list[target].buff_list[loc] *= -1;
    battle_list[target].calc_buff();
    battle_list[target].buff_list[loc] = 0;
    
}

public void skill_desc(){
  String[] skill_type = {"true damage","physical damage", "magic damage", "recovery hp,mp", "buff"};
  for(int i = 0; i < p[battle_list[cur].get_id()].skills.skill_count; i++){
    if(mouseX >= (command_x + command_radius * 1.5f + battle_UI_margin) && mouseX <= (command_x + command_radius * 1.5f + battle_UI_margin) + skill_box_width
      && mouseY >= (command_y + skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5f)) && mouseY <= (command_y + skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5f)) + skill_box_height){
        fill(12,70,90);
        rect(c_width + 2*battle_UI_margin, cy, c_width * 2 + battle_UI_margin, c_height*2/3);
        
        textSize(30);
        fill(0,100,0);
        textAlign(LEFT,TOP);
        text("Skill Type: " + skill_type[p[battle_list[cur].get_id()].skills.skill[i].dmg_type], width/2 - c_width, cy + battle_UI_margin);
        
        textAlign(RIGHT,TOP);
        text("Cost: " + p[battle_list[cur].get_id()].skills.skill[i].mp_dec, width/2 + c_width, cy + battle_UI_margin);
        
        textAlign(CENTER,CENTER);
        text(p[battle_list[cur].get_id()].skills.skill[i].description, width/2, cy + c_height/3);
        
      }
  }
}

public void unit_turn(){
  fill(0, 100, 100);
  textAlign(CENTER, CENTER);
  textSize(25);
  text(battle_list[cur].name + "\'s", command_x, command_y);
  text("turn", command_x, command_y + 35);
}

public void draw_NPC(int x, int y, int target){
  image(npc[target], x - sqw/4, y - sqh/3, sqw + sqw/4, sqh + sqh/3);
}

public void NPC_join(){
  noStroke();
  fill(60,100,100);
  rect(width*0.2f, height*2/3, width * 0.6f, height / 3 - 10, 30);
  
  fill(0,0,100);
  textSize(30);
  textAlign(CENTER, CENTER);
  
  if(new_companion == 0){
    text("You need a key to open this door!", width/2, height*2/3 + (height / 3 - 10)/2);
  }else{
    fill(60,100,100);
    rect(width*0.2f, height/ 2, 100, 100, 30);
    fill(0,0,100);
    text("YES", width*0.2f + 50, height/ 2 + 50);
    
    fill(60,100,100);
    rect(width*0.8f - 100, height/ 2, 100, 100, 30);
    fill(0,0,100);
    text("NO", width*0.8f - 50, height/ 2 + 50);
  }
  
  fill(0,0,100);
  switch(new_companion){
    
    case 1:
      text("would you like Knight to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 2:
      text("would you like Paladin to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 3:
      text("would you like Ranger to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 4:
      text("would you like Assassin to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 5:
      text("would you like Mage to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
    
    case 6:
      text("would you like Priest to join your party!", width/2, height*2/3 + (height / 3 - 10)/2);
      break;
  }
}

public void display_buff_icons(){
  int rows, shown = 0;
  
  pc_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt + 1);
  pc_height = (height*2/3 - 3.0f * battle_UI_margin)/ (float)(max_pt + 2);
  pcx = width*2/3.0f + battle_UI_margin + (float)(max_pt/2.0f) * pc_width;
  pcy = battle_UI_margin + pc_height/2.0f;
  
  enemy_width = (width/3.0f - 4.0f * battle_UI_margin)/ (float)(max_pt+1);
  enemy_height = (height*2/3.0f - 3.0f * battle_UI_margin)/ (float)(max_pt+2);
  enemy_start_x = battle_UI_margin + (float)enemy_width;
  enemy_start_y = battle_UI_margin + enemy_height/2.0f;
  enemy_x = enemy_start_x + enemy_width * m[0].get_mod();
  enemy_y = enemy_start_y;
  
  //Draw enemies
  noStroke();
  for(int i = 0; i < enemy_count; i++){
    shown = 0;
    rows = m[i].active_buffs / 4 + 1;
    
    if(i != 0){
      if(i % 2 == 0){
        enemy_x += enemy_width * m[i-1].get_mod();
      }else{
        enemy_x -= enemy_width * m[i-1].get_mod();
      }
    }
    
    for(int j = 0; j < buff_count; j++){
      if(m[i].buff_round[j] > 0){
        image(buff_icon[j], enemy_x + (shown % 4) * 25, enemy_y - (rows - (shown / 4)) * 25, 20, 20);
        shown++;
      }
    }
    
    enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
     
  }
  
  //Draw player images and player status
  for(int i = 0; i < c_pt; i++){
    shown = 0;
    rows = p[i].active_buffs / 4 + 1;
    
    //println(p[i].name + " has " + p[i].active_buffs + " number of buffs.");
    
    for(int j = 0; j < buff_count; j++){
      if(p[i].buff_round[j] > 0){
        image(buff_icon[j], p[i].battle_x - (shown % 4) * 25 - 25, p[i].battle_y - (rows - (shown / 4)) * 25, 20, 20);
        shown++;
      }
    }
    
  }
}

public void loot(){
  int rand, loot_count = (enemy_count * (r.nextInt(floor) + floor / 3));
  int rand_med, rand_eq;
  int[] loots;
  
  if(loot_count > 0){
    loots = new int[loot_count];
    
    for(int i = 0; i < loots.length; i++){
      rand = r.nextInt(10000) % 100;
      
      //key for equipment
      if(rand < 10){
        println("key");
        loots[i] = 100;
        
      //gold
      }else if(rand < 29){
        println("gold");
        p[0].gold += r.nextInt(100) * floor;
        
      //potions
      }else if(rand < 80){
        println("med");
        rand_med = r.nextInt(100);
        
        if(rand_med < 30){
          loots[i] = 90;
        }else if(rand_med < 60){
          loots[i] = 93;
        }else if(rand_med < 75){
          loots[i] = 91;
        }else if(rand_med < 90){
          loots[i] = 94;
        }else if(rand_med < 95){
          loots[i] = 92;
        }else{
          loots[i] = 95;
        }
      
      //equipment
      }else{
        println("equipment");
          rand_eq = r.nextInt(1000) % c_pt;
          
          rand = r.nextInt(100) % (floor - 1);
          
          loots[i] = (p[rand_eq].job_code * 100) + ((r.nextInt(3) + 1) * 10) + (rand + 1);
          
          for(int j = 0; j < item_list.length; j++){
            if(item_list[j].get_id() == loots[i]){
              loots[i] = j;
            }
          }
      }
      
      for(int j = 0; j < bag.inv.length; j++){
        for(int k = 0; k < bag.inv[j].length; k++){
          if(bag.inv[j][k] == item_count - 1){
            bag.inv[j][k] = loots[i];
            j = bag.inv.length - 1;
            k = bag.inv[j].length - 1;
          }else if(j == bag.inv.length - 1 && k == bag.inv[j].length - 1){
            println("Bag Full!");
            i = loots.length - 1;
          }
        }
      }
    }
    
  }else{
    println("empty loot");
  }
}

public void shop_menu(){
  text_height = 40;
  boxwidth = 240;
  boxheight = 360;
    
  boxX = (width-boxwidth)/2;
  boxY = (height-boxheight)/2;
    
  fill(60, 100, 100, 60);
  noStroke();
  rect(boxX,boxY,boxwidth,boxheight,30);
    
  fill(90, 80, 80, 80);
  textSize(text_height);
  textAlign(CENTER);
  for(int i =0; i<3;i++)
  {
    text(shop_option[i],boxX+(boxwidth/2),boxY+i*(text_height+30)+boxheight/3);
  }
    
  mainY = boxY+boxheight/3;
  saveY = mainY + 70;
  exitY = saveY + 70;
}

public void recover(){
  for(int i = 0; i < c_pt; i++){
    p[i].rec_hp(p[i].get_max_hp());
    p[i].rec_mp(p[i].get_max_mp());
    p[i].calc_stats();
  }
}

public void boss_fight(){
  play_battle = true;
  boss_battle = true;
  
  if(play_battle){
    bgm.pause();
    
    for(int i = 0; i < 5; i++){
      boss_bgm[floor - 1].stop();
    }
    
    boss_bgm[floor - 1].loop();
    
    play_battle = false;  
  }
  
  switch(floor){
    case 1:
      enemy_count = 1;
      m[0].setMType(3);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      m[0].set_patk(1);
      m[0].set_pdef(5);
      m[0].set_mdef(5);
      m[0].set_mdef(5);
      break;
      
    case 2:
      enemy_count = 1;
      m[0].setMType(3);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(10);
      m[0].init_stats();
      m[0].set_patk(30);
      m[0].set_pdef(50);
      m[0].set_matk(80);
      m[0].set_mdef(65);
      m[0].set_max_hp(500);
      m[0].set_max_mp(800);
      break;
      
    case 3:
      enemy_count = 2;
      m[0].setMType(2);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      
      m[1].setMType(3);
      //m[1].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[1].set_level(1);
      m[1].init_stats();
      break;
      
    case 4:
      enemy_count = 3;
      m[0].setMType(1);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      
      m[1].setMType(3);
      //m[1].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[1].set_level(1);
      m[1].init_stats();
      
      m[2].setMType(1);
      //m[2].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[2].set_level(1);
      m[2].init_stats();
      break;
      
    case 5:
      enemy_count = 3;
      m[0].setMType(2);
      //m[0].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[0].set_level(1);
      m[0].init_stats();
      
      m[1].setMType(3);
      //m[1].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[1].set_level(1);
      m[1].init_stats();
      
      m[2].setMType(2);
      //m[2].set_level(r.nextInt(100) % 5 + 1 + (floor-1) * 5);
      m[2].set_level(1);
      m[2].init_stats();
      break;
  }
  
  cur = 0;
  round = 1;
  inBattle = true;
  battle_end = false;
  Units[] order;
        
  room = 90;
  order = round_order();
        
  for(int i = 0; i < order.length; i++){
    battle_list[i] = order[i];
  }
        
  if(order[cur].get_type() == 1){
    pid = order[cur].get_id();
            
    battle_mode = 0;
  }else{
    mid = order[cur].get_id();
            
    battle_mode = -1;
  }
}

public void equipment_safe(){
  int free = 0, rand;
  int[] eq = new int[3];
  
  if(box_key){
  
    //count free slots in bag
    for(int i = 0; i < bag.inv.length; i++){
        for(int j = 0; j < bag.inv[i].length; j++){
          if(bag.inv[i][j] == item_count - 1){
            free++;
          }
        }
    }
    
    //no room
    if(free < eq.length){
      
      room = 84;
      
    //get item
    }else{
      
      for(int i = 0; i < eq.length; i++){
        rand = r.nextInt(1000) % c_pt;
        
        eq[i] = (p[rand].job_code * 100) + ((r.nextInt(3) + 1) * 10) + boss_defeated;
        
        for(int j = 0; j < bag.inv.length; j++){
          for(int k = 0; k < bag.inv[j].length; k++){
            
            //remove key from bag
            if(bag.inv[j][k] == 100){
              bag.inv[j][k] = item_count - 1;
            }
            
            //put item in bag
            if(bag.inv[j][k] == item_count - 1){
              
              for(int x = 0; x < item_list.length; x++){
                if(eq[i] == item_list[x].id){
                  bag.inv[j][k] = x;
                }
              }
                
              j = bag.inv.length - 1;
              k = bag.inv[j].length - 1;
              
            }//end if
            
          }//end for k
        }//end for j
      }//end for i
      
      box_key = false;
      
      fill(60,100,100);
      rect(width/2 - 200, height / 2 - 100, 400, 200);
      fill(0, 0, 100);
      textAlign(CENTER, CENTER);
      textSize(40);
      text("Equipment received!", width/2, height/2);
    }//end else on free equipment
    
  //no key
  }else{
    fill(60,100,100);
    rect(width/2 - 200, height / 2 - 100, 400, 200);
    fill(0, 0, 100);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("You need a key!", width/2, height/2);
  }
}
/*******************************************
key system inside game
********************************************/ 
  
  boolean battle_end = false;
  int round = 1, pid = 0, mid = 0, cur = 0;
  int enemy_count, elite_count;
  int move_count = 0;
  boolean can_move = false;

/*******************************************
move function, link to keyaction
********************************************/ 

public void move() {
  
  if(frameCount % 2 == 0){
    p[0].change_map_img();
  }
    //println(move_count);
      if(up){
        if(move_count == 0){
          test_move();
          //println("test move up! " + can_move);
        }
        
        if(can_move){
          p[0].set_y(p[0].charY - sqh/5);
          
          move_count++;
          if(move_count == 5){
            move_count = 0;
            steps++;
            up = false;
          }
          
          
        }else{
          up = false;
        }
        //move_count++;
        
      }
      
      if(down){
        if(move_count == 0){
          test_move();
          //println("test move down! " + can_move);
        }
        
        if(can_move){
          p[0].set_y(p[0].charY + sqh/5);
          
          move_count++;
          if(move_count == 5){
            move_count = 0;
            steps++;
            down = false;
          }
          
        }else{
          down = false;
        }
        //move_count++;
        
      }
      
      if(right){
        if(move_count == 0){
          test_move();
          //println("test move right! " + can_move);
        }
        
        if(can_move){
          p[0].set_x(p[0].charX + sqw/5);
          move_count++;
          if(move_count == 5){
            move_count = 0;
            steps++;
            right = false;
          }
        }else{
          right = false;
        }
        //move_count++;
        
      }
      
      if(left){
        if(move_count == 0){
          test_move();
          //println("test move left! " + can_move);
        }
        
        if(can_move){
          p[0].set_x(p[0].charX - sqw/5);
          move_count++;
          if(move_count == 5){
            move_count = 0;
            steps++;
            left = false;
          }
        }else{
          left = false;
        }
        //move_count++;
        
      }
}                    //close move()
/*----------------------------------------------------------------------------------------------*/

     /* friendly_unit = 1 monster: 1-2
        friendly_unit = 2 monster: 2-3
        friendly_unit = 3 monster: 3-4
        
     
      */
public void monsterappear() {
  if(room < 80)
  {
    
      encounter   = steps + r.nextInt(20);
      
      if(encounter >= 60){
        cur = 0;
        round = 1;
        inBattle = true;
        play_battle = true;
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
          if(floor > 3){
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
        
        for(int i = 0; i < order.length; i++){
          battle_list[i] = order[i];
        }
        
        //pid = 0;
        //battle_mode = 0;
          if(order[cur].get_type() == 1){
            pid = order[cur].get_id();
            
            battle_mode = 0;
          }else{
            mid = order[cur].get_id();
            
            battle_mode = -1;
          }
    }
  }  
}                    //close monsterappear()

public void change_room(int cur_room){
  int loc_x, loc_y;
  
  loc_x = (int)p[0].charX / (int)sqw;
  loc_y = (int)p[0].charY / (int)sqh;
  
  switch(floor){
    case 1:
      if(floor_1[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_1[floor_room-1].exit[loc_y][loc_x] > floor_1.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_2/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
              if(floor_2[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_2[floor_room-1];
                new_location(j, i);
                
                i = floor_2[floor_room-1].exit.length-1;
                j = floor_2[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //move to connected room
        }else{
          floor_room = floor_1[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_1/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_1[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_1[floor_room-1].exit[i].length; j++){
              
              if(floor_1[floor_room-1].exit[i][j] == cur_room){
                map = floor_1[floor_room-1];
                new_location(j, i);
                
                i = floor_1[floor_room-1].exit.length-1;
                j = floor_1[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 2:
      if(floor_2[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_2[floor_room-1].exit[loc_y][loc_x] > floor_2.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_3/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
              if(floor_3[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_3[floor_room-1];
                new_location(j, i);
                
                i = floor_3[floor_room-1].exit.length-1;
                j = floor_3[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //go down 1 floor
        }else if(floor_2[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_2[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_1/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_1[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_1[floor_room-1].exit[i].length; j++){
              if(floor_1[floor_room-1].exit[i][j] == floor_1.length + 1){
                map = floor_1[floor_room-1];
                new_location(j, i);
                
                i = floor_1[floor_room-1].exit.length-1;
                j = floor_1[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_2[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_2/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
              
              if(floor_2[floor_room-1].exit[i][j] == cur_room){
                map = floor_2[floor_room-1];
                new_location(j, i);
                
                i = floor_2[floor_room-1].exit.length-1;
                j = floor_2[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 3:
      if(floor_3[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_3[floor_room-1].exit[loc_y][loc_x] > floor_3.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_4/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
              if(floor_4[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_4[floor_room-1];
                new_location(j, i);
                
                i = floor_4[floor_room-1].exit.length-1;
                j = floor_4[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //go down 1 floor
        }else if(floor_3[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_3[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_2/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_2[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_2[floor_room-1].exit[i].length; j++){
              if(floor_2[floor_room-1].exit[i][j] == floor_2.length + 1){
                map = floor_2[floor_room-1];
                new_location(j, i);
                
                i = floor_2[floor_room-1].exit.length-1;
                j = floor_2[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_3[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_3/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
              
              if(floor_3[floor_room-1].exit[i][j] == cur_room){
                map = floor_3[floor_room-1];
                new_location(j, i);
                
                i = floor_3[floor_room-1].exit.length-1;
                j = floor_3[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 4:
      if(floor_4[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //move to next floor
        if(floor_4[floor_room-1].exit[loc_y][loc_x] > floor_4.length){
          battle_bg = loadImage("src/backgroundimage/battle_room_5/battle_room_1.png");
          floor++;
          floor_room = 1;
          
          for(int i = 0; i < floor_5[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_5[floor_room-1].exit[i].length; j++){
              if(floor_5[floor_room-1].exit[i][j] == (-1 * cur_room)){
                map = floor_5[floor_room-1];
                new_location(j, i);
                
                i = floor_5[floor_room-1].exit.length-1;
                j = floor_5[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        
        //go down 1 floor
        }else if(floor_4[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_4[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_3/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_3[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_3[floor_room-1].exit[i].length; j++){
              if(floor_3[floor_room-1].exit[i][j] == floor_3.length + 1){
                map = floor_3[floor_room-1];
                new_location(j, i);
                
                i = floor_3[floor_room-1].exit.length-1;
                j = floor_3[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_4[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_4/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
              
              if(floor_4[floor_room-1].exit[i][j] == cur_room){
                map = floor_4[floor_room-1];
                new_location(j, i);
                
                i = floor_4[floor_room-1].exit.length-1;
                j = floor_4[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
      
    case 5:
      if(floor_5[floor_room-1].exit[loc_y][loc_x] != 0){
        
        //go down 1 floor
        if(floor_5[floor_room-1].exit[loc_y][loc_x] < 0){
          floor--;
          floor_room = -1 * (floor_5[floor_room-1].exit[loc_y][loc_x]);
          battle_bg = loadImage("src/backgroundimage/battle_room_4/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_4[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_4[floor_room-1].exit[i].length; j++){
              if(floor_4[floor_room-1].exit[i][j] == floor_4.length + 1){
                map = floor_4[floor_room-1];
                new_location(j, i);
                
                i = floor_4[floor_room-1].exit.length-1;
                j = floor_4[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
          
        //move to connected room
        }else{
          floor_room = floor_5[floor_room-1].exit[loc_y][loc_x];
          battle_bg = loadImage("src/backgroundimage/battle_room_5/battle_room_" + floor_room + ".png");
          
          for(int i = 0; i < floor_5[floor_room-1].exit.length; i++){
            for(int j = 0; j < floor_5[floor_room-1].exit[i].length; j++){
              
              if(floor_5[floor_room-1].exit[i][j] == cur_room){
                map = floor_5[floor_room-1];
                new_location(j, i);
                
                i = floor_5[floor_room-1].exit.length-1;
                j = floor_5[floor_room-1].exit[i].length-1;
              }//end if
            }
          }//end double for
        }
      }
      break;
  }
}

public void new_location(int x, int y){
  //println("floor: " + floor + " room: " + floor_room);
  move_count = 0;
  switch(p[0].dir){
    //up
    case 0:
      p[0].charX = sqw * x;
      p[0].charY = sqh * (y-1);
      up = false;
      break;
                    
    //right
    case 1:
      p[0].charX = sqw * (x+1);
      p[0].charY = sqh * y;
      right = false;
      break;
                    
    //down
    case 2:
      p[0].charX = sqw * x;
      p[0].charY = sqh * (y+1);
      down = false;
      break;
                    
   //left
   case 3:
     p[0].charX = sqw * (x-1);
     p[0].charY = sqh * y;
     left = false;
     break;
  }//end switch
}

public void test_move(){
  int cur_x = (int)p[0].charX/sqw, cur_y = (int)p[0].charY/sqh;
  //println("testing!");
  switch(p[0].dir){
    //up
    case 0:
      //println("WALL up: " + map.wall[cur_y-1][cur_x]);
      can_move = !map.wall[cur_y-1][cur_x] && !map.npc[cur_y-1][cur_x];
      break;
                    
    //right
    case 1:
      //println("WALL right: " + map.wall[cur_y-1][cur_x]);
      can_move = !map.wall[cur_y][cur_x+1] && !map.npc[cur_y][cur_x+1];
      break;
                    
    //down
    case 2:
      //println("WALL down: " + map.wall[cur_y-1][cur_x]);
      can_move = !map.wall[cur_y+1][cur_x] && !map.npc[cur_y+1][cur_x];
      break;
                    
   //left
   case 3:
     //println("WALL left: " + map.wall[cur_y-1][cur_x]);
     can_move = !map.wall[cur_y][cur_x-1] && !map.npc[cur_y][cur_x-1];
     break;
     
   default:
     println("Player Direction Error!");
     can_move = false;
     break;
  }
}

public void npc_on_map(){
      //companions
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
      
      //Boss
      if(floor == 1 && floor_room == 2){
        if(boss_defeated < 1){
          image(boss_img[floor - 1], 11 * sqw, 10 * sqh, sqw, sqh);
        }
      }else if(floor == 2 && floor_room == 4){
        if(boss_defeated < 2){
          image(boss_img[floor - 1], 19.5f * sqw, 5.75f * sqh, sqw * 1.5f, sqh * 1.5f);
        }
      }else if(floor == 3 && floor_room == 3){
        if(boss_defeated < 3){
          image(boss_img[floor - 1], 15 * sqw, 7 * sqh, sqw * 2, sqh * 2);
        }
      }else if(floor == 4 && floor_room == 7){
        if(boss_defeated < 4){
          image(boss_img[floor - 1], 20 * sqw, 9 * sqh, sqw, sqh);
        }
      }else if(floor == 5 && floor_room == 6){
        if(boss_defeated < 5){
          image(boss_img[floor - 1], 20 * sqw, 6 * sqh, sqw * 2, sqh * 2);
        }
      }
      
      //princess
      if(floor == 5 && floor_room == 7){
        image(princess, 18.5f * sqw, 6.5f * sqh, sqw * 1.3f, sqh * 1.5f);
      }
      
      //equipment safe
      if(floor == 2 && floor_room == 6){
        image(safe, 10 * sqw, 13 * sqh, sqw, sqh);
      }
      
      if(floor == 3 && floor_room == 3){
        image(item_list[98].img, 22 * sqw, 6 * sqh, sqw, sqh);
      }
      
      if(floor == 4 && floor_room == 8){
        image(safe, 10 * sqw, 13 * sqh, sqw, sqh);
      }
      
      if(floor == 5 && floor_room == 4){
        image(safe, 10 * sqw, 12 * sqh, sqw, sqh);
      }
}

public void remove_cell_key(){
  for(int i = 0; i < bag.inv.length; i++){
    for(int j = 0; j < bag.inv[i].length; j++){
      if(bag.inv[i][j] == 99){
        bag.inv[i][j] = item_count - 1;
      }
    }
  }
  
  
  cell_key = false;
}
public void img_Set(){
    
    battle_bg = loadImage("src/backgroundimage/battle_room_1/battle_room_1.png");
    dead = loadImage("src/dead.png");
    
    princess = loadImage("src/npc/princess.png");
    safe = loadImage("src/safe.png");
    
    npc[0] = loadImage("src/npc/knight.png");
    npc[1] = loadImage("src/npc/paladin.png");
    npc[2] = loadImage("src/npc/ranger.png");
    npc[3] = loadImage("src/npc/assassin.png");
    npc[4] = loadImage("src/npc/mage.png");
    npc[5] = loadImage("src/npc/priest.png");
    
    boss_img[0] = loadImage("src/monster/on_map/floor_1_2.png");
    boss_img[1] = loadImage("src/monster/on_map/floor_2_2.png");
    boss_img[2] = loadImage("src/monster/on_map/floor_3_2.png");
    boss_img[3] = loadImage("src/monster/on_map/floor_4_2.png");
    boss_img[4] = loadImage("src/monster/on_map/final/boss_2.png");
    
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

}
/*******************************************
set job, 6 in total
********************************************/ 
int p_class = 0;
int stats_count = 5;

public class Jobs{
  protected float patkAmp, pdefAmp, matkAmp, mdefAmp, spdAmp, hpAmp, mpAmp;
  protected float[] base_stats = new float[stats_count];
  protected float[] stats_inc = new float[stats_count];
  
  public Jobs(){
    patkAmp = 1;
    pdefAmp = 1;
    matkAmp = 1;
    mdefAmp = 1;
    spdAmp = 1;
    hpAmp = 1;
    mpAmp = 1;
  }
  
  public float getPatkAmp(){
    return this.patkAmp;
  }
  public float getPdefAmp(){
    return this.pdefAmp;
  }
  public float getMatkAmp(){
    return this.matkAmp;
  }
  public float getMdefAmp(){
    return this.mdefAmp;
  }
  public float getSpdAmp(){
    return this.spdAmp;
  }
  public float getHpAmp(){
    return this.hpAmp;
  }
  public float getMpAmp(){
    return this.mpAmp;
  }
  
  public float[] get_base_stats(){
    return this.base_stats;
  }
  
  public float[] get_stats_inc(){
    return this.stats_inc;
  }
}


/*******************************************
class job
********************************************/ 

class Job{
  public String name;
  public float[] amplifier = new float[7];
  public int code = 0;
  public float[] stats = new float[stats_count];
  public float[] stats_inc = new float[stats_count];

  public Job(){
  }
  
  public Job(int x){
    this.code = x;
    
    switch(code){
      case 1:
        this.name = "Knight";
        Knight knight = new Knight();
        init_Knight(knight);

          this.stats = knight.get_base_stats();
          this.stats_inc = knight.get_stats_inc();

        break;
        
      case 2:
        this.name = "Paladin";
        Paladin paladin = new Paladin();
        init_Paladin(paladin);

          this.stats = paladin.get_base_stats();
          this.stats_inc = paladin.get_stats_inc();
        break;
      
      case 3:
        this.name = "Ranger";
        Ranger ranger = new Ranger();
        init_Ranger(ranger);

          this.stats = ranger.get_base_stats();
          this.stats_inc = ranger.get_stats_inc();
        break;
        
      case 4:
        this.name = "Assassin";
        Assassin assassin = new Assassin();
        init_Assassin(assassin);

          this.stats = assassin.get_base_stats();
          this.stats_inc = assassin.get_stats_inc();
        break;
        
      case 5:
        this.name = "Mage";
        Mage mage = new Mage();
        init_Mage(mage);

          this.stats = mage.get_base_stats();
          this.stats_inc = mage.get_stats_inc();
        break;
        
      case 6:
        this.name = "Priest";
        Priest priest = new Priest();
        init_Priest(priest);

          this.stats = priest.get_base_stats();
          this.stats_inc = priest.get_stats_inc();
        break;
    }
  }
  
  public void init_Knight(Knight k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }

  public void init_Priest(Priest k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Mage(Mage k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Paladin(Paladin k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Ranger(Ranger k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Assassin(Assassin k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
}


public class Knight extends Jobs{
  //Skill skill = new Skill(1);
  
  public Knight(){
    base_stats[0] = 10.0f;
    base_stats[1] = 15.0f;
    base_stats[2] = 5.0f;
    base_stats[3] = 9.0f;
    base_stats[4] = 7.0f;
    
    stats_inc[0] = 2.2f;
    stats_inc[1] = 3.6f;
    stats_inc[2] = 0.8f;
    stats_inc[3] = 2.0f;
    stats_inc[4] = 1.8f;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Paladin extends Jobs{
  //Skill skill = new Skill(4);
  
  public Paladin(){
    base_stats[0] = 8.0f;
    base_stats[1] = 10.0f;
    base_stats[2] = 8.0f;
    base_stats[3] = 12.0f;
    base_stats[4] = 6.0f;
    
    stats_inc[0] = 1.8f;
    stats_inc[1] = 3.0f;
    stats_inc[2] = 1.8f;
    stats_inc[3] = 3.0f;
    stats_inc[4] = 1.5f;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Ranger extends Jobs{
  //Skill skill = new Skill(5);
  
  public Ranger(){
    base_stats[0] = 11.0f;
    base_stats[1] = 7.0f;
    base_stats[2] = 11.0f;
    base_stats[3] = 6.0f;
    base_stats[4] = 12.0f;
    
    stats_inc[0] = 2.8f;
    stats_inc[1] = 1.8f;
    stats_inc[2] = 2.8f;
    stats_inc[3] = 1.2f;
    stats_inc[4] = 3.1f;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Assassin extends Jobs{
  //Skill skill = new Skill(5);
  
  public Assassin(){
    base_stats[0] = 13.0f;
    base_stats[1] = 7.5f;
    base_stats[2] = 3.0f;
    base_stats[3] = 8.0f;
    base_stats[4] = 15.0f;
    
    stats_inc[0] = 3.0f;
    stats_inc[1] = 2.0f;
    stats_inc[2] = 0.4f;
    stats_inc[3] = 1.5f;
    stats_inc[4] = 3.6f;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

public class Mage extends Jobs{
  //Skill skill = new Skill(3);
  
  public Mage(){
    base_stats[0] = 4.0f;
    base_stats[1] = 6.0f;
    base_stats[2] = 18.0f;
    base_stats[3] = 10.0f;
    base_stats[4] = 6.0f;
    
    stats_inc[0] = 1.0f;
    stats_inc[1] = 2.3f;
    stats_inc[2] = 3.5f;
    stats_inc[3] = 2.5f;
    stats_inc[4] = 1.2f;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Priest extends Jobs{
  //Skill skill = new Skill(2);
  
  public Priest(){
    base_stats[0] = 6.0f;
    base_stats[1] = 9.0f;
    base_stats[2] = 11.0f;
    base_stats[3] = 15.0f;
    base_stats[4] = 7.0f;
    
    stats_inc[0] = 1.0f;
    stats_inc[1] = 2.7f;
    stats_inc[2] = 2.0f;
    stats_inc[3] = 3.6f;
    stats_inc[4] = 1.8f;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}
/*******************************************************************
function about keyboard, set variable first, all action base on room 
*********************************************************************/

boolean opt = false,inhelp = true;
boolean up = false, down = false, left = false, right = false;
int temp_room;

/*******************************************
quick key and movement 
********************************************/ 

public void keyPressed(){
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
      
      if(room == 2 || room == 80 || room == 81){
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
        }  
      }
      
      if(room > 1 && room < 80){
        switch(keyCode){
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
        }
      }
    
  }
 
/*******************************************************************
function about mouse, set variable first, all action base on room 
*********************************************************************/
int bag_selected_x, bag_selected_y, selected_item_code;
float ogx, ogy;
int bag_x, bag_y, temp_item_code;
float skill_box_width, skill_box_height;
boolean move_item = false, select_item = false, select_target = false, usable = true;
float x, y, distance;
int command;
int empty_slots = 0;
 
 public void mousePressed(){
    
    x = mouseX;
    y = mouseY;
    
    
    switch (room)
    {
        case 0:  //  main menu
          
        
                if( (x >= side_margin - 100 && x <= side_margin+100) && (y >= height_margin-15 && y <= height_margin+15) ){
                  newGame();
                }
                
                if( (x >= side_margin - 100 && x <= side_margin+100) && (y >= height_margin+135 && y <= height_margin+165) ){
                  load();
                }
                
                if( (x >= side_margin - 50 && x <= side_margin+50) && (y >= height_margin+285 && y <= height_margin+315) ){
                  exit();
                }
                    
        break;

//---------------------------------------------------------------------------------------        

        case 1:  //  drawroom
            for(int i = 0; i < total_jobs; i++){
              if( (mouseX >= boxX && mouseX <= boxX + boxwidth) && (mouseY >= i*60+boxY+40-12.5f && mouseY < i*60+boxY+40+12.5f) ){
                println("Reading job" + (i+1) + " status");
                  p_class = i+1;
                  room = 3;
              }
            }
                
              if(p_class != 0){
                p[0] = new Player(p_class);
                p[0].set_img("player_2",1);
                p[0].name = "Adam";
                p[0].set_id(0);
                
                p[0].battle_img = loadImage("src/player/battle/Player.png");
                p[0].icon = loadImage("src/player/icon/Player.png");
                p[0].avatar = loadImage("src/player/avatar/player.png");
                p[0].set_loc(800,450);
              }   
              
                //p[1] = new Player(1);
                //p[1].set_img(p[1].job.name,1);
                //p[1].set_id(1);
                //p[1].name = "Tester 1";
                
                //p[2] = new Player(1);
                //p[2].set_img(p[2].job.name,1);
                //p[2].set_id(2);
                //p[2].name = "Tester 2";
                
                //p[3] = new Player(5);
                //p[3].set_img(p[3].job.name,1);
                //p[3].set_id(3);
                //p[3].name = "Tester 3";
                //c_pt = 3;
        
        break;
        
        case 4:
          room = 2;
          break;
          
        case 8:
          room = 2;
          break;
        
 //---------------------------------------------------------------------------------------      
 /*******************************************
 */
       case 80:  //  item selct drop-down menu
         bag_select(1);
         spend_attribute_points();   
         break;
       
       
       case 81:
           if((x >= bagoptX && x<= bagoptX+bag.square_width*3) && (y >= bagoptY && y <= bagoptY+bag.square_height)){
             //println("x: " + bag_x + " y: " + bag_y);
             //println("used " + (bag_y * 5 + bag_x + 1));
             item_list[bag.inv[bag_y][bag_x]].use(pid);
             room = 80;
           
           }
           
           else if((x >= bagoptX && x<= bagoptX+bag.square_width*3) && (y > bagoptY + bag.square_height&& y <= bagoptY+bag.square_height * 2)){
             //println("droped");
             bag.inv[bag_y][bag_x] = item_count - 1;
           }
           
           else{         
             room = 80;
           }
         
       
         break;
       
       //bag full for shop
       case 84:
         room = 88;
         break;
       
       //confirm purchase
       case 86:
         in_shop = false;
         shop_set = false;
         room = 2;
         break;
       
       //confirm save
       case 87:
         in_shop = false;
         room = 2;
         break;
       
       //shop UI
       case 88:
          shop.dis_y = bag.vertical_margin + bag.vs;
          for(int i = 0; i < shop.sale_count; i++){
            if(i % 5 == 0){
              shop.dis_y += bag.vs + bag.square_height;
            }
            
            if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
              && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
              && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
                
                if(shop.sell[i] != item_list[item_count - 1]){
                  
                  for(int j = 0; j < shop.cart.length; j++){
                    if(shop.cart[j] == item_list[item_count - 1]){
                      shop.cart[j] = shop.sell[i];
                      shop.sell[i] = item_list[item_count - 1];
                    }
                  }
                }
                
            }
          }//end shop for
                  
          shop.dis_y = bag.UI_height / 2 - bag.vs;
          for(int i = 0; i < shop.sale_count; i++){
            if(i % 5 == 0){
              shop.dis_y += bag.vs + bag.square_height;
            }
            
            if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
              && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
              && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
                
                if(shop.cart[i] != item_list[item_count - 1]){
                  for(int j = 0; j < shop.sell.length; j++){
                    if(shop.sell[j] == item_list[item_count - 1]){
                      shop.sell[j] = shop.cart[i];
                      shop.cart[i] = item_list[item_count - 1];
                    }
                  }
                }
                
            }
                    
          }//end cart for
          
          //confirmation box
          if(x >= (bag.horizontal_margin + bag.square_width) && x <= (bag.horizontal_margin + bag.square_width) +  bag.square_width * 2
            && y >= (height - bag.vertical_margin - bag.square_height) && y <= (height - bag.vertical_margin - bag.square_height) + bag.square_height / 2){
              if(p[0].get_gold() >= shop.gold_req){
                empty_slots = 0;
                
                for(int i = 0; i < bag.inv.length; i++){
                  for(int j = 0; j < bag.inv[i].length; j++){
                    if(bag.inv[i][j] == item_count - 1){
                      empty_slots++;
                    }
                  }
                }
                
                if(empty_slots >= shop.buy){
                  
                  for(int i = 0; i < shop.cart.length; i++){
                    
                    for(int j = 0; j < bag.inv.length; j++){
                      
                      for(int k = 0; k < bag.inv[j].length; k++){
                        
                        if(shop.cart[i] != item_list[item_count - 1]){
                          if(bag.inv[j][k] == item_count - 1){
                            
                            for(int x = 0; x < item_list.length; x++){
                              
                              if(item_list[x].id == shop.cart[i].id){
                                bag.inv[j][k] = x;
                                j = bag.inv.length - 1;
                                k = bag.inv[j].length - 1;
                              }
                              
                            }//end for x
                            
                          }//end if
                        }//end if cart slot is empty
                        
                      }//end for k
                    }//end for j
                  }//end for i
                  
                  room = 86;
                  
                }else{
                  println("buy: " + shop.buy + " free: " + empty_slots);
                  room = 84;
                  
                }
                
              }
            }
          
          //cancel and quit box
          if(x >= (bag.horizontal_margin + bag.UI_width/2 + bag.square_width) && x <= (bag.horizontal_margin + bag.UI_width/2 + bag.square_width) +  bag.square_width * 2
            && y >= (height - bag.vertical_margin - bag.square_height) && y <= (height - bag.vertical_margin - bag.square_height) + bag.square_height / 2){
              in_shop = false;
              shop_set = false;
              room = 2;
            }
         break;
         
       //option menu for shop and save  
       case 89:
         if((x >= boxX && x <= boxX+boxwidth)&&(y >= mainY-text_height && y<= mainY+text_height)){ 
           
           //to shop UI
           in_shop = true;
           room = 88;   
           
         }
             
         if((x >= boxX && x<=boxX+boxwidth) && (y >= saveY-text_height && y<= saveY+text_height)){
                              
           saveData();
           //save confirmation
           in_shop = false;
           room = 87;
           
         }
             
         if((x >= boxX && x <= boxX+boxwidth) && (y >= exitY-text_height && y<= exitY+text_height)){
           
           //back to game
           in_shop = false;
           room = 2;
                        
         }
         break;
       
       case 90:
         switch(battle_mode){
           //player turn start
           case 0:
             battle_commands();
           break;
           
           //select attack target
           case 1:
             select_enemy_target();
             break;
             
           //use skill
           case 2:
             battle_commands();
             skill_commands();
             break;
             
           //use item
           case 3:
             bag_select(2);

             break;
             
           //select ally target
           case 4:
             select_ally_target();
             break;
             
           //monster turn
           case -1:
             println("Monster Turn!");
             break;
             
           case 10:
             //display_damage();
             break;
             
         }
        
         break;
         
       //not enough MP
       case 94:
       
         room = 90;
         skill = false;
         skill_used = false;
         battle_mode = 0;
         
         break;
       
       case 98:
         //accept into party
         if(new_companion != 0){
           if(mouseX >= width*0.2f && mouseX <= width*0.2f + 100 && mouseY >= height/ 2 && mouseY <= height/ 2 + 100){
             println("yes");
             p[c_pt] = new Player(new_companion);
             c_pt++;
             npc_in_cell[new_companion - 1] = false;
             switch(new_companion){
                  case 1:
                    floor_1[2].del_npc(13, 8);
                    p[c_pt-1].name = "Knight";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;
                  
                  case 2:
                    floor_1[2].del_npc(18, 8);
                    p[c_pt-1].name = "Paladin";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;
                      
                  case 3:
                    floor_1[2].del_npc(23, 8);
                    p[c_pt-1].name = "Ranger";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;
                      
                  case 4:
                    floor_1[2].del_npc(13, 13);
                    p[c_pt-1].name = "Assassin";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;  
                  
                  case 5:
                    floor_1[2].del_npc(18, 13);
                    p[c_pt-1].name = "Mage";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;  
                    
                  case 6:
                    floor_1[2].del_npc(23, 13);
                    p[c_pt-1].name = "Priest";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;  
             }
                      
           }
            
           if(mouseX >= width*0.8f && mouseX <= width*0.8f + 100 && mouseY >= height/ 2 && mouseY <= height/ 2 + 100){
             println("no");
             new_companion = 0;
           }
           
           room = 2;
         }else{
           room = 2;
         }
         
         break;
       
       case 99:  //  option menu
            
             if((x >= boxX && x <= boxX+boxwidth)&&(y >= mainY-text_height && y<= mainY+text_height)){ 
               opt = false;
               room = 0;                                         
             }
             
             if((x >= boxX && x<=boxX+boxwidth) && (y >= saveY-text_height && y<= saveY+text_height)){
                              
               load();
             
             }
             
             if((x >= boxX && x <= boxX+boxwidth) && (y >= exitY-text_height && y<= exitY+text_height)){
               
               exit();
                        
             }
         
         break;
         
         
         case 900:
         case 999:
           exit();
           break;
        
    } //close switch
    
  }  //close mousePressed()
  
  
 // sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
 // sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
 
 //bag_x = (int) ( (ogx - ((width + bag.UI_dis)/2) - bag.hs) / (bag.hs + bag.square_width));
 //bag_y = (int) ( (ogy - bag.vertical_margin - bag.vs) / (bag.vs + bag.square_height));
  
public void mouseDragged(){
  if(select_item && room == 80){
    move_item = true;
    
    image(item_list[temp_item_code].img, mouseX - (bag.square_width/2), mouseY - (bag.square_height/2), bag.square_width, bag.square_height);
    //room = 80;
  }
}
  
public void mouseReleased(){
  float sqx, sqy;
  
  switch(room){
    
    case 80:
    if(move_item){
            
          for(int i = 0; i < bag.row; i++){
            for(int j = 0; j < bag.col; j++)
            {
              sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
              sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
              
               if( (mouseX >= sqx && mouseX <= sqx + bag.square_width)  && (mouseY >=  sqy && mouseY <= sqy + bag.square_height) )
               {
                 if(i == bag_y && j == bag_x){
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   if(bag.inv[i][j] != item_count - 1){
                     bagoptX = mouseX+bag.hs;
                     bagoptY = mouseY;
                   }
                 }else{
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   bag.inv[i][j] ^= bag.inv[bag_y][bag_x];
                   bag.inv[bag_y][bag_x] ^= bag.inv[i][j];
                   bag.inv[i][j] ^= bag.inv[bag_y][bag_x];
                   
                 }
                 
                 move_item = false;
                 select_item = false;
                 
               }
               else{
                 if(move_item){
                   bag.inv[bag_y][bag_x] = temp_item_code;
                 }
               }
               move_item = false;
               select_item = false;
            }
          }
      }else{
        if(select_item){
        for(int i = 0; i < bag.row; i++){
            for(int j = 0; j < bag.col; j++)
          {
            sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
            sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
            
             if(mouseX >= sqx && mouseX <= sqx + bag.square_width  && mouseY >=  sqy && mouseY <= sqy + bag.square_height)
             {
               if(select_item){
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   select_item = false;
                 }
               if(bag.inv[i][j] != item_count -1){
                 
                 bagoptX = mouseX+bag.hs;
                 bagoptY = mouseY;
                 room = 81;
               }
             }
          }
        }
    }
  }
  break;
  }
}

public void battle_commands(){
  //attack
  distance = (float) ( Math.sqrt(( (x - command_x) * (x - command_x) + (y - (command_y - command_radius)) * (y - (command_y - command_radius)) ) ) );
             if(distance <= command_radius / 2.0f){
               //attack(0,0,0);
               //println("pa: " + p[0].get_patk() + " md: " + m[0].get_pdef());
               //println("dmg: " + (p[0].get_patk() -  m[0].get_pdef()));
               //println("attack! " + m[0].get_cur_hp() + " hp down: " + m[0].get_hp_dec());
               battle_mode = 1;
               command = 6;
               //if(m[0].get_cur_hp() <= 0){
               //  println("dead!");
               //}
             }
             
             //skill
             distance = (float) ( Math.sqrt(( (x - (command_x + command_radius)) * (x - (command_x + command_radius)) + (y - command_y) * (y - command_y) ) ) );
             if(distance <= command_radius / 2.0f){
               //println("skill!");
               battle_mode = 2;
             }
             
             //item
             distance = (float) ( Math.sqrt(( (x - (command_x - command_radius)) * (x - (command_x - command_radius)) + (y - command_y) * (y - command_y) ) ) );
             if(distance <= command_radius / 2.0f){
               //println("item!");
               battle_mode = 3;
             }
             
             //flee
             distance = (float) ( Math.sqrt(( (x - command_x) * (x - command_x) + (y - (command_y + command_radius)) * (y - (command_y + command_radius)) ) ) );
             if(distance <= command_radius / 2.0f){
               escape();
             }
}

public void skill_commands(){
  for(int i = 0; i < p[battle_list[cur].get_id()].skills.skill_count; i++){
                if(x >= command_x + command_radius * 1.5f + battle_UI_margin && x <= command_x + command_radius * 1.5f + battle_UI_margin + skill_box_width 
                  && y >= (command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5f))) && y <= (command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5f))) + skill_box_height){
                    //println("use skill " + (i+1));
                    command = i;
                    
                    if(p[battle_list[cur].get_id()].skills.skill[i].type == 2){
                      battle_mode = 1;
                    }else{
                      battle_mode = 4;
                    }
                }
              }
   
  if(battle_mode != 1 && battle_mode != 4){
    battle_mode = 0;
  }
}

public void bag_select(int bag_mode){
   select_item = false;
   usable = true;
   
   switch(bag_mode){
     case 1:
          ogx = x;
          ogy = y;
          float sqx, sqy;
          
          for(int i = 0; i < bag.row; i++){
            for(int j = 0; j < bag.col; j++)
            {
              sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
              sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
              
               if(x >= sqx && x <= sqx + bag.square_width  && y >=  sqy && y <= sqy + bag.square_height)
               {
                 if(bag.inv[i][j] < item_count - 4){
                   bag_x = j;
                   bag_y = i;
                   temp_item_code = bag.inv[i][j];
                   bag.inv[i][j] = item_count - 1;
                   select_item = true;
                 }
               }
            }
          }
        
        //select player equipment
        for(int n=1 ; n <=p[0].Wpsq_num ; n++ ){
          sqx = p[0].horizontal_margin + p[0].sq_distance + n*p[0].Wp_distance + (n-1)*p[0].Wpsq_sl;
          sqy = p[0].vertical_margin + p[0].Avatarsq_sl + 2*p[0].sq_distance + 3*p[0].Wpsq_sl;
          
          if(x >= sqx && x <= sqx + p[0].Wpsq_sl && y >= sqy && y <= sqy + p[0].Wpsq_sl){
            
            if(p[pid].equipment[n-1] != item_count - 1){
              for(int i = 0; i < bag.row; i++){
                for(int j = 0; j < bag.col; j++){
                  if(bag.inv[i][j] == item_count -1){
                    item_list[bag.inv[i][j]].update_player_bonus(pid, p[pid].equipment[n-1], bag.inv[i][j]);
                    bag.inv[i][j] = p[pid].equipment[n-1];
                    p[pid].equipment[n-1] = item_count - 1;
                  }
                }
              }
            }
            
          }
        }
        
       //change player stats on display
       for(int n = 1; n <= p[0].Avatarsq_num; n++){
         if(mouseX >= (p[0].horizontal_margin + n*p[0].sq_distance + (n-1)*p[0].Avatarsq_sl)
           && mouseX <= (p[0].horizontal_margin + n*p[0].sq_distance + (n-1)*p[0].Avatarsq_sl) + p[0].Avatarsq_sl
           && mouseY >= (p[0].vertical_margin + p[0].strip_distance) && mouseY < (p[0].vertical_margin + p[0].strip_distance) + p[0].Avatarsq_sl){
             if(n-1 < c_pt){
               pid = n-1;
             }
         }
        } 
       break;
     case 2:
               for(int i = 0; i < bag.row; i++){
                for(int j = 0; j < bag.col; j++)
                {
                  if(i > bag.row / 2 - ((bag.row + 1) % 2)){
                    if(x >= ((j+1)*bag.hs + (j*bag.square_width) + width/2) && x <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 + bag.square_width)
                      && y >= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin 
                      && y <= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin + bag.square_height){
                        if(bag.inv[i][j] != item_count - 1){
                          if(item_list[bag.inv[i][j]].id < 40){
                            //println("usable");
                            bag_selected_x = j;
                            bag_selected_y = i;
                            selected_item_code = bag.inv[i][j];
                            
                            usable = true;
                            select_item = true;
                            battle_mode = 4;
                            command = 7;
                          }else{
                            select_item = true;
                            usable = false;
                            battle_mode = 3;
                          }
                          //println("right side item: " + bag.inv[i][j]);
                        }
                    }
                  }else{
                    if(x >= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width) && x <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width + bag.square_width) 
                      && y >= ( ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin ) && y <= ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin + bag.square_height){
                        if(bag.inv[i][j] != item_count - 1){
                          if(item_list[bag.inv[i][j]].id < 40){
                            //println("usable");
                            bag_selected_x = j;
                            bag_selected_y = i;
                            selected_item_code = bag.inv[i][j];
                            
                            usable = true;
                            select_item = true;
                            battle_mode = 4;
                            command = 7;
                          }else{
                            select_item = true;
                            usable = false;
                            battle_mode = 3;
                          }
                          //println("left side item: " + bag.inv[i][j]);
                        }
                      }
                  }
                  
                }    //for loop(j)
              }    //for loop (i)
              
              if(!select_item){
                battle_mode = 0;
              }
       break;
   }
}

public void select_enemy_target(){
  select_target = false;
  float x_dis, y_dis;
  enemy_x = enemy_start_x + enemy_width * m[mid].get_mod();
        enemy_y = enemy_start_y;
        target_diameter = (float)Math.sqrt( 2*(Math.pow((double)enemy_width,2.0f)) );
        strokeWeight(3);
        stroke(0,100,100);
        fill(0,100,100,0);
        
        for(int i = 0; i < enemy_count; i++){
          if(i > 0){
            if(i % 2 == 0){
              enemy_x += enemy_width * m[i-1].get_mod();
            }else{
              enemy_x -= enemy_width * m[i-1].get_mod();
            }
          }
          x_dis = x - (enemy_x + enemy_width/2.0f * m[i].get_mod());
          y_dis = y - (enemy_y + enemy_height/2.0f * m[i].get_mod());
          
            distance = (float)Math.sqrt(x_dis * x_dis + y_dis * y_dis);
            if(distance <= target_diameter * m[i].get_mod() / 2){
              if(m[i].is_alive()){
                if(command == 6){
                  select_target = true;
                  attack(pid, i, 0);
                }else{
                  select_target = true;
                  skill(pid, i, 0, command);
                }
              }
            }
          
          
          enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0f;
        }
        
  if(!select_target){
    battle_mode = 0;
  }else{
    battle_mode = 10;
  }
}

/********************************************
*  Select ALLY
********************************************/
public void select_ally_target(){
  select_target = false;
  for(int i = 0; i < c_pt; i++){
    cx = c_width*i + (i+1)*battle_UI_margin;
    if(x >= cx && x <= cx + c_width && y >= cy & y <= cy + c_height){
      
      //Use Item
      if(command == 7){
        if(item_list[selected_item_code].id != 39){
          if(p[i].is_alive()){
            p[i].rec_hp(item_list[selected_item_code].get_rec_hp());
            p[i].rec_mp(item_list[selected_item_code].get_rec_mp());
            p[i].calc_stats();
            
            select_item = false;
            
            bag.inv[bag_selected_y][bag_selected_x] = item_count - 1;
            
            select_target = true;
            battle_mode = 0;
          }else{
            select_item = false;
            select_target = false;
            battle_mode = 0;
          }
          
        //use revive
        }else{
          if(!p[i].is_alive()){
            p[i].ress();
            p[i].rec_hp(item_list[selected_item_code].get_rec_hp());
            p[i].calc_stats();
            
            select_item = false;
            
            bag.inv[bag_selected_y][bag_selected_x] = item_count - 1;
            
            select_target = true;
            battle_mode = 0;
          }else{
            select_item = false;
            select_target = false;
            battle_mode = 0;
          }
        }
      
      //use skill
      }else{
        
        switch(battle_list[cur].skills.skill[command].type){
            //use on self only
            case 0:
              if(p[i] == battle_list[cur]){
                select_target = true;
                skill(battle_list[cur].get_id(), i, 0, command);
              }else{
                battle_mode = 0;
                select_target = false;
              }
              break;
            
            //use on ally
            case 1:
              //priest revive
              if(p[battle_list[cur].get_id()].job_code == 6 && command == 5){
                if(!p[i].is_alive()){
                    select_target = true;
                    skill(battle_list[cur].get_id(), i, 0, command);
                }
                
              //other skills
              }else{
                if(p[i].is_alive()){
                    select_target = true;
                    skill(battle_list[cur].get_id(), i, 0, command);
                }  
              }
              break;
        }
      }
    }
  }
  
  if(!select_target){
    select_item = false;
    battle_mode = 0;
  }else{
    battle_mode = 10;
  }
}

/****************************************
*  use AP
****************************************/
public void spend_attribute_points(){
  if(p[pid].AP > 0){
    for(int i = 0; i < p[0].Strip_num; i++){
      if(x >= (p[0].horizontal_margin + p[0].sq_distance + p[0].Strip_width + p[0].sq_distance)
        && x <= (p[0].horizontal_margin + p[0].sq_distance + p[0].Strip_width + p[0].sq_distance) + p[0].addsq_sl
        && y >= (p[0].vertical_margin + p[0].Avatarsq_sl + 13*p[0].strip_distance + i*p[0].sq_distance)
        && y <= (p[0].vertical_margin + p[0].Avatarsq_sl + 13*p[0].strip_distance + i*p[0].sq_distance) + p[0].addsq_sl){
          switch(i){
            case 0:
              //println("inc str");
              p[pid].set_flat_str(p[pid].get_flat_str() + 1);
              p[pid].AP--;
              break;
            case 1:
            //println("inc con");
              p[pid].set_flat_con(p[pid].get_flat_con() + 1);
              p[pid].AP--;
              break;
            case 2:
            //println("inc int");
              p[pid].set_flat_intel(p[pid].get_flat_intel() + 1);
              p[pid].AP--;
              break;
            case 3:
            //println("inc wis");
              p[pid].set_flat_wis(p[pid].get_flat_wis() + 1);
              p[pid].AP--;
              break;
            case 4:
            //println("inc agi");
              p[pid].set_flat_agi(p[pid].get_flat_agi() + 1);
              p[pid].AP--;
              break;
          }
          
          p[pid].calc_stats();
        }
    }
  }
  
}

public void not_usable(){
  //println("NOT usable");
  fill(8, 100, 100);
  textSize(25);
  stroke(8, 100, 100);
  strokeWeight(2);
  text("This item cannot be used in battle!", width/2, bag.vertical_margin / 2);
}
/*
  monster skill list:
  
  /************
  Normal:
  
  physical:
      
   patk * 1.4:
   
      Collision
      
      Body Blow
   
   patk * 1.6:
   
      Body Smash
      
      Fierce Fang
   
   patk * 1.8:
   
      Strike
      
      Armorbreak
  
  magical:
  
     matk * 1.6:
        
        Flame Branch
        
        Calamity

    matk * 1.8:
        
        Grumburst
        
        Magical power
    
    recovery mp or hp:
        
        rest
  
        focus
  /************ 
    Elite:
    
    Recovery self mp or hp and friendly hp:
        
        Synergistic effect
        
        Evil Pollution
        
   permanent patk increase and cause physical damage:
       
       Reshape
       
       Battle Posture
       
       patk * 1.1
    
   Recovery all mp but cause damage to self:
   
       Autophagy
       
       Factor conversion
       
   AOE physical damge:
   
       Luna's Howl
       
       Power of Dracula
   
   when hp < 50%, recovery 30% of hp, else mp recovery 50%:
   
       Nature choice
       
       Phototaxis evolution
       
   magical aoe:
       Space collapse
       
       Black hole devour
       
       matk * 1.4
   
   magical damage and steal lift
       
       Dim extraction
       
       Bloodthirsty
       
    
  /************ 
  BOSS
  
  floor 2:
  
  Manipulator of Flame: magical damage, matk*1.8, mpdec = 30%
  
  Endlessly: if hp < 50%, regenerate hp 15%, otherwise regenerate all mp, mpdec = 0
  
  Oppression of libraries: AOE magical attack, matk * 1.2, mpdec = 40%
  
  Parsing: cause magical damage and increse self matk, matk * 1.4, mpdec = 40%
  
  
  floor 3:
  
  Feeding mania: physical, patk * 1.4 , mpdec = 20%
  
  Cannibalism: cause physical damage and regenerate same hp, mpdec = 30%
  
  Digestion: regenerate 60%mp and if hp < 50%, pdef increse 20% otherwise patk incrse 10%
  
  Necrotic Realm: physical AOE damage, patk * 1.4,mp_dec = 60%
  
  floor 4: 
  
  Duke engine: Case magical damage matk * 1.2 mpdec = 10%
  
  Reset: Reset all playerside buff and regenerate hp 20% mp_dec = 40%
  
  Meditation: Regenerate 50 % mp and increse 10 % matk
  
  Elemental Storm: cause magical damage, matk * 1.6 mpdec = 60 %
  
  floor 5:
  
  
  
*/



/*
   buff list:

   
    knight:
     
     0: pdef increase   
     
     1: Taunt
     
     2: patk increase
     
     3: AOE bleed
    
    Paladin:
     
     4: stun
     
     5: wont death
     
     6: heal
     
     7: sleep stun
    
    Ranger:
    
     8: Patk add Matk up, so as Matk
     
     9: AOE, stun
     
    Assassin:
     
     10: AGI increase
     
     11: AOE bleed
     
     12: Patk increase
     
    Mage:
     
     13: AOE stun
    
    Priest:
     
     14: All stats increase
     
     15: AOE all stats increase
*/


/*
    skill type:
      0: self as target
      1: ally as target
      2: enemy as target
    
    damage type:
      0: true damage
      1: physical damage
      2: magic damage
      3: recovery hp,mp
      4: buff
*/

/*
  command 0 - 5 : skills 1 - 6
  command 6 : normal attack
  command 7 : item usage
*/
/********************************************
room functions:

0: main menu
1: choose job
90: battle UI
80: bag UI, profile UI
81: bag option menu
99: option menu


*/

/************
ITEMS

3 hp
3 mp
1 full recover
1 revive
3 keys
90 equipment

(types)3 * (lv)5 * (job)6
***************

******       id     *********
//hp
11 - 13

//mp
21 - 23

//max pot
31

//revive
39

//knight
111 - 115
121 - 125
131 - 135

//paladin
211 - 215
221 - 225
231 - 235

//ranger
311 - 315
321 - 325
331 - 335

//assassin
411 - 415
421 - 425
431 - 435

//mage
511 - 515
521 - 525
531 - 535

//priest
611 - 615
621 - 625
631 - 635

//special
90 - 99
*/
boolean doubled = false;

class Skill{
  Skill[] skill;
  public int id, type, dmg_type, skill_count = 1;
  public String name;
  public String[] monster_skill_name = new String[5];
  public String job_name;
  public String description;
  public float origin_status,damage, mod, fix_dmg,heal,mp_dec;
  public float fix_rate = 1;
  public int round_count = 0;
  public boolean healing = false,buff_Set = false;
  PImage icon;
  
  public void skilldamage(){
  }
  
  public void skillUsed(){
  }
}

/*******************************************
 class array to store all the knight skill data
********************************************/

class Knight_skill_list extends Skill{
   
  
  
    public Knight_skill_list(){
     this.skill = new Skill[6];
     skill[0] = new k_skill_1();
     skill[1] = new k_skill_2();
     skill[2] = new k_skill_3();
     skill[3] = new k_skill_4();
     skill[4] = new k_skill_5();
     skill[5] = new k_skill_6();
    }  
}
    
/*******************************************
knight skill 1 unlock at lv1
********************************************/
   class k_skill_1 extends Skill
   {  
     
     public  k_skill_1(){
         this.name = "Half moon slash";
         
         this.description = "Slash enemy by your blade, cause physical damage";
         
         this.type = 2;
         
         this.dmg_type = 1;
         
         this.mp_dec = 13;     
         
         this.icon = loadImage("src/skills/Knight/1.png");
    }
    
    @Override
             public void skilldamage(){
             
             this.mod = 1.25f;
               
             this.damage = p[pid].get_patk() * this.mod;
            }
            
  }
    
    
/*******************************************
knight skill 2 unlock at lv5
********************************************/
  
  class k_skill_2 extends Skill
  { 
    
    public k_skill_2(){
      
      this.name = "Honor guard";
      
      this.description = "Become a tough guy, increse physical defence";
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 20;
      
      this.icon = loadImage("src/skills/Knight/2.png");
    }
    
  
  @Override  
            public void skillUsed(){
              
              this.round_count = 5;             
              
              this.mod = 0.5f;
              
              battle_list[cur].buff_list[0] = this.mod;
              
              battle_list[cur].buff_round[0] = this.round_count;        
    }
}
  
/*******************************************
knight skill 3 unlock at lv10
********************************************/
    
    class k_skill_3 extends Skill
  { 
    public  k_skill_3(){
      this.name = "War stomp";
      
      this.description = "Trample the ground and create hit wave, attack all enemy";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 36;
      
      this.icon = loadImage("src/skills/Knight/3.png");

    }
    
    @Override
             public void skilldamage(){
              
             this.mod = 1.25f;

           for(int i = 0; i < enemy_count; i++){
               hit[i] = i;
               
               if(i != mid){          
                 
                 this.damage = battle_list[cur].get_patk() * this.mod - m[i].get_pdef();
        
                 dmg(this.damage,i,0);
               }
               m[i].calc_stats();
              }        
            
          }
}
    
    
/*******************************************
knight skill 4 unlock at lv15
********************************************/
    
    class k_skill_4 extends Skill{
      
      public  k_skill_4(){
        
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.name = "Taunt";
      
      this.description = "Taunt monster with sexy body";
      
      this.icon = loadImage("src/skills/Knight/4.png");
      
      //51
      this.mp_dec = 0;
      }
      
      @Override
               public void skillUsed(){
                 
                 this.round_count = 3;
                 
                 m[mid].buff_list[1] = pid;
                 
                 m[mid].buff_round[1] = this.round_count;            
              }
}
    
/*******************************************
knight skill 5 unlock at lv20
********************************************/
    
    class k_skill_5 extends Skill{
      
      public  k_skill_5(){
      
      this.name = "Combat focus";
      
      this.description = "Forget everthing but enemy, increse physical damage";
      
      this.type = 0;
      
      this.dmg_type = 4;      
      
      this.round_count = 3;
            
      this.mp_dec = 68;
      
      this.icon = loadImage("src/skills/Knight/5.png");
      
      
      }
      
       @Override
                 public void skillUsed(){
                   this.mod = 1.2f;                 
                   
                   battle_list[cur].buff_list[2] = this.mod;
                   
                   battle_list[cur].buff_round[2] = this.round_count;                                          
                }
}
    
/*******************************************
knight skill 6 unlock at lv25
********************************************/
    
    class k_skill_6 extends Skill{
        
     public k_skill_6(){
       this.name = "Frey's Lævateinn";
       
       this.description = "Slash all enemy with Lævateinn, cause physical damage and bleed";
       
       this.type = 2;
        
       this.dmg_type = 4;
       
       this.mp_dec = 80;
       
       this.icon = loadImage("src/skills/Knight/6.png");
       
     }
      
      @Override
                public void skilldamage(){
                    
                  this.mod = 1.2f;
                                 
                  
                  for(int i = 0; i < enemy_count; i++)
                    {
                        
                       hit[i] = i;
                        
                       this.damage = battle_list[cur].get_patk() * this.mod - m[i].get_pdef();
                       
                       if(this.damage < 1){
                        this.damage = 1;
                      }
                        
                        dmg(this.damage,i,0);                                                   
                    
                    }
                    
                    this.damage = battle_list[cur].get_patk() * this.mod;
                 }

                
                public void skillUsed(){
                    
                    this.mod = 0.2f;
                    
                    this.round_count = 4;                    
                    
                    this.damage = p[pid].get_patk() * this.mod;
                    
                    for(int i = 0; i < enemy_count; i++)
                    {
                       hit[i] = i;   

                      if(this.damage < 1){
                        this.damage = 1;
                      }

                       m[i].buff_list[3] = this.damage; 
                                          
                       m[i].buff_round[3] = this.round_count;

                    }               
                 }
  
    }

/*******************************************
 class array to store all the paladin skill data
********************************************/

class Paladin_skill_list extends Skill{
   
   
    public Paladin_skill_list(){
     this.skill = new Skill[6];
     skill[0] = new pal_skill_1();
     skill[1] = new pal_skill_2();
     skill[2] = new pal_skill_3();
     skill[3] = new pal_skill_4();
     skill[4] = new pal_skill_5();
     skill[5] = new pal_skill_6();
    }  
}


/*******************************************
paladin skill 1 unlock at lv1
********************************************/

class pal_skill_1 extends Skill {

  public  pal_skill_1(){
      this.name = "Curse";  
      
      this.description = "curse your enemy, cause magical damage";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 21;
      
      this.icon = loadImage("src/skills/Paladin/1.png");
                
  }
  
      @Override
                public void skilldamage(){
                   
                this.mod = 1.25f;   
                   
                this.damage = p[pid].get_matk() * this.mod;         
                }
}


/*******************************************
paladin skill 2 unlock at lv5
********************************************/

class pal_skill_2 extends Skill {

  public  pal_skill_2(){
      
      this.name = "Buffalo bump";   
    
      this.description = "Bump all enemy with shiled, cause physical damage and stun them";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 39;
      
      this.icon = loadImage("src/skills/Paladin/2.png");
          
  }
  
  @Override
         public void skilldamage(){  
         
         this.mod = 1.2f;
           
         
         for(int i = 0; i < enemy_count; i++){
               
                 hit[i] = i;
                 
                 this.damage = battle_list[cur].get_patk() * this.mod - m[i].get_pdef();
                 
                 if(this.damage < 1){
                        this.damage = 1;
                      }
                 
                 dmg(this.damage,i,0);

                 m[i].calc_stats();
              }
  
}
        public void skillUsed(){
          
          this.mod = 0.2f;
          
          this.round_count = 2;
          
          for(int i = 0; i < enemy_count; i++)
                    {
                       hit[i] = i;   

                       m[i].buff_list[4] = this.mod;
          
                       m[i].buff_round[4] = this.round_count;
                    } 
        }
}


/*******************************************
paladin skill 3 unlock at lv10
********************************************/

class pal_skill_3 extends Skill {

  public  pal_skill_3(){
      
      this.name = "kiss of Hel";  
      
      this.description = "Crown of death on your head, immortal set";
      
      this.type = 1;
      
      this.dmg_type = 4;
      
      this.round_count = 6;
      
      this.icon = loadImage("src/skills/Paladin/3.png");
  }
  
  public @Override
          void skilldamage(){
              this.mp_dec = battle_list[cur].get_max_mp() * 0.5f;
          }
          
          public void skillUsed(){
                  
                  //p[pid].buff_list[5] = this.mod;
                  
                  p[pid].buff_round[5] = this.round_count; 
          }
}

/*******************************************
paladin skill 4 unlock at lv15
********************************************/

class pal_skill_4 extends Skill {

  public  pal_skill_4(){
    
    this.name = "San light"; 
    
    this.description = "The light of gods, cause magical damage to all enemy";
    
    this.type = 2;
      
    this.dmg_type = 2;  
      
    this.mp_dec = 73;
    
    this.icon = loadImage("src/skills/Paladin/4.png");
           
  }
  
  @Override
           public void skilldamage(){   
           
           this.mod = 1.2f;
           
           for(int i = 0; i < enemy_count; i++){
               if(i != mid)
               {
                 
                 hit[i] = i;
                 
                 this.damage = battle_list[cur].get_matk() * this.mod - m[i].get_mdef();
                 
                 if(this.damage < 1){
                          this.damage = 1;
                        }
                   
                 dmg(this.damage,i,0);
  
                 m[i].calc_stats();
                              
               }
               
               this.damage = battle_list[cur].get_matk() * this.mod;
               
              }
              
  }
  
}

/*******************************************
paladin skill 5 unlock at lv20
********************************************/

class pal_skill_5 extends Skill {
  
  public pal_skill_5(){
    
    this.name = "Striker codex";
    
    this.description = "Codex 1: protect our friend. Heal all friendly target";
    
    this.type = 0;
    
    this.dmg_type = 4;
    
    this.mp_dec = 85;
    
    this.icon = loadImage("src/skills/Paladin/5.png");
}
  
  
  
  
  @Override//aoe heal
            public void skillUsed(){
                
                  this.round_count = 4;          
               
                  for(int i = 0;i < c_pt;i++)
                  {
                    this.heal = p[i].get_max_hp() * 0.15f;
                    
                    p[i].buff_list[6] = this.heal;
                    
                    p[i].buff_round[6] = this.round_count;
                  
                  }                  
                 }
}

/*******************************************
paladin skill 6 unlock at lv25
********************************************/

class pal_skill_6 extends Skill {

  public pal_skill_6(){
    
    this.name = "Sleepy shield";
    
    this.description = "Draw enemy life power, sleep them and cause true damage continued";
    
    this.type = 2;    
    
    this.dmg_type = 4;
    
    this.mp_dec = 143;
    
    this.icon = loadImage("src/skills/Paladin/6.png");
  }

  @Override
            public  void skillUsed(){

                this.round_count = 3;
                
                this.mod = 0.8f;
                
                //skip round sleepy shiled
                this.damage = p[pid].get_matk() * this.mod; 

                  m[mid].buff_list[7] = this.damage;
                
                  m[mid].buff_round[7] = this.round_count;

              }
 
}


/*******************************************
 class array to store all the ranger skill data
********************************************/

class Ranger_skill_list extends Skill{

    public Ranger_skill_list(){
     this.skill = new Skill[6];
     skill[0] = new r_skill_1();
     skill[1] = new r_skill_2();
     skill[2] = new r_skill_3();
     skill[3] = new r_skill_4();
     skill[4] = new r_skill_5();
     skill[5] = new r_skill_6();
    }  
}

/*******************************************
ranger skill 1 unlock at lv1
********************************************/

class r_skill_1 extends Skill{
    
    public  r_skill_1(){
      
      this.name = "Arrow of penetration";
      
      this.description = "Shoot enemy, cause physical damage to target";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 4;
      
      this.icon = loadImage("src/skills/Ranger/1.png");
            
    }
    
    @Override
              public void skilldamage(){           
              
              this.mod = 1.4f; 
                
              this.damage = p[pid].get_patk() * this.mod;   
          }
}

/*******************************************
ranger skill 2 unlock at lv5
********************************************/

class r_skill_2 extends Skill{
    
    public  r_skill_2(){
      
      this.name = "Vestri's arrow"; 
      
      this.description = "Shoot enemy with Vestri's blessing, cause magical damage to target";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 10;  
      
      this.icon = loadImage("src/skills/Ranger/2.png");
    }
    
    @Override
             public void skilldamage(){
            
            this.mod = 1.4f; 
               
            this.damage = p[pid].get_patk() * this.mod;   
            }
}

/*******************************************
ranger skill 3 unlock at lv10
********************************************/

class r_skill_3 extends Skill{
    
    public  r_skill_3(){      
      
      this.name = "Forest blessing";
      
      this.description = "Combine your spiritual power and strength, increase all damage";
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 22;
      
      this.round_count = 4;
      
      this.icon = loadImage("src/skills/Ranger/3.png");
    }

    @Override
              public  void skillUsed(){
                
                this.mod = (p[pid].get_patk() + p[pid].get_matk())/2;
                
                //set patk and matk as mod
                
                battle_list[cur].buff_list[8] = this.mod;
                
                battle_list[cur].buff_round[8] = this.round_count;
              }
}

/*******************************************
ranger skill 4 unlock at lv15
********************************************/

class r_skill_4 extends Skill{
    
    public  r_skill_4(){

      this.name = "Steel shot";
      
      this.description = "Change into steel arrow head, cause physical damage";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 34;
      
      this.icon = loadImage("src/skills/Ranger/4.png");
      
    }
    
      @Override
               public void skilldamage(){
                 
                this.mod = 1.8f;     
                     
                this.damage = p[pid].get_patk() * this.mod;   
        }
}

/*******************************************
ranger skill 5 unlock at lv20
********************************************/

class r_skill_5 extends Skill{
    
    public  r_skill_5(){
      
      this.name = "Cyclone arrow"; 
      
      this.description = "Special way to archery, cause magical damage"; 
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 48;
      
      this.icon = loadImage("src/skills/Ranger/5.png");
      
    }
    
    @Override
               public void skilldamage(){
                 
              this.mod = 1.8f;
                   
              this.damage = p[pid].get_matk() * this.mod;   
        }
}

/*******************************************
ranger skill 6 unlock at lv25
********************************************/

class r_skill_6 extends Skill{
    
    public  r_skill_6(){
      
      this.name = "Flame twine";
      
      this.description = "Summon flame twine around enemy, case magical damage and imprison enemy";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 57;   
      
      this.icon = loadImage("src/skills/Ranger/6.png");
    }
    
    @Override
                  public void skilldamage(){
                  
                  this.mod = 1.3f;
                    
                              for(int i = 0; i < enemy_count; i++){
                                  
                                  hit[i] = i;

                                  this.damage = (battle_list[cur].get_matk()+battle_list[cur].get_patk())*this.mod - m[i].get_mdef();
                                  
                                  if(this.damage < 1){
                                      this.damage = 1;
                                    }
                                     
                                  dmg(this.damage,i,0);

                                  m[i].calc_stats();
                                }
                    }
              
              public void skillUsed(){
                  
                    this.round_count = 3;
                   
                   for(int i = 0;i<enemy_count; i++)
                   {
                     //m[i].buff_list[9] = this.mod;
                  
                      m[i].buff_round[9] = this.round_count;
                   }                                   
                 }
}


/*******************************************
 class array to store all the assassin skill data
********************************************/

class Assassin_skill_list extends Skill{

    
    public Assassin_skill_list(){
     this.skill = new Skill[6];      
     skill[0] = new a_skill_1();
     skill[1] = new a_skill_2();
     skill[2] = new a_skill_3();
     skill[3] = new a_skill_4();
     skill[4] = new a_skill_5();
     skill[5] = new a_skill_6();
    }  
}

/*******************************************
assassin skill 1 unlock at lv1
********************************************/

class a_skill_1 extends Skill{
    
    public  a_skill_1(){
      
      this.name = "Pursuit hit";
      
      this.description = "Despair breakthrough, cause physical damage";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 10;
      
      this.icon = loadImage("src/skills/Assassin/1.png");
      
    }
    
    @Override
            public void skilldamage(){
            
            this.mod = 1.4f;
              
            this.damage = p[pid].get_patk() * this.mod; 
        }
}


/*******************************************
assassin skill 2 unlock at lv5
********************************************/

class a_skill_2 extends Skill{
    
    public  a_skill_2(){
      
      this.name = "Back stab";
      
      this.description = "Stab enemy at their back, cause physical damage";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 22;
      
      this.icon = loadImage("src/skills/Assassin/2.png");
   
    }
    
    @Override
            public void skilldamage(){
              
            this.mod = 1.8f;
              
            this.damage = p[pid].get_patk() * this.mod; 
        }
}

/*******************************************
assassin skill 3 unlock at lv10
********************************************/

class a_skill_3 extends Skill{
    
    public  a_skill_3(){
      
      this.name = "Absorb";
      
      this.description = "Absorb wind's power, increase speed";
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 39;
      
      this.icon = loadImage("src/skills/Assassin/3.png");
      
    }

 @Override
          public  void skillUsed(){

            this.round_count = 2;
            
            this.mod = 0.4f;
            
            battle_list[cur].buff_list[10] = this.mod;
            
            battle_list[cur].buff_round[10] = this.round_count;          
          }
}

/*******************************************
assassin skill 4 unlock at lv15
********************************************/

class a_skill_4 extends Skill{
    
    public  a_skill_4(){
      
      this.name = "Shadow thorn";
      
      this.description = "Wield your knife in the shadow and slash all enemy, cause physical damage and bleed";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 59;
      
      this.icon = loadImage("src/skills/Assassin/4.png");
      
    }

@Override    
          public  void skilldamage(){
            this.mod = 1.2f;
        
                  for(int i = 0; i < enemy_count; i++){
                       
                       hit[i] = i;

                       this.damage = battle_list[cur].get_patk() * this.mod - m[i].get_pdef();
                       
                       if(this.damage < 1){
                        this.damage = 1;
                      }
                       
                       dmg(this.damage,i,0);

                     m[i].calc_stats();
                    } 
            }
          
          public  void skillUsed(){
            
            this.round_count = 5;
      
            this.mod = 0.2f;
            
            this.damage = p[pid].get_patk() * this.mod;
            
            for(int i = 0; i < enemy_count;i++)
            {
              hit[i] = i;
              
              m[i].buff_list[11] = this.damage;
            
              m[i].buff_round[11] = this.round_count;   
            }           
              
            }
}

/*******************************************
assassin skill 1 unlock at lv20
********************************************/

class a_skill_5 extends Skill{
    
    public  a_skill_5(){
      this.name = "Shadow world";
      
      this.description = "Break the wall between void and reality and absorb power of void, increase physical damage";
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.icon = loadImage("src/skills/Assassin/5.png");
      
    }

    
@Override
            public  void skillUsed(){
              
            this.mp_dec = battle_list[cur].get_max_mp() * 0.3f;
            
            this.mod = 0.3f;
            
            this.round_count = 1;
            
            battle_list[cur].buff_list[12] = this.mod;
            
            battle_list[cur].buff_round[12] = this.round_count;
          
          }
}


/*******************************************
assassin skill 1 unlock at lv25
********************************************/

class a_skill_6 extends Skill{
    
    public  a_skill_6(){
      
      this.name = "Ghost Blade";
      
      this.description = "Summon a demon to control your body, cause phycial damage";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.icon = loadImage("src/skills/Assassin/6.png");
      
    }
    
@Override
            public void skilldamage(){  
            
            this.mp_dec = p[pid].get_max_mp();
              
            this.mod = 2.2f;  
              
            this.damage = p[pid].get_patk() * this.mod; 
            }
}


/*******************************************
 class array to store all the mage skill data
********************************************/

class Mage_skill_list extends Skill{
    
    public Mage_skill_list(){
     this.skill = new Skill[6];
     skill[0] = new m_skill_1();
     skill[1] = new m_skill_2();
     skill[2] = new m_skill_3();
     skill[3] = new m_skill_4();
     skill[4] = new m_skill_5();
     skill[5] = new m_skill_6();
    }  
}

/*******************************************
mage skill 1 unlock at lv1
********************************************/

class m_skill_1 extends Skill{
    
    public m_skill_1(){
      
      this.name = "Flame ball";
      
      this.description = "Summon a flame ball and bump enemy,cause magical damage";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 10;
      
      this.icon = loadImage("src/skills/Mage/1.png");
          
    }
    
     @Override
            public void skilldamage(){
            
            this.mod = 1.4f;  
              
            this.damage = p[pid].get_matk() * this.mod; 
        }
}

/*******************************************
mage skill 2 unlock at lv5
********************************************/

class m_skill_2 extends Skill{
    
    public m_skill_2(){
      this.name = "Anthem of aegir";
      
      this.description = "Sing a anthem of aegir, punish all enemy, cause magical damage";
      
      // to all
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 38;
      
      this.icon = loadImage("src/skills/Mage/2.png");
   
    }
    
    @Override
            public void skilldamage(){
              
            this.mod = 1.3f;  
              
           
            
              for(int i = 0; i < enemy_count; i++){
                  if(i != mid)
                  {
                    
                    hit[i] = i;
  
                     this.damage = battle_list[cur].get_matk() * this.mod - m[i].get_mdef(); 
                     
                     if(this.damage < 1){
                          this.damage = 1;
                        }
                     
                     dmg(this.damage,i,0);
                     
                     m[i].calc_stats();
                  }
                }                                   
                   
                 this.damage = battle_list[cur].get_matk() * this.mod;
        }
}


/*******************************************
mage skill 3 unlock at lv10
********************************************/

class m_skill_3 extends Skill{
    
    public m_skill_3(){
      this.name = "Meditate";
      
      this.description = "Keep your mind in peace, regenerate your power";
      
      this.type = 0;
      
      this.dmg_type = 3;
      
      this.mp_dec = 50;
      
      this.healing = false;
      
      this.icon = loadImage("src/skills/Mage/3.png");
    }

@Override  
          public void skilldamage(){        
              this.heal = p[pid].get_max_mp() * 0.6f;        
            }
}


/*******************************************
mage skill 4 unlock at lv15
********************************************/

class m_skill_4 extends Skill{
    
    public m_skill_4(){
      
      this.name = "Absolute zero";
      
      this.description = "Create an extreme cold filed, freeze all enemy but regenerate their health";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 72;
      
      this.icon = loadImage("src/skills/Mage/4.png");
    }

@Override    
          public  void skillUsed(){
      
            this.round_count = 4;
         
            for(int i = 0; i<enemy_count;i++)
            {
                this.heal = m[i].get_max_hp() * 0.2f;
                
                m[i].buff_list[13] = this.heal;
            
                m[i].buff_round[13] = this.round_count;
                
            }
                        
            
          }
}

/*******************************************
mage skill 5 unlock at lv20
********************************************/

class m_skill_5 extends Skill{
    
    public m_skill_5(){
      
      this.name = "Karma";
      
      this.description = "God with punish those people with sin, cause magical damage";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 89;   
      
      this.icon = loadImage("src/skills/Mage/5.png");

    
    }
    
@Override
            public void skilldamage(){
      //after damaged reset doubled as false              
             doubled = false;
            
            if(doubled)
            {
              doubled = false;
              this.mod = 2;
            }
            
            else{
              doubled = true;
              this.mod = 1.6f;
            }             
            this.damage = p[pid].get_matk() * this.mod; 
        }
}

/*******************************************
mage skill 6 unlock at lv25
********************************************/

class m_skill_6 extends Skill{
    
    public m_skill_6(){
      
      this.name = "Meteor strike";
      
      this.description = "Summon meteor rain to attack all enemy, cause magical damge";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 150;
      
      this.icon = loadImage("src/skills/Mage/6.png");

    }
    
    @Override
              public void skilldamage(){
                
                    this.mod = 1.6f;
              
                  for(int i = 0; i < enemy_count; i++){
                    
                    if(i != mid)
                    {
                          hit[i] = i;
    
                         this.damage = battle_list[cur].get_matk() * this.mod - m[i].get_mdef();                      
                          
                         if(this.damage < 1){
                            this.damage = 1;
                          }
                         
                         dmg(this.damage,i,0);
    
                         m[i].calc_stats();                    
                    }  
                  }
                  
                  this.damage = battle_list[cur].get_matk() * this.mod;                  
            }
}


/*******************************************
 class array to store all the priest skill data
********************************************/

class Priest_skill_list extends Skill{

    
    public Priest_skill_list(){
     this.skill = new Skill[6];      
     skill[0] = new pri_skill_1();
     skill[1] = new pri_skill_2();
     skill[2] = new pri_skill_3();
     skill[3] = new pri_skill_4();
     skill[4] = new pri_skill_5();
     skill[5] = new pri_skill_6();
    }  
}


/*******************************************
priest skill 1 unlock at lv1
********************************************/

class pri_skill_1 extends Skill{
    
    public  pri_skill_1(){
      
      this.name = "Light bullet";
      
      this.description = "Have you ever tried high level laser? cause magical damge";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 30;
      
      this.icon = loadImage("src/skills/Priest/1.png");
    
    }
    
    @Override
            public void skilldamage(){
              
            this.mod = 1.3f;
                  
            this.damage = p[pid].get_matk() * this.mod; 
        }
}

/*******************************************
priest skill 2 unlock at lv5
********************************************/

class pri_skill_2 extends Skill{
    
    public  pri_skill_2(){
      
      this.name = "Iden's blessing"; 
      
      this.description = "Iden show mercy to her people, regenerate target health";
      
      this.type = 1;
      
      this.dmg_type = 3;
      
      this.healing = true;
      
      this.mp_dec = 40;
      
      this.icon = loadImage("src/skills/Priest/2.png");
    }
    
    @Override
            public void skilldamage(){
              
            this.heal = battle_list[cur].get_matk();
        }
}

/*******************************************
priest skill 3 unlock at lv10
********************************************/

class pri_skill_3 extends Skill{
    
    public  pri_skill_3(){
      
      this.name = "Seraph’s Aura";
      
      this.description = "Seraph recognized you, increase all base status";
      
      this.type = 1;
      
      this.dmg_type = 4;
      
      this.mp_dec = 80;
      
      this.icon = loadImage("src/skills/Priest/3.png");
    }

@Override            
          public  void skillUsed(){
        
          this.round_count = 5;
          
          this.mod = 0.2f;
          
          p[pid].buff_list[14] = this.mod;
          
          p[pid].buff_round[14] = this.round_count;   
        }
}

/*******************************************
priest skill 4 unlock at lv15
********************************************/

class pri_skill_4 extends Skill{
    
    public  pri_skill_4(){
      
      this.name = "Yggdrasill's Sap";
      
      this.description = "Yggdrasill is our world. regenerate all friendly target's health";
      
      this.type = 0;
      
      this.dmg_type = 3;
      
      this.healing = true;
      
      this.mp_dec = 100;
      
      this.icon = loadImage("src/skills/Priest/4.png");
  
    }
    
    @Override
              public void skilldamage(){
              
              this.mod = 0.8f; 
                
              this.heal = battle_list[cur].matk * this.mod;
              
              for(int i = 0; i< c_pt; i++)
              {
                 if(i != pid){
                   
                   p[i].rec_hp(this.heal);
                 }
                 p[i].calc_stats();
              }              
            }
}

/*******************************************
priest skill 5 unlock at lv20
********************************************/

class pri_skill_5 extends Skill{
    
    public  pri_skill_5(){
      
      this.name = "Well of radiance";
      
      this.description = "Gods create this miracle, increase all friendly target's status";
      
      this.type = 0;      
      
      this.dmg_type = 4;
      
      this.mp_dec = 112;
      
      this.icon = loadImage("src/skills/Priest/5.png");
    }
    
    @Override
            public  void skillUsed(){
              //AOE
              
              this.round_count = 5;
              
              this.mod = 0.15f;
              
              for(int i = 0; i<c_pt; i++)
              {
               
               p[i].buff_list[15] = this.mod;
              
               p[i].buff_round[15] = this.round_count;
                
              }
              
             
            }
}

/*******************************************
priest skill 6 unlock at lv25
********************************************/

class pri_skill_6 extends Skill{
    
    public  pri_skill_6(){
      
      this.name = "Nirvana";
      
      this.description = "This is a story about phoenix, resurrect target";
      
      this.type = 1;
      
      this.dmg_type = 3;
      
      this.healing = false;
      
      this.icon = loadImage("src/skills/Priest/6.png");
  
    }

    public @Override
            void skilldamage(){
             
              p[pid].ress();
              
              this.heal = p[pid].get_max_mp();
              p[pid].rec_hp(p[pid].get_max_hp());
              this.mp_dec = battle_list[cur].get_max_mp() * 0.4f;    
          }
}


/**********************************

Normal skill list

*********************************/

class Normal_Skill extends Skill{  
  
  public Normal_Skill(){
     this.skill = new Skill[6];
     skill[0] = new Normal_Skill_1();
     skill[1] = new Normal_Skill_2();
     skill[2] = new Normal_Skill_3();
     skill[3] = new Normal_Skill_4();
     skill[4] = new Normal_Skill_5();
     skill[5] = new Normal_Skill_6();
     
  }
  
}

class Normal_Skill_1 extends Skill{
  
  public Normal_Skill_1(){
    
    this.monster_skill_name[0] ="Collision";
    
    this.monster_skill_name[1] ="Body Blow";
     
    this.mod = 1.4f;
    
    this.dmg_type = 1;
}

  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.3f;
    
    this.damage = m[mid].get_patk() * this.mod;    
  }
  
}

class Normal_Skill_2 extends Skill{
  
  public Normal_Skill_2(){
    
    this.monster_skill_name[0] ="Body Smash";
    
    this.monster_skill_name[1] ="Fierce Fang";
    
    this.mod = 1.6f;
    
    this.dmg_type = 1;
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5f;
    
    this.damage = m[mid].get_patk() * this.mod;    
  }

}

class Normal_Skill_3 extends Skill{
  
  public Normal_Skill_3(){
    
    this.monster_skill_name[0] ="Strike";
    
    this.monster_skill_name[1] ="Armorbreak";
    
    this.dmg_type = 1;
    
    this.mod = 1.8f;
  }
  
   public void skilldamage(){
     
    this.mp_dec = m[mid].get_max_mp() * 0.7f; 
     
    this.damage = m[mid].get_patk() * this.mod;    
  }

}

class Normal_Skill_4 extends Skill{
  
  public Normal_Skill_4(){
    
    
    this.monster_skill_name[0] ="Flame Branch";
    
    
    this.monster_skill_name[1] ="Calamity";
    
    this.mod = 1.6f;
    
    this.dmg_type = 2;
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5f;
    
    this.damage = m[mid].get_matk() * this.mod;    
  }

}

class Normal_Skill_5 extends Skill{
  
  public Normal_Skill_5(){
    
    this.monster_skill_name[0] ="Grumburst";
    
    this.monster_skill_name[1] ="Magical power";
    
    this.mod = 1.8f;
    
    this.dmg_type = 2;
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.7f;
    
    this.damage = m[mid].get_matk() * this.mod;    
  }
}

class Normal_Skill_6 extends Skill{
  
  public Normal_Skill_6(){
    
    this.monster_skill_name[0] ="rest";
    
    this.monster_skill_name[1] ="focus";
    
    this.mod = 0.3f;
    
    this.healing = r.nextBoolean();
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.2f;
    
    this.heal = m[mid].get_max_hp() * this.mod;    
  }
}



class Elite_Skill extends Skill{  
  
  public Elite_Skill(){
     this.skill = new Skill[7];
     skill[0] = new Elite_Skill_1();
     skill[1] = new Elite_Skill_2();
     skill[2] = new Elite_Skill_3();
     skill[3] = new Elite_Skill_4();
     skill[4] = new Elite_Skill_5();
     skill[5] = new Elite_Skill_6();
     skill[6] = new Elite_Skill_7();
  }  
}

class Elite_Skill_1 extends Skill{
  
  public Elite_Skill_1(){
    
    this.monster_skill_name[0] ="Synergistic effect";
    
    this.monster_skill_name[1] ="Evil Pollution";
    
    this.mod = 0.3f;
    
    this.healing = r.nextBoolean();
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.1f;
    
    this.heal = m[mid].get_max_hp() * this.mod;
    
    for(int i = 0; i<enemy_count; i++)
    {  
      if(i != mid)
      {
        m[i].rec_hp(this.heal);
      }
      
      m[i].calc_stats();   
    }
  
}
}


class Elite_Skill_2 extends Skill{
  
  public Elite_Skill_2(){
    
    this.monster_skill_name[0] ="Reshape";
    
    this.monster_skill_name[1] ="Battle Posture";
    
    this.mod = 0.1f;
    
    this.dmg_type = 1;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5f;
    
    m[mid].inc_patk(m[mid].get_patk() * this.mod);
    
    this.damage = m[mid].get_patk() * (1.1f + this.mod);
  }
}

class Elite_Skill_3 extends Skill{
  
  public Elite_Skill_3(){
    
    this.monster_skill_name[0] ="Factor conversion";
    
    this.monster_skill_name[1] ="Autophagy";
    
    this.mod = 0.25f;
    
    this.healing = false;
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = 0;
    
    this.heal = m[mid].get_max_mp();
    
    this.damage = m[mid].get_patk() * this.mod;
    
    dmg(this.damage,mid,1);
  }
}


class Elite_Skill_4 extends Skill{
  
  public Elite_Skill_4(){
    
    this.monster_skill_name[0] ="Power of Dracula";
    
    this.monster_skill_name[1] ="Luna's Howl";
    
    this.mod = 1.4f;
    
    this.dmg_type = 1;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.3f;
    
    this.damage = m[mid].get_patk() * this.mod;
    
    for(int i = 0; i <c_pt;i++)
    {     
      if(i != mid)
      {
         hit[i] = i;
         
         this.damage = m[mid].get_patk() - p[i].get_pdef();
         
         dmg(this.damage, i , 1);
         
      }
      
      p[i].calc_stats();   
    }
  }
}

/**********************************

Elite skill list

*********************************/


class Elite_Skill_5 extends Skill{
  
  public Elite_Skill_5(){
    
    this.monster_skill_name[0] ="Nature choice";
    
    this.monster_skill_name[1] ="Phototaxis evolution";
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.2f;
    
    if(m[mid].cur_hp < m[mid].get_max_hp() * 0.5f)
    {      
        this.mod = 0.3f;
        
        this.healing = true;
        
        this.heal = m[mid].get_max_hp() * this.mod;  
    }
    else
    {
      this.mod = 0.5f;
      
      this.healing = false;
      
      this.heal = m[mid].get_max_mp() * this.mod;  
    }
      
  }
}

class Elite_Skill_6 extends Skill{
  
  public Elite_Skill_6 (){
    
    this.monster_skill_name[0] ="Space collapse";
    
    this.monster_skill_name[1] ="Black hole devour";
    
    this.mod = 1.4f;
    
    this.dmg_type = 2;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5f;
    
    for(int i = 0;i<c_pt;i++)
    {
        if(i != mid)
        {
          this.damage = m[mid].get_matk() * this.mod - p[i].get_mdef();
          
          dmg(this.damage,i,1);
        }
        
      p[i].calc_stats();      
    } 
  }
}

class Elite_Skill_7 extends Skill{
  
  public Elite_Skill_7 (){
    
    this.monster_skill_name[0] ="Dim extraction";
    
    this.monster_skill_name[1] ="Bloodthirsty";
    
    this.mod = 0.8f;
    
    this.healing = true;
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.2f;
    
    this.damage = m[mid].get_matk() * this.mod;
    
    this.heal = this.damage;
    
    dmg(this.damage,r.nextInt(100) % c_pt,1);
  }
}

/**********************************

Boss skill list

*********************************/

class Boss_Skill_floor_2 extends Skill{  
  
  public Boss_Skill_floor_2(){
     this.skill = new Skill[4];
     skill[0] = new F2_Skill_1();
     skill[1] = new F2_Skill_2();
     skill[2] = new F2_Skill_3();
     skill[3] = new F2_Skill_4();
  }
}

class F2_Skill_1 extends Skill{
    public F2_Skill_1(){
        
      this.dmg_type = 2;
      
      this.name = "Manipulator of Flame";
      
      this.mod = 1.8f;
      
              
    }
    
    public void skilldamage(){
      
      this.mp_dec =  m[mid].get_max_mp() * 0.3f;   
    
      this.damage = m[mid].get_matk() * this.mod;
    
  }
}

class F2_Skill_2 extends Skill{
    public F2_Skill_2(){
      
      this.name = "Parsing";
      
      this.dmg_type = 2;
      
               
    }
    
    public void skilldamage(){
      
      this.mp_dec = m[mid].get_max_mp() * 0.4f; 
            
      this.mod = 1.4f;
      
      this.damage = m[mid].get_matk() * this.mod;
      
      m[mid].inc_matk(battle_list[cur].get_matk() * 0.2f);      
    }
}


class F2_Skill_3 extends Skill{
    public F2_Skill_3(){
        
      this.name = "Endlessly";
      
      this.dmg_type = 3;
      
      this.mp_dec = 0;    
    }
    
    public void skilldamage(){
    
      if(m[mid].get_cur_hp() < m[mid].get_max_hp() * 0.2f)
      {
        this.mod = 0.2f;
        
        this.healing = true;
        
        this.heal = m[mid].get_max_hp() * this.mod;
      }
      else{
        this.healing = false;
        
        this.heal = m[mid].get_max_mp();     
      }
      
      
    }
}

class F2_Skill_4 extends Skill{
    
      public F2_Skill_4(){
        
      this.dmg_type = 2;
      
      this.name = "Oppression of libraries";
      
       
        
    }   
    public void skilldamage(){
      
      this.mp_dec = battle_list[cur].get_max_mp() * 0.4f; 

      this.mod = 1.2f;
      
      for(int i = 0; i <c_pt;i++)
      {
        hit[i] = i;
        
        if(i != pid)
        {          
          this.damage =  m[mid].get_matk() * this.mod - p[pid].get_mdef();
          
          dmg(this.damage,i,1);
          
          p[i].calc_stats();      
        }
      }
      
      this.damage = m[mid].get_matk() * this.mod;

    }
}

class Boss_Skill_floor_3 extends Skill{  
  
  public Boss_Skill_floor_3(){
     this.skill = new Skill[4];
     skill[0] = new F3_Skill_1();
     skill[1] = new F3_Skill_2();
     skill[2] = new F3_Skill_3();
     skill[3] = new F3_Skill_4();
  }  
}

class F3_Skill_1 extends Skill{
    public F3_Skill_1(){
      
      this.dmg_type = 1; 
      
      this.name = "Feeding mania";
    
      
    }
    
    public void skilldamage(){
      
      this.mp_dec = m[mid].get_max_mp() * 0.2f;
      
      this.mod = 1.4f;
      
      this.damage = m[mid].get_patk() * this.mod;
    
    }
}

class F3_Skill_2 extends Skill{
    public F3_Skill_2(){
      
      this.dmg_type = 3; 
      
      this.name = "Cannibalism";
    
      
    }
    
    public void skilldamage(){
      
      this.mp_dec = m[mid].get_max_mp() * 0.3f;
      
      this.mod = 1.3f;
      
      this.healing = true;
      
      this.damage = m[mid].get_patk() * this.mod - p[pid].get_pdef();
      
      dmg(this.damage,pid,1);
      
      this.heal = this.damage;
    }
}

class F3_Skill_3 extends Skill{
    public F3_Skill_3(){
      
      this.dmg_type = 3; 
      
      this.name = "Digestion";
      
      this.healing = false;
      
      this.mp_dec = 0;
    }
    
    public void skilldamage(){
      
      this.mod = 0.6f;
      
      if(m[mid].get_cur_hp() < m[mid].get_max_hp() * 0.5f)
      {
         m[mid].inc_pdef(m[mid].get_pdef() * 0.2f);  
      }
      else{
        
         m[mid].inc_patk(m[mid].get_patk() * 0.1f);  
      }
      
      this.heal =  m[mid].get_max_mp() * this.mod;
    }

}

class F3_Skill_4 extends Skill{
    public F3_Skill_4(){
      
      this.dmg_type = 1; 
      
      this.name = "Necrotic Realm";
    
      
    }
    
    public void skilldamage(){
      
      this.mp_dec = m[mid].get_max_mp() * 0.6f;
      
      this.mod = 1.4f;
      
      for(int i = 0;i<c_pt;i++)
      {
        hit[i] = i;
        if(i != pid){
          
          this.damage = m[mid].get_patk() - p[i].get_pdef();
          
          dmg(this.damage,i,1);   
        }
        
        p[i].calc_stats();  
      }
      
      this.damage = m[mid].get_patk() * this.mod;
    
    }

}

class Boss_Skill_floor_4 extends Skill{  
  
  public Boss_Skill_floor_4(){
     this.skill = new Skill[4];
     skill[0] = new F4_Skill_1();
     skill[1] = new F4_Skill_2();
     skill[2] = new F4_Skill_3();
     skill[3] = new F4_Skill_4();
  }  
}

class F4_Skill_1 extends Skill{  
  
  public F4_Skill_1(){
    
    this.dmg_type = 2;
    
    this.name = "Duke Engine";
    
    

  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.1f;
    
    this.mod = 1.2f;
    
    this.damage = m[mid].get_matk() * this.mod;
  }

}

class F4_Skill_2 extends Skill{  
  
  public F4_Skill_2(){
    
    this.dmg_type = 3;
    
    this.name = "Reset"; 
    
    this.healing = true;    
    
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.4f;
    
    this.heal = m[mid].get_max_hp() * 0.1f;
    
    for(int i = 0; i<c_pt; i++)
    {
        for(int j = 0; j < buff_count; j++)
        {
                  p[i].buff_round[j] = 0;
                  
                  p[i].calc_buff();
        }
        
        p[i].calc_buff();
    }
  }
}

class F4_Skill_3 extends Skill{  
  
  public F4_Skill_3(){
    
    this.dmg_type = 3;
    
    this.name = "Meditation";
    
    this.healing =false;
    
    this.mp_dec = 0;
}  
  
  public void skilldamage(){
    
    this.heal = m[mid].get_max_mp() * 0.5f;
    
    m[mid].inc_matk(battle_list[cur].get_matk() * 0.1f);  
  }
}


class F4_Skill_4 extends Skill{  
  
  public F4_Skill_4(){
    this.dmg_type = 2;
    
    this.name = "Elemental Storm";
    
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.6f;
    
    this.mod = 1.6f;
    
    for(int i = 0; i<c_pt;i++)
    {
      hit[i] = i;
      if(i != pid)
      {
        this.damage = m[mid].get_matk() * this.mod - p[i].get_mdef();
        
        dmg(this.damage,i,1);
      }
      p[i].calc_stats();
    }
    
    this.damage = m[mid].get_matk() * this.mod;
  }
}

class Boss_Skill_floor_5 extends Skill{  
  
  public Boss_Skill_floor_5(){
     this.skill = new Skill[4];
     skill[0] = new F5_Skill_1();
     skill[1] = new F5_Skill_2();
     skill[2] = new F5_Skill_3();
     skill[3] = new F5_Skill_4();
  }  
}

class F5_Skill_1 extends Skill{  
  
  public F5_Skill_1(){
    this.name = "Bite";
    
    this.dmg_type = 1;
    
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.1f;
    
    this.mod = 1.2f;
    
    
    this.damage = m[mid].get_patk() * this.mod;
  }
}

class F5_Skill_2 extends Skill{  
  
  public F5_Skill_2(){
    
    this.name = "Dark oppression";
    
    this.dmg_type = 2;
    
    
    
  }
  
   public void skilldamage(){
     
     this.mp_dec = m[mid].get_max_mp() * 0.1f;
    
    this.mod = 1.2f;
    
    
    this.damage = m[mid].get_matk() * this.mod;
  }
}


class F5_Skill_3 extends Skill{  
  
  public F5_Skill_3(){
    
    this.name = "Curse of Vampire";
    
    this.dmg_type = 3;
    
    this.mp_dec = 0;
    
    this.healing = false;
  } 
  
  public void skilldamage(){
    
    this.heal = m[mid].get_max_mp() * 0.8f;
    
    for(int i = 0; i<c_pt; i++)
    {
        for(int j = 0; j < buff_count; j++)
        {
           p[i].buff_round[j] = 0;
           
           p[i].calc_buff();
        }
    } 
  }
}


class F5_Skill_4 extends Skill{  
  
  public F5_Skill_4(){
    
    this.name = "Shadow falls";
    
    this.dmg_type = 2;
    
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.1f;
    
    this.mod = 1.2f;
    
    this.damage = m[mid].get_matk() * this.mod;
    
    for(int i = 0; i <c_pt;i++)
    {
      
      if(i != pid)
      {
         this.damage = m[mid].get_matk() * this.mod - p[i].get_mdef();
         
         dmg(this.damage,i,1);
      }
      p[i].calc_stats();
    }
      this.damage =m[mid].get_matk() * this.mod;
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
