boolean doubled = false;

class Skill{
  protected int id, type, dmg_type;
  public String name; 
  public String job_name;
  protected float damage, mod, fix_dmg,last_damage,heal;
  protected float fix_rate = 1;
  public int left_round = 0;
}


/*
    type:
      1: patk
      2: matk
      3: atk buff
      4: def buff 
      5: status buff
      6: heal
      

*/

/*******************************************
 class array to store all the knight skill data
********************************************/

class Knight_skill_list extends Skill{
   
    public Skill[] skill;
    
    public Knight_skill_list(){
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
         this.name = "knight skill 1";
         
         this.type = 1;
         
         this.mod = 1.25;
         
         this.dmg_type = 1;
         
         this.damage = p[0].get_patk() * mod;    
           
    }   
  }
    
    
/*******************************************
knight skill 2 unlock at lv5
********************************************/
  
  class k_skill_2 extends Skill
  { 
    
    public k_skill_2(){
      this.name = "knight skill 2";
    }
    
    public  k_skill_2(int round){
          
          
          
          this.type = 4;
          
          this.mod = 1.5;
          
          this.left_round = round;
          
          if(this.left_round > 0){
            this.mod = 1.5;
          }
          
          else if(this.left_round == 0){
            this.mod = 1.0;          
          }
          
          p[0].pdef = p[0].bonus_pdef * this.mod;
          
          p[0].mdef = p[0].bonus_mdef * this.mod;
    } 
  }
  
  
/*******************************************
knight skill 3 unlock at lv10
********************************************/
    
    class k_skill_3 extends Skill
  { 
    public  k_skill_3(){
      this.name = "knight skill 3";
      
      this.type = 1;
      
      this.mod = 1.8;
      
      this.damage = p[0].get_patk() * this.mod;
    } 
  }
    
    
/*******************************************
knight skill 4 unlock at lv15
********************************************/
    
    class k_skill_4 extends Skill{
      
      public  k_skill_4(){
      this.name = "knight skill 4";
      }    
    }
    
/*******************************************
knight skill 5 unlock at lv20
********************************************/
    
    class k_skill_5 extends Skill{
      
      public  k_skill_5(){
      this.name = "knight skill 5";
      }    
    }
    
/*******************************************
knight skill 6 unlock at lv25
********************************************/
    
    class k_skill_6 extends Skill{
        
     public k_skill_6(){
       this.name = "knight skill 6";
     }
      
      
      
     public k_skill_6(int round){
      this.type = 1;
      
      this.left_round = round;
          
      if(this.left_round > 0){
          this.last_damage = p[0].get_patk() * 0.2;
        }
        
        else if(this.left_round == 0){
          this.last_damage = 0;        
        }
        
        else if(this.left_round == 4)
        {
          this.damage = p[0].get_patk() * this.mod;        
        }
      }   
    }

/*******************************************
 class array to store all the paladin skill data
********************************************/

class Paldain_skill_list extends Skill{
   
    Skill[] skill;
    
    public Paldain_skill_list(){
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
      
      this.type = 2;
      
      this.mod = 1.25;
      
      this.damage = p[0].get_matk() * this.mod;
  }
}


/*******************************************
paladin skill 2 unlock at lv5
********************************************/

class pal_skill_2 extends Skill {

  public  pal_skill_2(){
      
      this.type = 1;
      
      this.mod = 1.2;
      
      this.damage = p[0].get_patk() * this.mod;
      
      //stun havent added aoe
  }
}


/*******************************************
paladin skill 3 unlock at lv10
********************************************/

class pal_skill_3 extends Skill {

  public  pal_skill_3(){
      
      this.type = 4;
      
      //death = false;
  }
}

/*******************************************
paladin skill 4 unlock at lv15
********************************************/

class pal_skill_4 extends Skill {

  public  pal_skill_4(){
      
      this.type = 2;
      
      this.mod = 1.2;
      
      this.damage = p[0].get_matk() * this.mod;
  }
}

/*******************************************
paladin skill 5 unlock at lv20
********************************************/

class pal_skill_5 extends Skill {
  
  public pal_skill_5(){
  }
  
  
  public  pal_skill_5(int round){
      
      this.left_round = round;
      
      
      if(this.left_round > 0) {
        
        this.heal = p[0].max_hp * 0.2;       
      
    }
      
      if(this.left_round == 3){     
        this.damage = p[0].max_hp * 0.3;
      }
  }
}

/*******************************************
paladin skill 6 unlock at lv25
********************************************/

class pal_skill_6 extends Skill {

  public pal_skill_6(){
  }
  
  public  pal_skill_6(int round){
      
      this.type = 2;
      
      this.left_round = round;
      
      this.mod = 1.5;
      
      this.last_damage = p[0].get_matk() * 0.8 ;
      
      if(left_round > 0)
      {
        this.mod = 1.5; 
      }
      
      else{
        this.mod = 1.0;  
      }
      
      m[0].pdef = m[0].bonus_pdef * this.mod;
        
      m[0].mdef = m[0].bonus_mdef * this.mod;
      
  }
}


/*******************************************
 class array to store all the ranger skill data
********************************************/

class Ranger_skill_list extends Skill{
   
    Skill[] skill;
    
    public Ranger_skill_list(){
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
      
      this.type = 1;
      
      this.mod = 1.4;
      
      this.damage = p[0].get_patk() * this.mod;
      
    }
}

/*******************************************
ranger skill 2 unlock at lv5
********************************************/

class r_skill_2 extends Skill{
    
    public  r_skill_2(){
      
      this.type = 2;
      
      this.mod = 1.4;
      
      this.damage = p[0].get_patk() * this.mod;
      
    }
}

/*******************************************
ranger skill 3 unlock at lv10
********************************************/

class r_skill_3 extends Skill{
    
    public  r_skill_3(){      
    }
    
    public  r_skill_3(int round){
      
      this.type = 3;
      
      this.left_round = round;
      
      if(left_round > 0)
      {       
            p[0].patk = p[0].get_patk() + p[0].get_matk();
            p[0].matk = p[0].patk;
      }
      
      else{
            p[0].patk = p[0].bonus_patk;
            p[0].matk = p[0].bonus_matk; 
      }      
            
    }
}

/*******************************************
ranger skill 4 unlock at lv15
********************************************/

class r_skill_4 extends Skill{
    
    public  r_skill_4(){
      
      this.type = 1;
      
      this.mod = 1.8;
      
      this.damage = p[0].get_patk() * this.mod;    
      
    }
}

/*******************************************
ranger skill 5 unlock at lv20
********************************************/

class r_skill_5 extends Skill{
    
    public  r_skill_5(){
      
      this.type = 2;
      
      this.mod = 1.8;
      
      this.damage = p[0].get_matk() * this.mod;
      
    }
}

/*******************************************
ranger skill 6 unlock at lv25
********************************************/

class r_skill_6 extends Skill{
  
  /*
    AOE
    
    stun : boss 30 elimet: 60 nomal :80
    if()
    {
      
    }
    */
  
    
    public  r_skill_6(){
      
      this.type = 1;
      
      this.mod = 1.3;
      
      this.damage = (p[0].get_matk()+p[0].get_patk())*this.mod;
      
    }
}


/*******************************************
 class array to store all the assassin skill data
********************************************/

class Assassin_skill_list extends Skill{
   
    Skill[] skill;
    
    public Assassin_skill_list(){
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
      
      this.type = 1;
      
      this.mod = 1.4;
      
      this.damage = p[0].get_patk() * this.mod;
      
    }
}


/*******************************************
assassin skill 2 unlock at lv5
********************************************/

class a_skill_2 extends Skill{
    
    public  a_skill_2(){
      
      this.type = 1;
      
      this.mod = 1.8;
      
      this.damage = p[0].get_patk() * this.mod;     
    }
}

/*******************************************
assassin skill 3 unlock at lv10
********************************************/

class a_skill_3 extends Skill{
    
    public  a_skill_3(){
    }
    
    public  a_skill_3(int round){
      
      this.type = 3;
      
      this.left_round = round;
      
      if(this.left_round > 0)
      {
        this.mod = 1.4;
        
      }
      
      else{
        this.mod = 1.0;
      }
      
      p[0].agi = p[0].bonus_agi * this.mod;
    
    }
}

/*******************************************
assassin skill 4 unlock at lv15
********************************************/

class a_skill_4 extends Skill{
    
    public  a_skill_4(){
      
    }
    
    public  a_skill_4(int round){
      this.type = 1;
      
      this.mod = 1.2;
      
      this.left_round = round;
      
      if(this.left_round == 4)
      {
          this.damage = p[0].get_patk() * this.mod;
          // AOE        
      }
      
      else if(this.left_round == 0)
      {
        this.last_damage = 0;
      }
      
      else{
      
      this.last_damage = p[0].get_patk() * 0.2;
      
      }
    
    }
}

/*******************************************
assassin skill 1 unlock at lv20
********************************************/

class a_skill_5 extends Skill{
    
    public  a_skill_5(){
      
    }
    
    public  a_skill_5(int round){
      
      this.type = 3;
         
      this.left_round = round;
      
      if(this.left_round >0)
      {
        this.mod = 1.25;
      }
      
      else{
        this.mod = 1.0;
      }
      
      p[0].patk = p[0].bonus_patk * this.mod;
      
    
    }
}


/*******************************************
assassin skill 1 unlock at lv25
********************************************/

class a_skill_6 extends Skill{
    
    public  a_skill_6(){
      
      this.type = 1;
      
      this.mod = 2.2;
      
      this.damage = p[0].get_patk() * this.mod;       
    }
}


/*******************************************
 class array to store all the mage skill data
********************************************/

class Mage_skill_list extends Skill{
   
    Skill[] skill;
    
    public Mage_skill_list(){
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
      
      this.type = 2;
      
      this.mod = 1.4;
      
      this.damage = p[0].get_matk() * this.mod;
    
    }
}

/*******************************************
mage skill 2 unlock at lv5
********************************************/

class m_skill_2 extends Skill{
    
    public m_skill_2(){
      
      // to all
      this.type = 2;
      
      this.mod = 1.3;
      
      this.damage = p[0].get_matk() * this.mod;
    
    }
}


/*******************************************
mage skill 3 unlock at lv10
********************************************/

class m_skill_3 extends Skill{
    
    public m_skill_3(){    
    }
    
    public  m_skill_3(int round){
      
      this.type = 4;
      
      this.left_round = round;
      
      if(this.left_round > 0)
      {
        this.mod = 1.3;
        
        
        this.heal = p[0].max_mp * 0.2;        
      }
      
      else {       
        this.heal = 0;
        
        this.mod = 1.0;
      }
      
        p[0].pdef = p[0].get_pdef() * this.mod;
        
        p[0].mdef = p[0].get_mdef() * this.mod; 
        
        p[0].cur_mp += this.heal ; 
    }
}


/*******************************************
mage skill 4 unlock at lv15
********************************************/

class m_skill_4 extends Skill{
    
    public m_skill_4(){
    
    }
    
    public  m_skill_4(int round){
      
      this.type = 3;
      
      this.left_round = round;
      
      
      if(this.left_round > 0)
      {
        //stun enemy.....boss 40%
        
        this.heal = m[0].max_hp * 0.2;
      }
      
      else{
      
        this.heal = 0;
      }
      
      m[0].cur_hp += this.heal;
      
      
    
    }
}

/*******************************************
mage skill 5 unlock at lv20
********************************************/

class m_skill_5 extends Skill{
    
    public m_skill_5(){
      
      this.type = 2;
          
      if(doubled)
      {
        doubled = false;
        this.mod = 2;
      }
      
      else{
        doubled = true;
        this.mod = 1.6;
      }
      
      this.damage = p[0].get_matk() * this.mod; 
      
      //after damaged reset doubled as false
    
    }
}

/*******************************************
mage skill 6 unlock at lv25
********************************************/

class m_skill_6 extends Skill{
    
    public m_skill_6(){
      
       //AOE
      
      this.type = 2;
      
      this.mod = 1.6;
      
      this.damage = p[0].get_matk() * this.mod;
    
    }
}


/*******************************************
 class array to store all the priest skill data
********************************************/

class Priest_skill_list extends Skill{
   
    Skill[] skill;
    
    public Priest_skill_list(){
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
      
      this.type = 2;
      
      this.mod = 1.3;
      
      this.damage = p[0].get_matk() * this.mod;
    
    }
}

/*******************************************
priest skill 2 unlock at lv5
********************************************/

class pri_skill_2 extends Skill{
    
    public  pri_skill_2(){
      
      this.type = 6;
      
      this.heal = p[0].get_matk();
    
    }
}

/*******************************************
priest skill 3 unlock at lv10
********************************************/

class pri_skill_3 extends Skill{
    
    public  pri_skill_3(){
    }
      
      public  pri_skill_3(int round){
      
      this.type = 5;
      
      this.left_round = round;
      
      this.mod = 1.2;
      
      if(round > 0)
      {
        this.mod = 1.2;
      }
      
      else
      {  
        this.mod = 1.0;
      }
      
       p[0].str = p[0].bonus_str * this.mod;
       p[0].con = p[0].bonus_con * this.mod;
       p[0].intel = p[0].bonus_intel * this.mod;
       p[0].wis = p[0].bonus_wis * this.mod;
       p[0].agi = p[0].bonus_agi * this.mod;
      
    }
}

/*******************************************
priest skill 4 unlock at lv15
********************************************/

class pri_skill_4 extends Skill{
    
    public  pri_skill_4(){
      
      this.type = 6;
      
      this.mod = 0.8;      
            
      this.heal = p[0].matk * this.mod;
    
    }
}

/*******************************************
priest skill 5 unlock at lv20
********************************************/

class pri_skill_5 extends Skill{
    
    public  pri_skill_5(){
      
    }
    
    public  pri_skill_5(int round){
      //AOE
      
      this.type = 5;
      
      this.left_round = round;
      
      if(round > 0)
      {
        this.mod = 1.15;
      }
      
      else
      {  
        this.mod = 1.0;
      }
      
       p[0].str = p[0].bonus_str * this.mod;
       p[0].con = p[0].bonus_con * this.mod;
       p[0].intel = p[0].bonus_intel * this.mod;
       p[0].wis = p[0].bonus_wis * this.mod;
       p[0].agi = p[0].bonus_agi * this.mod;
         
    }
}

/*******************************************
priest skill 6 unlock at lv25
********************************************/

class pri_skill_6 extends Skill{
    
    public  pri_skill_6(){
      
      this.type = 6;      
      
      p[0].cur_hp = p[0].max_hp;
      
      p[0].cur_hp = p[0].max_mp;
      
      p[0].cur_mp = 0;
    
    }
}
