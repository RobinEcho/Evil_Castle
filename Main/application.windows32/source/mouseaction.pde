/*******************************************************************
function about mouse, set variable first, all action base on room 
*********************************************************************/
int bag_selected_x, bag_selected_y, selected_item_code;
float ogx, ogy;
int bag_x, bag_y, temp_item_code;
float skill_box_width, skill_box_height;
boolean move_item = false, select_item = false, select_target = false, usable = true;
float x, y, distance;
int command;
int empty_slots = 0;
 
 public void mousePressed(){
    
    x = mouseX;
    y = mouseY;
    
    
    switch (room)
    {
        case 0:  //  main menu
          
        
                if( (x >= side_margin - 100 && x <= side_margin+100) && (y >= height_margin-15 && y <= height_margin+15) ){
                  newGame();
                }
                
                if( (x >= side_margin - 100 && x <= side_margin+100) && (y >= height_margin+135 && y <= height_margin+165) ){
                  load();
                }
                
                if( (x >= side_margin - 50 && x <= side_margin+50) && (y >= height_margin+285 && y <= height_margin+315) ){
                  exit();
                }
                    
        break;

//---------------------------------------------------------------------------------------        

        case 1:  //  drawroom
            for(int i = 0; i < total_jobs; i++){
              if( (mouseX >= boxX && mouseX <= boxX + boxwidth) && (mouseY >= i*60+boxY+40-12.5 && mouseY < i*60+boxY+40+12.5) ){
                println("Reading job" + (i+1) + " status");
                  p_class = i+1;
                  room = 3;
              }
            }
                
              if(p_class != 0){
                p[0] = new Player(p_class);
                p[0].set_img("player_2",1);
                p[0].name = "Adam";
                p[0].set_id(0);
                
                p[0].battle_img = loadImage("src/player/battle/Player.png");
                p[0].icon = loadImage("src/player/icon/Player.png");
                p[0].avatar = loadImage("src/player/avatar/player.png");
                p[0].set_loc(800,450);
              }   
              
                //p[1] = new Player(1);
                //p[1].set_img(p[1].job.name,1);
                //p[1].set_id(1);
                //p[1].name = "Tester 1";
                
                //p[2] = new Player(1);
                //p[2].set_img(p[2].job.name,1);
                //p[2].set_id(2);
                //p[2].name = "Tester 2";
                
                //p[3] = new Player(5);
                //p[3].set_img(p[3].job.name,1);
                //p[3].set_id(3);
                //p[3].name = "Tester 3";
                //c_pt = 3;
        
        break;
        
        case 4:
          room = 2;
          break;
          
        case 8:
          room = 2;
          break;
        
 //---------------------------------------------------------------------------------------      
 /*******************************************
 */
       case 80:  //  item selct drop-down menu
         bag_select(1);
         spend_attribute_points();   
         break;
       
       
       case 81:
           if((x >= bagoptX && x<= bagoptX+bag.square_width*3) && (y >= bagoptY && y <= bagoptY+bag.square_height)){
             //println("x: " + bag_x + " y: " + bag_y);
             //println("used " + (bag_y * 5 + bag_x + 1));
             item_list[bag.inv[bag_y][bag_x]].use(pid);
             room = 80;
           
           }
           
           else if((x >= bagoptX && x<= bagoptX+bag.square_width*3) && (y > bagoptY + bag.square_height&& y <= bagoptY+bag.square_height * 2)){
             //println("droped");
             bag.inv[bag_y][bag_x] = item_count - 1;
           }
           
           else{         
             room = 80;
           }
         
       
         break;
       
       //bag full for shop
       case 84:
         room = 88;
         break;
       
       //confirm purchase
       case 86:
         in_shop = false;
         shop_set = false;
         room = 2;
         break;
       
       //confirm save
       case 87:
         in_shop = false;
         room = 2;
         break;
       
       //shop UI
       case 88:
          shop.dis_y = bag.vertical_margin + bag.vs;
          for(int i = 0; i < shop.sale_count; i++){
            if(i % 5 == 0){
              shop.dis_y += bag.vs + bag.square_height;
            }
            
            if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
              && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
              && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
                
                if(shop.sell[i] != item_list[item_count - 1]){
                  
                  for(int j = 0; j < shop.cart.length; j++){
                    if(shop.cart[j] == item_list[item_count - 1]){
                      shop.cart[j] = shop.sell[i];
                      shop.sell[i] = item_list[item_count - 1];
                    }
                  }
                }
                
            }
          }//end shop for
                  
          shop.dis_y = bag.UI_height / 2 - bag.vs;
          for(int i = 0; i < shop.sale_count; i++){
            if(i % 5 == 0){
              shop.dis_y += bag.vs + bag.square_height;
            }
            
            if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
              && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
              && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
                
                if(shop.cart[i] != item_list[item_count - 1]){
                  for(int j = 0; j < shop.sell.length; j++){
                    if(shop.sell[j] == item_list[item_count - 1]){
                      shop.sell[j] = shop.cart[i];
                      shop.cart[i] = item_list[item_count - 1];
                    }
                  }
                }
                
            }
                    
          }//end cart for
          
          //confirmation box
          if(x >= (bag.horizontal_margin + bag.square_width) && x <= (bag.horizontal_margin + bag.square_width) +  bag.square_width * 2
            && y >= (height - bag.vertical_margin - bag.square_height) && y <= (height - bag.vertical_margin - bag.square_height) + bag.square_height / 2){
              if(p[0].get_gold() >= shop.gold_req){
                empty_slots = 0;
                
                for(int i = 0; i < bag.inv.length; i++){
                  for(int j = 0; j < bag.inv[i].length; j++){
                    if(bag.inv[i][j] == item_count - 1){
                      empty_slots++;
                    }
                  }
                }
                
                if(empty_slots >= shop.buy){
                  
                  for(int i = 0; i < shop.cart.length; i++){
                    
                    for(int j = 0; j < bag.inv.length; j++){
                      
                      for(int k = 0; k < bag.inv[j].length; k++){
                        
                        if(shop.cart[i] != item_list[item_count - 1]){
                          if(bag.inv[j][k] == item_count - 1){
                            
                            for(int x = 0; x < item_list.length; x++){
                              
                              if(item_list[x].id == shop.cart[i].id){
                                bag.inv[j][k] = x;
                                j = bag.inv.length - 1;
                                k = bag.inv[j].length - 1;
                              }
                              
                            }//end for x
                            
                          }//end if
                        }//end if cart slot is empty
                        
                      }//end for k
                    }//end for j
                  }//end for i
                  
                  room = 86;
                  
                }else{
                  println("buy: " + shop.buy + " free: " + empty_slots);
                  room = 84;
                  
                }
                
              }
            }
          
          //cancel and quit box
          if(x >= (bag.horizontal_margin + bag.UI_width/2 + bag.square_width) && x <= (bag.horizontal_margin + bag.UI_width/2 + bag.square_width) +  bag.square_width * 2
            && y >= (height - bag.vertical_margin - bag.square_height) && y <= (height - bag.vertical_margin - bag.square_height) + bag.square_height / 2){
              in_shop = false;
              shop_set = false;
              room = 2;
            }
         break;
         
       //option menu for shop and save  
       case 89:
         if((x >= boxX && x <= boxX+boxwidth)&&(y >= mainY-text_height && y<= mainY+text_height)){ 
           
           //to shop UI
           in_shop = true;
           room = 88;   
           
         }
             
         if((x >= boxX && x<=boxX+boxwidth) && (y >= saveY-text_height && y<= saveY+text_height)){
                              
           saveData();
           //save confirmation
           in_shop = false;
           room = 87;
           
         }
             
         if((x >= boxX && x <= boxX+boxwidth) && (y >= exitY-text_height && y<= exitY+text_height)){
           
           //back to game
           in_shop = false;
           room = 2;
                        
         }
         break;
       
       case 90:
         switch(battle_mode){
           //player turn start
           case 0:
             battle_commands();
           break;
           
           //select attack target
           case 1:
             select_enemy_target();
             break;
             
           //use skill
           case 2:
             battle_commands();
             skill_commands();
             break;
             
           //use item
           case 3:
             bag_select(2);

             break;
             
           //select ally target
           case 4:
             select_ally_target();
             break;
             
           //monster turn
           case -1:
             println("Monster Turn!");
             break;
             
           case 10:
             //display_damage();
             break;
             
         }
        
         break;
         
       //not enough MP
       case 94:
         room = 90;
         skill = false;
         battle_mode = 0;
         break;
       
       case 98:
         //accept into party
         if(new_companion != 0){
           if(mouseX >= width*0.2 && mouseX <= width*0.2 + 100 && mouseY >= height/ 2 && mouseY <= height/ 2 + 100){
             println("yes");
             p[c_pt] = new Player(new_companion);
             c_pt++;
             npc_in_cell[new_companion - 1] = false;
             switch(new_companion){
                  case 1:
                    floor_1[2].del_npc(13, 8);
                    p[c_pt-1].name = "Knight";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;
                  
                  case 2:
                    floor_1[2].del_npc(18, 8);
                    p[c_pt-1].name = "Paladin";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;
                      
                  case 3:
                    floor_1[2].del_npc(23, 8);
                    p[c_pt-1].name = "Ranger";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;
                      
                  case 4:
                    floor_1[2].del_npc(13, 13);
                    p[c_pt-1].name = "Assassin";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;  
                  
                  case 5:
                    floor_1[2].del_npc(18, 13);
                    p[c_pt-1].name = "Mage";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;  
                    
                  case 6:
                    floor_1[2].del_npc(23, 13);
                    p[c_pt-1].name = "Priest";
                    p[c_pt-1].id = c_pt -1;
                    new_companion = 0;
                    remove_cell_key();
                    break;  
             }
                      
           }
            
           if(mouseX >= width*0.8 && mouseX <= width*0.8 + 100 && mouseY >= height/ 2 && mouseY <= height/ 2 + 100){
             println("no");
             new_companion = 0;
           }
           
           room = 2;
         }else{
           room = 2;
         }
         
         break;
       
       case 99:  //  option menu
            
             if((x >= boxX && x <= boxX+boxwidth)&&(y >= mainY-text_height && y<= mainY+text_height)){ 
               opt = false;
               room = 0;                                         
             }
             
             if((x >= boxX && x<=boxX+boxwidth) && (y >= saveY-text_height && y<= saveY+text_height)){
                              
               load();
             
             }
             
             if((x >= boxX && x <= boxX+boxwidth) && (y >= exitY-text_height && y<= exitY+text_height)){
               
               exit();
                        
             }
         
         break;
         
         
         case 900:
         case 999:
           exit();
           break;
        
    } //close switch
    
  }  //close mousePressed()
  
  
 // sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
 // sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
 
 //bag_x = (int) ( (ogx - ((width + bag.UI_dis)/2) - bag.hs) / (bag.hs + bag.square_width));
 //bag_y = (int) ( (ogy - bag.vertical_margin - bag.vs) / (bag.vs + bag.square_height));
  
void mouseDragged(){
  if(select_item && room == 80){
    move_item = true;
    
    image(item_list[temp_item_code].img, mouseX - (bag.square_width/2), mouseY - (bag.square_height/2), bag.square_width, bag.square_height);
    //room = 80;
  }
}
  
void mouseReleased(){
  float sqx, sqy;
  
  switch(room){
    
    case 80:
    if(move_item){
            
          for(int i = 0; i < bag.row; i++){
            for(int j = 0; j < bag.col; j++)
            {
              sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
              sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
              
               if( (mouseX >= sqx && mouseX <= sqx + bag.square_width)  && (mouseY >=  sqy && mouseY <= sqy + bag.square_height) )
               {
                 if(i == bag_y && j == bag_x){
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   if(bag.inv[i][j] != item_count - 1){
                     bagoptX = mouseX+bag.hs;
                     bagoptY = mouseY;
                   }
                 }else{
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   bag.inv[i][j] ^= bag.inv[bag_y][bag_x];
                   bag.inv[bag_y][bag_x] ^= bag.inv[i][j];
                   bag.inv[i][j] ^= bag.inv[bag_y][bag_x];
                   
                 }
                 
                 move_item = false;
                 select_item = false;
                 
               }
               else{
                 if(move_item){
                   bag.inv[bag_y][bag_x] = temp_item_code;
                 }
               }
               move_item = false;
               select_item = false;
            }
          }
      }else{
        if(select_item){
        for(int i = 0; i < bag.row; i++){
            for(int j = 0; j < bag.col; j++)
          {
            sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
            sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
            
             if(mouseX >= sqx && mouseX <= sqx + bag.square_width  && mouseY >=  sqy && mouseY <= sqy + bag.square_height)
             {
               if(select_item){
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   select_item = false;
                 }
               if(bag.inv[i][j] != item_count -1){
                 
                 bagoptX = mouseX+bag.hs;
                 bagoptY = mouseY;
                 room = 81;
               }
             }
          }
        }
    }
  }
  break;
  }
}

void battle_commands(){
  //attack
  distance = (float) ( Math.sqrt(( (x - command_x) * (x - command_x) + (y - (command_y - command_radius)) * (y - (command_y - command_radius)) ) ) );
             if(distance <= command_radius / 2.0){
               //attack(0,0,0);
               //println("pa: " + p[0].get_patk() + " md: " + m[0].get_pdef());
               //println("dmg: " + (p[0].get_patk() -  m[0].get_pdef()));
               //println("attack! " + m[0].get_cur_hp() + " hp down: " + m[0].get_hp_dec());
               battle_mode = 1;
               command = 6;
               //if(m[0].get_cur_hp() <= 0){
               //  println("dead!");
               //}
             }
             
             //skill
             distance = (float) ( Math.sqrt(( (x - (command_x + command_radius)) * (x - (command_x + command_radius)) + (y - command_y) * (y - command_y) ) ) );
             if(distance <= command_radius / 2.0){
               println("skill!");
               battle_mode = 2;
             }
             
             //item
             distance = (float) ( Math.sqrt(( (x - (command_x - command_radius)) * (x - (command_x - command_radius)) + (y - command_y) * (y - command_y) ) ) );
             if(distance <= command_radius / 2.0){
               println("item!");
               battle_mode = 3;
             }
             
             //flee
             distance = (float) ( Math.sqrt(( (x - command_x) * (x - command_x) + (y - (command_y + command_radius)) * (y - (command_y + command_radius)) ) ) );
             if(distance <= command_radius / 2.0){
               escape();
             }
}

void skill_commands(){
  for(int i = 0; i < p[battle_list[cur].get_id()].skills.skill_count; i++){
                if(x >= command_x + command_radius * 1.5 + battle_UI_margin && x <= command_x + command_radius * 1.5 + battle_UI_margin + skill_box_width 
                  && y >= (command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5))) && y <= (command_y + (skill_box_height * (i - 2) + battle_UI_margin * (i - 1.5))) + skill_box_height){
                    //println("use skill " + (i+1));
                    command = i;
                    
                    if(p[battle_list[cur].get_id()].skills.skill[i].type == 2){
                      battle_mode = 1;
                    }else{
                      battle_mode = 4;
                    }
                }
              }
   
  if(battle_mode != 1 && battle_mode != 4){
    battle_mode = 0;
  }
}

void bag_select(int bag_mode){
   select_item = false;
   usable = true;
   
   switch(bag_mode){
     case 1:
          ogx = x;
          ogy = y;
          float sqx, sqy;
          
          for(int i = 0; i < bag.row; i++){
            for(int j = 0; j < bag.col; j++)
            {
              sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
              sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
              
               if(x >= sqx && x <= sqx + bag.square_width  && y >=  sqy && y <= sqy + bag.square_height)
               {
                 if(bag.inv[i][j] < item_count - 4){
                   bag_x = j;
                   bag_y = i;
                   temp_item_code = bag.inv[i][j];
                   bag.inv[i][j] = item_count - 1;
                   select_item = true;
                 }
               }
            }
          }
        
        //select player equipment
        for(int n=1 ; n <=p[0].Wpsq_num ; n++ ){
          sqx = p[0].horizontal_margin + p[0].sq_distance + n*p[0].Wp_distance + (n-1)*p[0].Wpsq_sl;
          sqy = p[0].vertical_margin + p[0].Avatarsq_sl + 2*p[0].sq_distance + 3*p[0].Wpsq_sl;
          
          if(x >= sqx && x <= sqx + p[0].Wpsq_sl && y >= sqy && y <= sqy + p[0].Wpsq_sl){
            
            if(p[pid].equipment[n-1] != item_count - 1){
              for(int i = 0; i < bag.row; i++){
                for(int j = 0; j < bag.col; j++){
                  if(bag.inv[i][j] == item_count -1){
                    item_list[bag.inv[i][j]].update_player_bonus(pid, p[pid].equipment[n-1], bag.inv[i][j]);
                    bag.inv[i][j] = p[pid].equipment[n-1];
                    p[pid].equipment[n-1] = item_count - 1;
                  }
                }
              }
            }
            
          }
        }
        
       //change player stats on display
       for(int n = 1; n <= p[0].Avatarsq_num; n++){
         if(mouseX >= (p[0].horizontal_margin + n*p[0].sq_distance + (n-1)*p[0].Avatarsq_sl)
           && mouseX <= (p[0].horizontal_margin + n*p[0].sq_distance + (n-1)*p[0].Avatarsq_sl) + p[0].Avatarsq_sl
           && mouseY >= (p[0].vertical_margin + p[0].strip_distance) && mouseY < (p[0].vertical_margin + p[0].strip_distance) + p[0].Avatarsq_sl){
             if(n-1 < c_pt){
               pid = n-1;
             }
         }
        } 
       break;
     case 2:
               for(int i = 0; i < bag.row; i++){
                for(int j = 0; j < bag.col; j++)
                {
                  if(i > bag.row / 2 - ((bag.row + 1) % 2)){
                    if(x >= ((j+1)*bag.hs + (j*bag.square_width) + width/2) && x <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 + bag.square_width)
                      && y >= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin 
                      && y <= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin + bag.square_height){
                        if(bag.inv[i][j] != item_count - 1){
                          if(item_list[bag.inv[i][j]].id < 40){
                            //println("usable");
                            bag_selected_x = j;
                            bag_selected_y = i;
                            selected_item_code = bag.inv[i][j];
                            
                            usable = true;
                            select_item = true;
                            battle_mode = 4;
                            command = 7;
                          }else{
                            select_item = true;
                            usable = false;
                            battle_mode = 3;
                          }
                          //println("right side item: " + bag.inv[i][j]);
                        }
                    }
                  }else{
                    if(x >= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width) && x <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width + bag.square_width) 
                      && y >= ( ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin ) && y <= ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin + bag.square_height){
                        if(bag.inv[i][j] != item_count - 1){
                          if(item_list[bag.inv[i][j]].id < 40){
                            //println("usable");
                            bag_selected_x = j;
                            bag_selected_y = i;
                            selected_item_code = bag.inv[i][j];
                            
                            usable = true;
                            select_item = true;
                            battle_mode = 4;
                            command = 7;
                          }else{
                            select_item = true;
                            usable = false;
                            battle_mode = 3;
                          }
                          //println("left side item: " + bag.inv[i][j]);
                        }
                      }
                  }
                  
                }    //for loop(j)
              }    //for loop (i)
              
              if(!select_item){
                battle_mode = 0;
              }
       break;
   }
}

void select_enemy_target(){
  select_target = false;
  float x_dis, y_dis;
  enemy_x = enemy_start_x + enemy_width * m[mid].get_mod();
        enemy_y = enemy_start_y;
        target_diameter = (float)Math.sqrt( 2*(Math.pow((double)enemy_width,2.0)) );
        strokeWeight(3);
        stroke(0,100,100);
        fill(0,100,100,0);
        
        for(int i = 0; i < enemy_count; i++){
          if(i > 0){
            if(i % 2 == 0){
              enemy_x += enemy_width * m[i-1].get_mod();
            }else{
              enemy_x -= enemy_width * m[i-1].get_mod();
            }
          }
          x_dis = x - (enemy_x + enemy_width/2.0f * m[i].get_mod());
          y_dis = y - (enemy_y + enemy_height/2.0 * m[i].get_mod());
          
            distance = (float)Math.sqrt(x_dis * x_dis + y_dis * y_dis);
            if(distance <= target_diameter * m[i].get_mod() / 2){
              if(m[i].is_alive()){
                if(command == 6){
                  select_target = true;
                  attack(pid, i, 0);
                }else{
                  select_target = true;
                  skill(pid, i, 0, command);
                }
              }
            }
          
          
          enemy_y += enemy_height * m[i].get_mod() + enemy_height/2.0;
        }
        
  if(!select_target){
    battle_mode = 0;
  }else{
    battle_mode = 10;
  }
}

/********************************************
*  Select ALLY
********************************************/
void select_ally_target(){
  select_target = false;
  for(int i = 0; i < c_pt; i++){
    cx = c_width*i + (i+1)*battle_UI_margin;
    if(x >= cx && x <= cx + c_width && y >= cy & y <= cy + c_height){
      
      //Use Item
      if(command == 7){
        if(item_list[selected_item_code].id != 39){
          if(p[i].is_alive()){
            p[i].rec_hp(item_list[selected_item_code].get_rec_hp());
            p[i].rec_mp(item_list[selected_item_code].get_rec_mp());
            p[i].calc_stats();
            
            select_item = false;
            
            bag.inv[bag_selected_y][bag_selected_x] = item_count - 1;
            
            select_target = true;
            battle_mode = 0;
          }else{
            select_item = false;
            select_target = false;
            battle_mode = 0;
          }
          
        //use revive
        }else{
          if(!p[i].is_alive()){
            p[i].ress();
            p[i].rec_hp(item_list[selected_item_code].get_rec_hp());
            p[i].calc_stats();
            
            select_item = false;
            
            bag.inv[bag_selected_y][bag_selected_x] = item_count - 1;
            
            select_target = true;
            battle_mode = 0;
          }else{
            select_item = false;
            select_target = false;
            battle_mode = 0;
          }
        }
      
      //use skill
      }else{
        
        switch(battle_list[cur].skills.skill[command].type){
            //use on self only
            case 0:
              if(p[i] == battle_list[cur]){
                select_target = true;
                skill(battle_list[cur].get_id(), i, 0, command);
              }else{
                battle_mode = 0;
                select_target = false;
              }
              break;
            
            //use on ally
            case 1:
              //priest revive
              if(p[battle_list[cur].get_id()].job_code == 6 && command == 5){
                if(!p[i].is_alive()){
                    select_target = true;
                    skill(battle_list[cur].get_id(), i, 0, command);
                }
                
              //other skills
              }else{
                if(p[i].is_alive()){
                    select_target = true;
                    skill(battle_list[cur].get_id(), i, 0, command);
                }  
              }
              break;
        }
      }
    }
  }
  
  if(!select_target){
    select_item = false;
    battle_mode = 0;
  }else{
    battle_mode = 10;
  }
}

/****************************************
*  use AP
****************************************/
void spend_attribute_points(){
  if(p[pid].AP > 0){
    for(int i = 0; i < p[0].Strip_num; i++){
      if(x >= (p[0].horizontal_margin + p[0].sq_distance + p[0].Strip_width + p[0].sq_distance)
        && x <= (p[0].horizontal_margin + p[0].sq_distance + p[0].Strip_width + p[0].sq_distance) + p[0].addsq_sl
        && y >= (p[0].vertical_margin + p[0].Avatarsq_sl + 13*p[0].strip_distance + i*p[0].sq_distance)
        && y <= (p[0].vertical_margin + p[0].Avatarsq_sl + 13*p[0].strip_distance + i*p[0].sq_distance) + p[0].addsq_sl){
          switch(i){
            case 0:
              //println("inc str");
              p[pid].set_flat_str(p[pid].get_flat_str() + 1);
              p[pid].AP--;
              break;
            case 1:
            //println("inc con");
              p[pid].set_flat_con(p[pid].get_flat_con() + 1);
              p[pid].AP--;
              break;
            case 2:
            //println("inc int");
              p[pid].set_flat_intel(p[pid].get_flat_intel() + 1);
              p[pid].AP--;
              break;
            case 3:
            //println("inc wis");
              p[pid].set_flat_wis(p[pid].get_flat_wis() + 1);
              p[pid].AP--;
              break;
            case 4:
            //println("inc agi");
              p[pid].set_flat_agi(p[pid].get_flat_agi() + 1);
              p[pid].AP--;
              break;
          }
          
          p[pid].calc_stats();
        }
    }
  }
  
}

void not_usable(){
  //println("NOT usable");
  fill(8, 100, 100);
  textSize(25);
  stroke(8, 100, 100);
  strokeWeight(2);
  text("This item cannot be used in battle!", width/2, bag.vertical_margin / 2);
}
