/*******************************************
 have battle with monster
********************************************/

boolean dodge = false, esc = true;
boolean inBattle = false;
boolean show_damage = false;
int battle_UI_margin = 10;
float c_width = (width - battle_UI_margin * 5)/4, c_height = height/3 - 2 * battle_UI_margin;
float cx, cy = height*2/3 + battle_UI_margin;

/*******************************************
 calculation damage
********************************************/

void dmg(float x, int rec, int rec_type){
  show_damage = true;
  start_frame = frameCount;
  
  if(rec_type == 1){
    p[rec].dec_hp(x);
    p[rec].calc_stats();
    
    dmg_x = rec * pc_width/2.0f + pcx + pc_width/2;
    dmg_y = rec*pc_height*1.5f + pcy + pc_height;
    display_dmg = (int)x;
  }else{
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
    
      enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0;
    }
    display_dmg = (int)x;
    println((int)x);
    //println("dmg: " + m[rec].get_hp_dec());
  }
}

//def_type 1 = player, 0 = monster
void attack(int attacker, int defender, int def_type){
  
  float damage = 0.0f;
  
  if(def_type == 0){
    damage = p[attacker].get_patk() - m[defender].get_pdef();
    //println("a patk: " + p[attacker].get_patk() + " m pdef: " + m[defender].get_pdef());
  }else{
    damage = m[attacker].get_patk() - p[defender].get_pdef();
  }
  
  if(damage < 1){
    damage = 1;
  }
  
    dodge = false;
  
   //if_dodge(attacker,defender, (def_type + 1)% 2);
  
  
  if(dodge){
    
    damage = 0;
    
    dmg(damage, defender, def_type);

}
  /*
  
   
  */
  
  else{
  
    dmg(damage, defender, def_type);
  
  }
  
}


void skill(int releaser, int reciever, int def_type, int skill_id){
  float damage;
  if(def_type == 0){
    p[releaser].skills.skill[skill_id].skilldamage();
    
    switch(p[releaser].skills.skill[skill_id].dmg_type){
        // cause true damage
        case 0:              
              if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                damage = p[releaser].skills.skill[skill_id].damage;
                
                if(damage < 1){
                        damage = 1;
                      }
                
                p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,reciever,def_type);
                p[releaser].calc_stats();            
          }
              else{
                print("low mp");
              }

         break;
              // cause physical damage
        case 1:
              if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                damage = p[releaser].skills.skill[skill_id].damage-m[reciever].get_pdef();
                
                if(damage < 1){
                        damage = 1;
                      }
                
                p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,reciever,def_type);
                p[releaser].calc_stats();          
          }
              else{
                print("low mp");
              }
          break;
                // cause magical damage
        case 2:
              if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                
                damage = p[releaser].skills.skill[skill_id].damage - m[reciever].get_mdef();
                
                if(damage < 1){
                        damage = 1;
                      }
                
                p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);  
                dmg(damage,reciever,def_type);
                p[releaser].calc_stats();
            
          }
              else{
                print("low mp");
              }
              
          break;
                  // recovery mp or hp
       case 3:
             if(p[releaser].get_cur_mp() - p[releaser].skills.skill[skill_id].mp_dec >= 0){
                       if(p[releaser].skills.skill[skill_id].healing){
                         println("healing!");
                         p[releaser].rec_hp( p[releaser].skills.skill[skill_id].heal);
                         p[releaser].dec_mp( p[releaser].skills.skill[skill_id].mp_dec);
                         p[releaser].calc_stats();
                     }
                     else{
                         p[releaser].rec_mp(p[releaser].skills.skill[skill_id].heal);
                         p[releaser].dec_mp(p[releaser].skills.skill[skill_id].mp_dec);
                         p[releaser].calc_stats();
                     }          
             }
             else{
               println("low mp");
             }
           break;
                     // buff set
      case 4:
           break;
    }
  }
  
  else{
    //m[attacker].skills.skill[skill_id].skilldamage();
     println("monster use skill");
  }
}


void attackanimation(int attacker, int defender){
  //int attacker_X = p[attacker].;
  //int defender_X = p[defender].;


}

void escape(){
  
    int escape = r.nextInt(100);
    
    if(escape >= 60){
      
      inBattle = false;
      esc = true;
  
      room = map.get_map_room();
    }
    
    else{

      
      cur = (cur + 1) % (c_pt + enemy_count);
      println("escape fail, cur: " + cur);
      esc = false;
      if(battle_list[cur].get_type() == 0){
        battle_mode = -1;
      }else{
        battle_mode = 0;
      }
    
    }
      
}

void if_dodge(int attacker,int defender, int attacker_type){
    
       
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

void enemy_setup(){
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

Units[] round_order(){
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

void battle_end(){
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
    println("GAME OVER!");
    inBattle = false;
    room = 2;
  }else if(monster_dead_count == enemy_count){
    println("Victory!");
    
    
    inBattle = false;
    room = 2;
    int total_exp = 0;
    
    for(int i = 0; i < c_pt; i++)
    {
      for(int j = 0;j<enemy_count;j++)
      {
         total_exp += m[i].getExp();       
      }
      
       p[i].gainExp(total_exp);
    }
  }
    //victory or defeted
}

void display_damage(int target, int def_type){
  //println("display damage");
  fill(30,70,100);
  noStroke();
  rect(command_x - command_radius, command_y - command_radius, command_radius * 2, command_radius * 2, 20);
  
  stroke(0,100,100);
  strokeWeight(2);
  textSize(30);
  fill(0,100,100);
  if(!esc){
    text("Escape Failed!" , command_x , command_y - command_radius/2);
  }
  switch(def_type){
    case 0:
      text(battle_list[cur].name + " dealt " + display_dmg + " to " + m[target].name, command_x, command_y);
      break;
    case 1:
      text(battle_list[cur].name + " dealt " + display_dmg + " to " + p[target].name, command_x, command_y);
      break;
  }
}
