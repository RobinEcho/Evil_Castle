/*******************************************
key system inside game
********************************************/ 
  Random r = new Random();
  boolean battle_end = false;
  int round = 1, pid = 0, mid = 0, cur = 0;
  int enemy_count, elite_count;


/*******************************************
move function, link to keyaction
********************************************/ 

void move() {
  
  if(up){
        p[0].set_y(p[0].charY - 45);
        steps++;
      }
      
      if(down){
        p[0].set_y(p[0].charY + 45);
        steps++;
      }
      
      if(right){
        p[0].set_x(p[0].charX + 40);
        steps++;
      }
      
      if(left){
        p[0].set_x(p[0].charX - 40);
        steps++;
      }
}                    //close move()
/*----------------------------------------------------------------------------------------------*/

     /* friendly_unit = 1 monster: 1-2
        friendly_unit = 2 monster: 2-3
        friendly_unit = 3 monster: 3-4
        
     
      */
void monsterappear() {
  if(room < 80)
  {
    
      encounter   = steps + r.nextInt(20);
      
      if(encounter >= 60){
        cur = 0;
        round = 1;
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
          if(floor > 4){
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
        
        pid = 0;
        battle_mode = 0;
        //  if(order[cur].get_type() == 1){
        //    pid = order[cur].get_id();
            
        //    battle_mode = 0;
        //  }else{
        //    mid = order[cur].get_id();
            
        //    battle_mode = -1;
        //  }
    }
  }  
}                    //close monsterappear()
