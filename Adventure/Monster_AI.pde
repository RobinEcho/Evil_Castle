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
        int use_skill = r.nextInt(battle_list[cur].skillset.length);
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
        int use_skill = r.nextInt(battle_list[cur].skillset.length);
        
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
        
        for(int i = 0; i < battle_list[cur].skillset.length; i++){
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


}
