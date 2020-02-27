boolean doubled = false;

class Skill{
  Skill[] skill;
  public int id, type, dmg_type;
  public String name; 
  public String job_name;
  public float origin_status,damage, mod, fix_dmg,heal,mp_dec;
  public float fix_rate = 1;
  public int round_count = 0;
  public boolean healing = false,buff_Set = false;
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
         
         this.type = 2;
         
         this.dmg_type = 1;
         
         this.mp_dec = 13;        
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
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 20;
      
      this.round_count = 4;
    }
    
  
  @Override  
            public void skillUsed(){
             
              this.mod = 0.5;
              
              p[pid].buff_list[0] = this.mod;
              
              p[pid].buff_round[0] = this.round_count;        
          }
}
  
/*******************************************
knight skill 3 unlock at lv10
********************************************/
    
    class k_skill_3 extends Skill
  { 
    public  k_skill_3(){
      this.name = "War stomp";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 36;

    }
    
    @Override
             public void skilldamage(){
              
             this.mod = 1.25;
             
             this.damage = p[pid].get_patk() * this.mod;
             
             for(int i = 0; i < enemy_count; i++){
               dmg(this.damage,i,0);
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
      
      this.mp_dec = 51;
      }
      
      @Override
               public void skillUsed(){
                 
                 this.round_count = 1;
                 this.mod = 75.0;
                 
                 p[pid].buff_list[1] = this.mod;
                 p[pid].buff_round[1] = this.round_count;            
              }
}
    
/*******************************************
knight skill 5 unlock at lv20
********************************************/
    
    class k_skill_5 extends Skill{
      
      public  k_skill_5(){
      
      this.name = "Combat focus";
      
      this.type = 0;
      
      this.dmg_type = 4;      
      
      this.round_count = 3;
            
      this.mp_dec = 68;
      
      
      }
      
       @Override
                 public void skillUsed(){
                   this.mod = 1.2;                 
                   
                   p[pid].buff_list[2] = this.mod;
                   
                   p[pid].buff_round[2] = this.round_count;                                          
                }
}
    
/*******************************************
knight skill 6 unlock at lv25
********************************************/
    
    class k_skill_6 extends Skill{
        
     public k_skill_6(){
       this.name = "Frey's Crest";
       
       this.type = 2;
        
       this.dmg_type = 4;
       
       this.mp_dec = 80;
     }
      
      @Override
                public void skilldamage(){
                    
                  this.mod = 2.2;
                  this.damage = p[pid].get_patk() * this.mod;
                  for(int i = 0; i < enemy_count; i++)
                    {         
                       dmg(this.damage,i,0);
                    }
                  }
                
                public void skillUsed(){
                 
                    p[pid].buff_list[3] = 0.2;
                    
                    p[pid].buff_round[3] = this.round_count;  
               
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
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 21;
                
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
    
      this.type = 2;
      
      this.round_count = 1;
      
      this.dmg_type = 4;
      
      this.mp_dec = 39;
          
  }
  
  @Override
         public void skilldamage(){  
         
         this.mod = 1.2;
           
         this.damage = p[pid].get_patk() * this.mod;
         
         for(int i = 0; i< enemy_count;i++)
         {
           dmg(this.damage,i,0);
         }
  }
        public void skillUsed(){
          
          this.mod = 50.0;
          
          p[pid].buff_list[4] = this.mod;
          
          p[pid].buff_round[4] = this.round_count;  
        }
}


/*******************************************
paladin skill 3 unlock at lv10
********************************************/

class pal_skill_3 extends Skill {

  public  pal_skill_3(){
      
      this.name = "kiss of Hel";  
    
      this.type = 1;
      
      this.dmg_type = 4;
      
      this.round_count = 5;
  }
  
  @Override
          void skilldamage(){
              this.mp_dec = p[pid].get_max_mp() * 0.5;
          }
          
          void skillUsed(){
                  this.mod = 100.0;
                  
                  p[pid].buff_list[5] = this.mod;
                  
                  p[pid].buff_round[5] = this.round_count; 
          }
}

/*******************************************
paladin skill 4 unlock at lv15
********************************************/

class pal_skill_4 extends Skill {

  public  pal_skill_4(){
    
    this.name = "Holy light"; 
    
    this.type = 2;
      
    this.dmg_type = 2;  
      
    this.mp_dec = 73;
           
  }
  
  @Override
           public void skilldamage(){   
           
           this.mod = 1.2;
           
           this.damage = p[pid].get_matk() * this.mod;
           
           for(int i = 0;i<enemy_count;i++)
           {
             dmg(this.damage,i,0);
           }
  }
  
}

/*******************************************
paladin skill 5 unlock at lv20
********************************************/

class pal_skill_5 extends Skill {
  
  public pal_skill_5(){
    
    this.name = "Striker codex";
    
    this.type = 0;
    
    this.dmg_type = 4;
    
    this.mp_dec = 85;
    
    this.healing = true;
  }
  
  
  
  
  @Override//aoe heal
            public void skillUsed(){
                
                  this.round_count = 3;
          
                  
                  this.heal = p[pid].get_max_hp() * 0.15;
                  
                  p[pid].buff_list[6] = this.heal;
                  
                  p[pid].buff_round[6] = this.round_count;
                 }
}

/*******************************************
paladin skill 6 unlock at lv25
********************************************/

class pal_skill_6 extends Skill {

  public pal_skill_6(){
    this.name = "Sleepy shield";
    
    this.type = 2;    
    
    this.dmg_type = 4;
    
    this.mp_dec = 143;
  }

  @Override
            public  void skillUsed(){
                
                this.mod = 50.0;
              
                this.round_count = 2;
                
                //skip round sleepy shiled
                p[pid].buff_list[7] = this.mod;
                
                p[pid].buff_round[7] = this.round_count; 
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
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 4;
            
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
      this.name = "Wind arrow"; 
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 10;    
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
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 22;
      
      this.round_count = 3;
    }

    @Override
              public  void skillUsed(){
                
                this.mod = p[pid].get_patk() + p[pid].get_matk();
                
                //set patk and matk as mod
                
                p[pid].buff_list[8] = this.mod;
                
                p[pid].buff_round[8] = this.round_count;
              }
}

/*******************************************
ranger skill 4 unlock at lv15
********************************************/

class r_skill_4 extends Skill{
    
    public  r_skill_4(){

      this.name = "Steel shot";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 34;
      
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
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 48;
      
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
  
  /*
    AOE
    
    stun : boss 30 elimet: 60 nomal :80
    if()
    {
      
    }
    */
  
    
    public  r_skill_6(){
      
      this.name = "Flame twine";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 57;      
    }
    
    @Override
                  public void skilldamage(){
                  
                  this.mod = 1.3;
                    
                  this.damage = (p[pid].get_matk()+p[pid].get_patk())*this.mod;
                  
                      for(int i = 0;i < enemy_count; i++)
                      {
                        dmg(this.damage,i,0);
                      }
                    }
              
              public void skillUsed(){
                  this.round_count = 2;
                  this.mod = 50.0;
                  
                  //skip round
                  p[pid].buff_list[9] = this.mod;
                  p[pid].buff_round[9] = this.round_count;
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
      
      this.name = "Pursuit";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 10;
      
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
      
      this.name = "Back thorn";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
      this.mp_dec = 22;
   
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
      this.name = "Absorbed";
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 39;
      
      this.round_count = 1;
    }

 @Override
          public  void skillUsed(){
                     
            this.mod = 0.4;
            
            p[pid].buff_list[10] = this.mod;
            
            p[pid].buff_round[10] = this.round_count;          
          }
}

/*******************************************
assassin skill 4 unlock at lv15
********************************************/

class a_skill_4 extends Skill{
    
    public  a_skill_4(){
      this.name = "Shadow thorn";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 59;
      
    }

@Override    
          public  void skilldamage(){
            this.mod = 1.2;
            
            this.damage = p[pid].get_patk() * this.mod;
            
            for(int i = 0; i < enemy_count; i++){
              dmg(this.damage,i,0);
              } 
            }
          
          public  void skillUsed(){
            
            this.round_count = 4;
      
            this.mod = 0.2;
            
            p[pid].buff_list[11] = this.mod;
            
            p[pid].buff_round[11] = this.round_count;     
            }
}

/*******************************************
assassin skill 1 unlock at lv20
********************************************/

class a_skill_5 extends Skill{
    
    public  a_skill_5(){
      this.name = "Shadow world";
      
      this.type = 0;
      
      this.dmg_type = 4;
      
      this.mp_dec = 82;
    }

    
@Override
            public  void skillUsed(){
            
            this.mod = 1.2;
            
            this.round_count = 1;
            
            p[pid].buff_list[12] = this.mod;
            
            p[pid].buff_round[12] = this.round_count;
          
          }
}


/*******************************************
assassin skill 1 unlock at lv25
********************************************/

class a_skill_6 extends Skill{
    
    public  a_skill_6(){
      this.name = "Left me to the moon";
      
      this.type = 2;
      
      this.dmg_type = 1;
      
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
      
      this.name = "Flame bomb";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 10;
          
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
      
      // to all
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 38;
   
    }
    
    @Override
            public void skilldamage(){
              
            this.mod = 1.3;  
              
            this.damage = p[pid].get_matk() * this.mod;
            
            for(int i = 0; i<enemy_count;i++)
            {
              dmg(this.damage,i,0);
            }
        }
}


/*******************************************
mage skill 3 unlock at lv10
********************************************/

class m_skill_3 extends Skill{
    
    public m_skill_3(){
      this.name = "Requiem";
      
      this.type = 0;
      
      this.dmg_type = 3;
      
      this.mp_dec = 50;
      
      this.healing = false;
    }

@Override  
          public void skilldamage(){        
              this.heal = p[pid].get_max_mp() * 0.3;        
            }
}


/*******************************************
mage skill 4 unlock at lv15
********************************************/

class m_skill_4 extends Skill{
    
    public m_skill_4(){
      this.name = "Blizzard";
      
      this.type = 2;
      
      this.dmg_type = 4;
      
      this.mp_dec = 72;
    }

@Override    
          public  void skillUsed(){
      
            this.round_count = 3;
            
            this.mod = 50.0;
            
            //skip round
            
            p[pid].buff_list[13] = 50.0;
            
            p[pid].buff_round[13] = this.round_count;
          }
}

/*******************************************
mage skill 5 unlock at lv20
********************************************/

class m_skill_5 extends Skill{
    
    public m_skill_5(){
      
      this.name = "Karma";
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 89;          

    
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
      
       //AOE
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 150;

    }
    
    @Override
              public void skilldamage(){
                
              this.mod = 1.6;
                
              this.damage = p[pid].get_matk() * this.mod;
              
              for(int i = 0; i<enemy_count;i++){
              
                dmg(this.damage,i,0);          
              }
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
      
      this.type = 2;
      
      this.dmg_type = 2;
      
      this.mp_dec = 30;
    
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
      
      this.type = 1;
      
      this.dmg_type = 3;
      
      this.healing = true;
      
      this.mp_dec = 40;
    }
    
    @Override
            public void skilldamage(){
              
            this.heal = p[pid].get_matk();
        }
}

/*******************************************
priest skill 3 unlock at lv10
********************************************/

class pri_skill_3 extends Skill{
    
    public  pri_skill_3(){
      this.name = "San.Light";
      
      this.type = 1;
      
      this.dmg_type = 4;
      
      this.mp_dec = 80;
    }

@Override            
          public  void skillUsed(){
        
          this.round_count = 4;
          
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
      
      this.type = 0;
      
      this.dmg_type = 3;
      
      this.healing = true;
      
      this.mp_dec = 100;
  
    }
    
    @Override
              public void skilldamage(){
              
              this.mod = 0.8; 
                
              this.heal = p[pid].matk * this.mod;
            }
}

/*******************************************
priest skill 5 unlock at lv20
********************************************/

class pri_skill_5 extends Skill{
    
    public  pri_skill_5(){
      this.name = "Well of radiance";
      
      this.type = 0;      
      
      this.dmg_type = 4;
      
      this.mp_dec = 112;
    }
    
    @Override
            public  void skillUsed(){
              //AOE
              
              this.round_count = 4;
              
              this.mod = 0.15;
              
              p[pid].buff_list[15] = this.mod;
              
              p[pid].buff_round[15] = this.round_count;
            }
}

/*******************************************
priest skill 6 unlock at lv25
********************************************/

class pri_skill_6 extends Skill{
    
    public  pri_skill_6(){
      
      this.name = "Nirvana";
      
      this.type = 1;
      
      this.dmg_type = 3;
      
      this.healing = true;
  
    }

    @Override
            void skilldamage(){
             
              this.heal = p[pid].get_max_hp();
              
              p[pid].ress();
              
              this.mp_dec = p[pid].get_max_mp() * 0.4;    
          }
}
