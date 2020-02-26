//changed
/*******************************************************************
class units to set some basic data about unit
*********************************************************************/


class Units{
  protected int id, type;
  public String name;
  protected int level;
  protected boolean alive = true;
	protected float patk, pdef, matk, mdef, max_hp, max_mp, cur_hp, cur_mp, spd,exp;;
  protected float flat_patk, flat_pdef, flat_matk, flat_mdef, flat_max_hp, flat_max_mp, flat_spd;
	protected float hp_dec = 0, mp_dec = 0;
	protected float bonus_str = 0, bonus_con = 0, bonus_intel = 0, bonus_wis = 0, bonus_agi = 0;
	protected float bonus_patk = 0, bonus_pdef = 0, bonus_matk = 0, bonus_mdef = 0, bonus_hp = 0, bonus_mp = 0, bonus_spd = 0;

  protected int charX, charY;
  PImage img, battle_img;
	
  public Units(){

	}

  public void display(){
    image(this.img, this.charX - sqw/4, this.charY - sqh/3, sqw + sqw/4, sqh + sqh/3);
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
    this.alive = false;
  }
  
  public void ress(){
     this.alive = true;
  }
  
  //attack
  public void attack(){
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
  
  public void set_id(int x){
    this.id = x;
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

  public void set_exp(int x){
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
}
