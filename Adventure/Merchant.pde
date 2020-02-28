boolean in_shop = false;

class Merchant{
  int item_code, rand;
  int sale_count = 10;
  Item[] sell = new Item[sale_count];
  Item[] cart = new Item[sale_count];
  int empty_slots = 0;
  int gold_req = 0;
  float dis_y;
  
  public Merchant(){
    
  }
  
  public void set_up(int floor){
    for(int i = 0; i < sell.length; i++){
      rand = r.nextInt((item_count - 4) * 3) % (item_count - 4);
      
      if(item_list[rand].level <= (floor - 1) * 5){
        sell[i] = item_list[rand];
      }else{
        i--;
      }
    }
    
    shop_set = true;
  }
  
  //shop display
  public void display_shop(){
    this.empty_slots = 0;
    this.gold_req = 0;
    
    for(int i = 0; i < bag.inv.length; i++){
      for(int j = 0; j < bag.inv[i].length; j++){
        this.empty_slots++;
      }
    }
    
    if(!shop_set){
      set_up(floor);
      for(int i = 0; i < sale_count; i++){
        cart[i] = item_list[item_count - 1];
      }
    }
    
    
    
    noStroke();
    fill(40, 100, 100);
    rect(bag.horizontal_margin, bag.vertical_margin, bag.UI_width, bag.UI_height);
    
    stroke(0);
    fill(66,100,100);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("SHOP", bag.horizontal_margin + bag.UI_width/2, bag.vertical_margin + bag.square_height);
    
    dis_y = bag.vertical_margin + bag.vs;
    for(int i = 0; i < sale_count; i++){
      if(i % 5 == 0){
        dis_y += bag.vs + bag.square_height;
      }
      //println("x : " + (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + " y: " + dis_y);
      image(sell[i].img, (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width), dis_y, bag.square_width, bag.square_height);
    }
    
    stroke(0);
    fill(66,100,100);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("CART", bag.horizontal_margin + bag.UI_width/2, bag.UI_height/2);
    
    dis_y = bag.UI_height / 2 - bag.vs;
    for(int i = 0; i < sale_count; i++){
      if(i % 5 == 0){
        dis_y += bag.vs + bag.square_height;
      }
      //println("x : " + (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + " y: " + dis_y);
      image(cart[i].img, (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width), dis_y, bag.square_width, bag.square_height);
      
      this.gold_req += cart[i].gold;
    }
    
    noStroke();
    //left box for displaying total gold needed to buy items
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.hs, bag.UI_height - bag.vertical_margin - bag.square_height, bag.square_width * 3, bag.square_height);
    fill(0,100,0);
    textAlign(LEFT, CENTER);
    text("Total: " + gold_req, bag.horizontal_margin + bag.square_width, bag.UI_height - bag.vertical_margin - bag.square_height + bag.square_height/2);
    
    //right box for displaying player's gold
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.hs + bag.square_width * 4, bag.UI_height - bag.vertical_margin - bag.square_height, bag.square_width * 3, bag.square_height);
    fill(0,100,0);
    textAlign(LEFT, CENTER);
    text("Gold: " + p[0].get_gold(), bag.horizontal_margin + bag.square_width * 5, bag.UI_height - bag.vertical_margin - bag.square_height + bag.square_height/2);
    
    //confirmation box
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.square_width, height - bag.vertical_margin - bag.square_height, bag.square_width * 2, bag.square_height / 2);
    fill(0,100,0);
    textAlign(CENTER, CENTER);
    text("Buy", bag.horizontal_margin + bag.square_width * 2, height - bag.vertical_margin - bag.square_height + bag.square_height/4);
    
    //cancel and quit box
    fill(0,0,100);
    rect(bag.horizontal_margin + bag.UI_width/2 + bag.square_width, height - bag.vertical_margin - bag.square_height, bag.square_width * 2, bag.square_height / 2);
    fill(0,100,0);
    textAlign(CENTER, CENTER);
    text("Cancel", bag.horizontal_margin + bag.UI_width/2 + bag.square_width * 2, height - bag.vertical_margin - bag.square_height + bag.square_height/4);
  }
}
