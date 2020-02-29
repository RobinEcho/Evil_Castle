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
             
             this.mod = 1.25;
               
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
              
              this.mod = 0.5;
              
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
              
             this.mod = 1.25;

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
                   this.mod = 1.2;                 
                   
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
                    
                  this.mod = 1.2;
                                 
                  
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
                    
                    this.mod = 0.2;
                    
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
                   
                this.mod = 1.25;   
                   
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
         
         this.mod = 1.2;
           
         
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
          
          this.mod = 0.2;
          
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
  
  @Override
          void skilldamage(){
              this.mp_dec = battle_list[cur].get_max_mp() * 0.5;
          }
          
          void skillUsed(){
                  
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
           
           this.mod = 1.2;
           
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
                    this.heal = p[i].get_max_hp() * 0.15;
                    
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
                
                this.mod = 0.8;
                
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
              
              this.mod = 1.4; 
                
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
            
            this.mod = 1.4; 
               
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
                 
                this.mod = 1.8;     
                     
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
                 
              this.mod = 1.8;
                   
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
                  
                  this.mod = 1.3;
                    
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
            
            this.mod = 1.4;
              
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
              
            this.mod = 1.8;
              
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
            
            this.mod = 0.4;
            
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
            this.mod = 1.2;
        
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
      
            this.mod = 0.2;
            
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
              
            this.mp_dec = battle_list[cur].get_max_mp() * 0.3;
            
            this.mod = 0.3;
            
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
              
            this.mod = 2.2;  
              
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
            
            this.mod = 1.4;  
              
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
              
            this.mod = 1.3;  
              
           
            
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
              this.heal = p[pid].get_max_mp() * 0.6;        
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
                this.heal = m[i].get_max_hp() * 0.2;
                
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
              this.mod = 1.6;
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
                
                    this.mod = 1.6;
              
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
              
            this.mod = 1.3;
                  
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
          
          this.mod = 0.2;
          
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
              
              this.mod = 0.8; 
                
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
              
              this.mod = 0.15;
              
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

    @Override
            void skilldamage(){
             
              p[pid].ress();
              
              this.heal = p[pid].get_max_mp();
              p[pid].rec_hp(p[pid].get_max_hp());
              this.mp_dec = battle_list[cur].get_max_mp() * 0.4;    
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
     
    this.mod = 1.4;
    
    this.dmg_type = 1;
}

  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.3;
    
    this.damage = m[mid].get_patk() * this.mod;    
  }
  
}

class Normal_Skill_2 extends Skill{
  
  public Normal_Skill_2(){
    
    this.monster_skill_name[0] ="Body Smash";
    
    this.monster_skill_name[1] ="Fierce Fang";
    
    this.mod = 1.6;
    
    this.dmg_type = 1;
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5;
    
    this.damage = m[mid].get_patk() * this.mod;    
  }

}

class Normal_Skill_3 extends Skill{
  
  public Normal_Skill_3(){
    
    this.monster_skill_name[0] ="Strike";
    
    this.monster_skill_name[1] ="Armorbreak";
    
    this.dmg_type = 1;
    
    this.mod = 1.8;
  }
  
   public void skilldamage(){
     
    this.mp_dec = m[mid].get_max_mp() * 0.7; 
     
    this.damage = m[mid].get_patk() * this.mod;    
  }

}

class Normal_Skill_4 extends Skill{
  
  public Normal_Skill_4(){
    
    
    this.monster_skill_name[0] ="Flame Branch";
    
    
    this.monster_skill_name[1] ="Calamity";
    
    this.mod = 1.6;
    
    this.dmg_type = 2;
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5;
    
    this.damage = m[mid].get_matk() * this.mod;    
  }

}

class Normal_Skill_5 extends Skill{
  
  public Normal_Skill_5(){
    
    this.monster_skill_name[0] ="Grumburst";
    
    this.monster_skill_name[1] ="Magical power";
    
    this.mod = 1.8;
    
    this.dmg_type = 2;
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.7;
    
    this.damage = m[mid].get_matk() * this.mod;    
  }
}

class Normal_Skill_6 extends Skill{
  
  public Normal_Skill_6(){
    
    this.monster_skill_name[0] ="rest";
    
    this.monster_skill_name[1] ="focus";
    
    this.mod = 0.3;
    
    this.healing = r.nextBoolean();
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.2;
    
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
    
    this.mod = 0.3;
    
    this.healing = r.nextBoolean();
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.1;
    
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
    
    this.mod = 0.1;
    
    this.dmg_type = 1;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5;
    
    m[mid].inc_patk(m[mid].get_patk() * this.mod);
    
    this.damage = m[mid].get_patk() * (1.1 + this.mod);
  }
}

class Elite_Skill_3 extends Skill{
  
  public Elite_Skill_3(){
    
    this.monster_skill_name[0] ="Factor conversion";
    
    this.monster_skill_name[1] ="Autophagy";
    
    this.mod = 0.25;
    
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
    
    this.mod = 1.4;
    
    this.dmg_type = 1;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.3;
    
    this.damage = m[mid].get_patk() * this.mod;
    
    for(int i = 0; i <c_pt;i++)
    {     
      if(i != mid)
      {
         hit[i] = i;
         
         this.damage = battle_list[cur].get_patk() - p[i].get_pdef();
         
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
    
    this.mp_dec = m[mid].get_max_mp() * 0.2;
    
    if(m[mid].cur_hp < m[mid].get_max_hp() * 0.5)
    {      
        this.mod = 0.3;
        
        this.healing = true;
        
        this.heal = m[mid].get_max_hp() * this.mod;  
    }
    else
    {
      this.mod = 0.5;
      
      this.healing = false;
      
      this.heal = m[mid].get_max_mp() * this.mod;  
    }
      
  }
}

class Elite_Skill_6 extends Skill{
  
  public Elite_Skill_6 (){
    
    this.monster_skill_name[0] ="Space collapse";
    
    this.monster_skill_name[1] ="Black hole devour";
    
    this.mod = 1.4;
    
    this.dmg_type = 2;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.5;
    
    for(int i = 0;i<c_pt;i++)
    {
        if(i != mid)
        {
          this.damage = battle_list[cur].get_matk() * this.mod - p[i].get_mdef();
          
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
    
    this.mod = 0.8;
    
    this.healing = true;
    
    this.dmg_type = 3;    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.2;
    
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
      
      this.mod = 1.8;
      
              
    }
    
    public void skilldamage(){
      
      this.mp_dec =  m[mid].get_max_mp() * 0.3;   
    
      this.damage = m[mid].get_matk() * this.mod;
    
  }
}

class F2_Skill_2 extends Skill{
    public F2_Skill_2(){
      
      this.name = "Parsing";
      
      this.dmg_type = 2;
      
               
    }
    
    public void skilldamage(){
      
      this.mp_dec = m[mid].get_max_mp() * 0.4; 
            
      this.mod = 1.4;
      
      this.damage = m[mid].get_matk() * this.mod;
      
      m[mid].inc_matk(m[mid].get_matk() * 0.2);      
    }
}


class F2_Skill_3 extends Skill{
    public F2_Skill_3(){
        
      this.name = "Endlessly";
      
      this.dmg_type = 3;
      
      this.mp_dec = 0;    
    }
    
    public void skilldamage(){
    
      if(m[mid].get_cur_hp() < m[mid].get_max_hp() * 0.2)
      {
        this.mod = 0.2;
        
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
      
      this.mp_dec = m[mid].get_max_mp() * 0.4; 

      this.mod = 1.2;
      
      for(int i = 0; i <c_pt;i++)
      {
        hit[i] = i;
        
        if(i != pid)
        {          
          this.damage =  battle_list[cur].get_matk() * this.mod - p[pid].get_mdef();
          
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
      
      this.mp_dec = m[mid].get_max_mp() * 0.2;
      
      this.mod = 1.4;
      
      this.damage = m[mid].get_patk() * this.mod;
    
    }
}

class F3_Skill_2 extends Skill{
    public F3_Skill_2(){
      
      this.dmg_type = 3; 
      
      this.name = "Cannibalism";
    
      
    }
    
    public void skilldamage(){
      
      this.mp_dec = m[mid].get_max_mp() * 0.3;
      
      this.mod = 1.3;
      
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
      
      this.mod = 0.6;
      
      if(m[mid].get_cur_hp() < m[mid].get_max_hp() * 0.5)
      {
         m[mid].inc_pdef(m[mid].get_pdef() * 0.2);  
      }
      else{
        
         m[mid].inc_patk(m[mid].get_patk() * 0.1);  
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
      
      this.mp_dec = m[mid].get_max_mp() * 0.6;
      
      this.mod = 1.4;
      
      for(int i = 0;i<c_pt;i++)
      {
        hit[i] = i;
        if(i != pid){
          
          this.damage = battle_list[cur].get_patk() - p[i].get_pdef();
          
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
    
    this.mp_dec = m[mid].get_max_mp() * 0.1;
    
    this.mod = 1.2;
    
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
    
    this.mp_dec = m[mid].get_max_mp() * 0.4;
    
    this.heal = m[mid].get_max_hp() * 0.1;
    
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
    
    this.heal = m[mid].get_max_mp() * 0.5;
    
    m[mid].inc_matk(m[mid].get_matk() * 0.1);  
  }
}


class F4_Skill_4 extends Skill{  
  
  public F4_Skill_4(){
    this.dmg_type = 2;
    
    this.name = "Elemental Storm";
    
    
  }
  
  public void skilldamage(){
    
    this.mp_dec = m[mid].get_max_mp() * 0.6;
    
    this.mod = 1.6;
    
    for(int i = 0; i<c_pt;i++)
    {
      hit[i] = i;
      if(i != pid)
      {
        this.damage = battle_list[cur].get_matk() * this.mod - p[i].get_mdef();
        
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
    
    this.mp_dec = m[mid].get_max_mp() * 0.1;
    
    this.mod = 1.2;
    
    
    this.damage = m[mid].get_patk() * this.mod;
  }
}

class F5_Skill_2 extends Skill{  
  
  public F5_Skill_2(){
    
    this.name = "Dark oppression";
    
    this.dmg_type = 2;
    
    
    
  }
  
   public void skilldamage(){
     
     this.mp_dec = m[mid].get_max_mp() * 0.1;
    
    this.mod = 1.2;
    
    
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
    
    this.heal = m[mid].get_max_mp() * 0.8;
    
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
    
    this.mp_dec = m[mid].get_max_mp() * 0.1;
    
    this.mod = 1.2;
    
    this.damage = m[mid].get_matk() * this.mod;
    
    for(int i = 0; i <c_pt;i++)
    {
      
      if(i != pid)
      {
         this.damage = battle_list[cur].get_matk() * this.mod - p[i].get_mdef();
         
         dmg(this.damage,i,1);
      }
      p[i].calc_stats();
    }
  this.damage = m[mid].get_matk() * this.mod;
    }
}
