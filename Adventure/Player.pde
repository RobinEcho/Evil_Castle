
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
  
  float Big_sl = 0.3*UI_height;
  
  float Wp_distance = Big_sl / (Wpsq_num * 3 +1);
  
  float Wpsq_sl = 2*Wp_distance;
  
  float Strip_height = strip_distance;
  
  float addsq_sl = Strip_height;
  
  float Strip_width = (UI_width - 4*sq_distance - addsq_sl) / 2;
  
  float v_a = 0.05*UI_height;
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
		this.flat_mdef = wis * job.amplifier[3] + level * (3.5 + job.amplifier[3]);
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
    println("max_hp: " + this.max_hp + " hp dec: " + this.hp_dec + " cur hp: " + this.cur_hp);
    
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
    
    image(this.avatar, horizontal_margin + sq_distance + Big_sl *0.1,vertical_margin + Avatarsq_sl + 2*v_a - Big_sl * 0.1,Big_sl * 0.8,Big_sl* 0.8);
    
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
        
        text(this.name,horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75*Strip_height);
        
        break;
        
        case 2:
        
        text(this.job.name,horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75*Strip_height);
        
        break;
        
        case 3:
        
        text("Level: "+this.get_level(),horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75*Strip_height);
        
        break;
        
        case 4:
        
        text("Exp: "+(int)this.get_exp(),horizontal_margin + sq_distance + Big_sl + sq_distance + 0.5*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + (n - 1)*sq_distance + 0.75*Strip_height);
        
        break;
        
      
      }
    
    }
    
    fill(0,0,100);
    
    rect(sq_distance + horizontal_margin,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + Strip_height,Strip_width,Strip_height,10);
    
    rect(horizontal_margin + Strip_width + 1.2*sq_distance + addsq_sl,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + Strip_height,Strip_width,Strip_height,10);
    
    //stroke(0);
    
    fill((this.job_code - 1) * 12, 100, 60);
    
    text("Hp: "+(int)this.get_cur_hp(),sq_distance + horizontal_margin + 0.5*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.75*Strip_height);
    
    text("Mp: "+(int)this.get_cur_mp(),horizontal_margin + Strip_width + 1.2*sq_distance + addsq_sl + 0.5*Strip_width,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.75*Strip_height);
    
    fill(0,0,100);
    
    ellipse(horizontal_margin + Strip_width + sq_distance + addsq_sl + Strip_width + 1.5*sq_distance,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.5*Strip_height,1.2*sq_distance,1.2*sq_distance);
    
    fill((this.job_code - 1) * 12, 100, 60);
    text(this.AP, horizontal_margin + Strip_width + sq_distance + addsq_sl + Strip_width + 1.5*sq_distance,vertical_margin + Avatarsq_sl + 2*v_a + Big_sl + 1.5*Strip_height);
    
    fill(0,0,100);
    for(int n = 1; n <= Strip_num; n++){
      
      for(int l=1; l <=2 ;l++){
        
    rect(horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance),vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance,Strip_width,Strip_height,10);
        
    //stroke(0);
    
    fill((this.job_code - 1) * 12, 100, 60);
    
    if(n==1){
    
      if(l==1){
      
        text("Str: "+(int)this.get_str(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
      
      }
      
      else{
      
        text("Patk: "+(int)this.get_patk(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
      
      }
      
    }
      
    if(n==2){
      
      if(l==1){
    
      text("Con: "+(int)this.get_con(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
    
      }
      
      else{
      
      text("Pdef: "+(int)this.get_pdef(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
      
      }
      
    }
    
    if(n==3){
      
      if(l==1){
    
      text("Intel: "+(int)this.get_intel(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
    
      }
      
      else{
      
      text("Matk: "+(int)this.get_matk(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
      
      }
      
    }
    
    if(n==4){
      
      if(l==1){
    
      text("Wis: "+(int)this.get_wis(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
    
      }
      
      else{
      
      text("Mdef: "+(int)this.get_mdef(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
      
      }
      
    }
    
    if(n==5){
      
      if(l==1){
    
      text("Agi: "+(int)this.get_agi(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
    
      }
      
      else{
      
      text("Spd: "+(int)this.get_spd(),horizontal_margin + l*sq_distance + (l-1)*Strip_width + (l-1)*(addsq_sl+sq_distance)+0.5*Strip_width,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance+0.75*Strip_height);
      
      }
      
    }
    
       fill(0,0,100);
    
     }
     
     //stroke(0);
    
     rect(horizontal_margin + sq_distance + Strip_width + sq_distance,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance,addsq_sl,addsq_sl,10);
     
     fill((this.job_code - 1) * 12, 100, 60);
     
     text("+",horizontal_margin + sq_distance + Strip_width + sq_distance + 0.5*addsq_sl,vertical_margin + Avatarsq_sl + 13*strip_distance + (n-1)*sq_distance +0.75*addsq_sl);
     
     fill(0,0,100);
    
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
