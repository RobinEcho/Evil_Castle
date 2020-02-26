
  /*******************************************
  Monster status setting
  ********************************************/ 



class Monster extends Units{
  protected int m_type;
  protected String monster_type = "Normal";
  protected String name;
  protected int skillset = 0;
  protected float mod = 1.0;
  
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
    
    switch(m_type){
      case 1:
        this.monster_type = "Normal";
        this.mod = 1.0;
        this.img = loadImage("src/monster/normal/n1.png");
        break;
      
      case 2:
        this.monster_type = "Elite";
        this.mod = 1.5;
        this.img = loadImage("src/monster/elite/e1.png");
        break;
      
      case 3:
        this.monster_type = "Boss";
        this.mod = 2.0;
        this.img = loadImage("src/monster/boss/b1.png");
        break;
      
    }
    
    this.patk = (level * 10) * mod;
    this.pdef = (level * 10) * mod;
    this.matk = (level * 10) * mod;
    this.mdef = (level * 10) * mod;
    this.spd = (level * 10) * mod;
    this.max_hp = (level * 2) * mod;
    this.max_mp = (level * 2) * mod;
    this.cur_hp = (level * 2) * mod;
    this.cur_mp = (level * 2) * mod;
    this.hp_dec = 0;
    this.mp_dec = 0;
    
    
  }
	
	public void calc_stats(){
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
  
  public void setName(String s){
    this.name = s;
  }
  
  public String getName(){
    return this.name;
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
