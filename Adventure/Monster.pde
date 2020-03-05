
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
  protected float mod = 1.0;
  PImage battle_img;
  
  public Monster(){
    type = 0;
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
        this.mod = 1.0;
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
        this.skillset.add(r.nextInt(6));
        this.skills = new Normal_Skill();
        break;
      
      case 2:
        this.monster_type = "Elite";
        this.mod = 1.5;
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
          this.skillset.add(r.nextInt(7));
        }
        
        this.skills = new Elite_Skill();
        break;
        
      
      case 3:
        this.monster_type = "Boss";
        this.mod = 2.0;
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
    
    this.patk = (level * 6) * mod;
    this.pdef = (level * 4) * mod;
    this.matk = (level * 6) * mod;
    this.mdef = (level * 4) * mod;
    this.spd = (level * 3) * mod;
    this.max_hp = (level * 20) * mod;
    this.max_mp = (level * 20) * mod;
    this.cur_hp = (level * 20) * mod;
    this.cur_mp = (level * 20) * mod;
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
    
    this.exp = this.level * 2 * this.mod;
    
    //println("exp monster: "+this.exp);
    
    return this.exp;
  }
  
  public int get_gold(){
    
    this.gold = (this.level * 5) + r.nextInt(50);
    
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
