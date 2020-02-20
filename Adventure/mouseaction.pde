/*******************************************************************
function about mouse, set variable first, all action base on room 
*********************************************************************/
int trial = 0;
float ogx, ogy;
int bag_x, bag_y, temp_item_code;
boolean move_item = false, select_item = false;
 
 public void mousePressed(){
    
    float x = mouseX;
    float y = mouseY;
    float distance;
    
    switch (room)
    {
        case 0:  //  main menu
          
        
                if( (x >= side_margin && x <= side_margin+200) && (y >= height_margin-60 && y <= height_margin) ){
                  newGame();
                }
                
                if( (x >= side_margin && x <= side_margin+200) && (y >= height_margin+140 && y <= height_margin+200) ){
                  load();
                }
                
                if( (x >= side_margin && x <= side_margin+200) && (y >= height_margin+340 && y <= height_margin+400) ){
                  exit();
                }
                    
        break;

//---------------------------------------------------------------------------------------        

        case 1:  //  drawroom
            for(int i = 0; i < total_jobs; i++){
              if( (mouseX >= boxX && mouseX <= boxX + boxwidth) && (mouseY >= i*60+boxY+40-12.5 && mouseY < 0*60+boxY+40+12.5) ){
                println("Reading job1 status");
                  p_class = 1;
                  map.drawmap(1);
              }
            }
                
              if(p_class != 0){
                p[0] = new Player(p_class);
                p[0].set_img(p[0].job.name,1);
                p[0].set_loc(400,450);
              }
                
        
        break;
        
 //---------------------------------------------------------------------------------------      
 /*******************************************
 */
       case 90:
         /*
         switch(mode){
           case 1:
             break;
         }
         */
         distance = (float) ( Math.sqrt(( (x - command_x) * (x - command_x) + (y - (command_y + command_radius)) * (y - (command_y + command_radius)) ) ) );
         if(distance <= command_radius / 2.0){
           escape();
         }
         break;
         
       case 91:  //  item selct drop-down menu
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
               if(bag.inv[i][j] > 0){
                 bag_x = j;
                 bag_y = i;
                 temp_item_code = bag.inv[i][j];
                 bag.inv[i][j] = 0;
                 select_item = true;
               }
             }
          }
    }
            
            
       
           break;
       
       
       case 98:
           if((x >= bagoptX && x<= bagoptX+bag.square_width*3) && (y >= bagoptY && y <= bagoptY+bag.square_height)){
             
             println("used");
           
           }
           
           else if((x >= bagoptX && x<= bagoptX+bag.square_width*3) && (y > bagoptY + bag.square_height&& y <= bagoptY+bag.square_height * 2)){
             println("droped");
             
           }
           
           else{         
             room = 91;
           }
         
       
         break;
       
       
       case 99:  //  option menu
            
             if((x >= boxX && x <= boxX+boxwidth)&&(y >= mainY-text_height && y<= mainY+text_height)){ 
               opt = false;
               room = 0;               
                          
             }
             
             if((x >= boxX && x<=boxX+boxwidth) && (y >= saveY-text_height && y<= saveY+text_height)){
                              
               saveData();
             
             }
             
             if((x >= boxX && x <= boxX+boxwidth) && (y >= exitY-text_height && y<= exitY+text_height)){
               
               exit();
                        
             }
         
         break;
        
    } //close switch
    
  }  //close mousePressed()
  
  
 // sqx = (j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2;
 // sqy = (i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin;
 
 //bag_x = (int) ( (ogx - ((width + bag.UI_dis)/2) - bag.hs) / (bag.hs + bag.square_width));
 //bag_y = (int) ( (ogy - bag.vertical_margin - bag.vs) / (bag.vs + bag.square_height));
  
void mouseDragged(){
  if(select_item){
    move_item = true;
    
    image(item_pic[temp_item_code], mouseX - (bag.square_width/2), mouseY - (bag.square_height/2), bag.square_width, bag.square_height);
    
  }
}
  
void mouseReleased(){
  float sqx, sqy;
  
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
                   if(bag.inv[i][j] > 0){
                     bagoptX = mouseX+bag.hs;
                     bagoptY = mouseY;
                     room = 98;
                   }
                 }else{
                   bag.inv[bag_y][bag_x] = temp_item_code;
                   bag.inv[i][j] ^= bag.inv[bag_y][bag_x];
                   bag.inv[bag_y][bag_x] ^= bag.inv[i][j];
                   bag.inv[i][j] ^= bag.inv[bag_y][bag_x];
                   
                 }
                 
                 move_item = false;
                 
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
               if(bag.inv[i][j] > 0){
                 
                 bagoptX = mouseX+bag.hs;
                 bagoptY = mouseY;
                 room = 98;
                 select_item = false;
               }
             }
          }
    }
  }
}
