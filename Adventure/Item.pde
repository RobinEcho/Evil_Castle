class Item{
  public int id;
  PImage img;
  public int level = 1;
  protected int str = 0, con = 0, intel = 0, wis = 0, agi = 0, patk = 0, pdef = 0, matk = 0, mdef = 0, spd = 0, hp = 0, mp = 0, rec_hp = 0, rec_mp = 0;
  protected String type;
  
  public Item(){
    
  }
  
/*****************************
*  initial stats for all items
******************************/ 
  public void init_stats(){
    switch(this.id){
      /*****************************
      *  HP consumable
      ******************************/ 
      case 11:
        this.rec_hp = 30;
        break;
      case 12:
        this.rec_hp = 100;
        break;
      case 13:
        this.rec_hp = 300;
        break;
    
    
      /*****************************
      *  MP consumable
      ******************************/ 
      case 21:
        this.rec_mp = 30;
        break;
      case 22:
        this.rec_mp = 100;
        break;
      case 23:
        this.rec_mp = 300;
        break;
        
      /*****************************
      *  max potion
      ******************************/ 
      case 31:
        this.rec_hp = 99999;
        this.rec_mp = 99999;
        break;
        
      /*****************************
      *  revive potion
      ******************************/ 
      case 39:
        this.rec_hp = 10;
        break;
       
      /*****************************
      *  Knight equipment
      ******************************/
      //weapon
      case 111:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 112:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 113:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 114:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 115:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 121:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 122:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 123:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 124:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 125:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //accessory
      case 131:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 132:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 133:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 134:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 135:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      /*****************************
      *  Paladin equipment
      ******************************/ 
      //weapon
      case 211:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 212:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 213:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 214:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 215:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 221:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 222:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 223:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 224:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 225:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //accessory
      case 231:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 232:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 233:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 234:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 235:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
        
        
      /*****************************
      *  Ranger equipment
      ******************************/ 
      //weapon
      case 311:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 312:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 313:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 314:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 315:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 321:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 322:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 323:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 324:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 325:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //accessory
      case 331:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 332:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 333:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 334:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 335:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
        
        
      /*****************************
      *  Assassin equipment
      ******************************/ 
      //weapon
      case 411:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 412:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 413:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 414:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 415:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 421:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 422:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 423:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 424:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 425:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //accessory
      case 431:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 432:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 433:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 434:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 435:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
        
        
      /*****************************
      *  Mage equipment
      ******************************/ 
      //weapon
      case 511:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 512:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 513:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 514:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 515:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 521:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 522:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 523:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 524:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 525:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //accessory
      case 531:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 532:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 533:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 534:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 535:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
        
        
      /*****************************
      *  Priest equipment
      ******************************/ 
      //weapon
      case 611:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 612:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 613:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 614:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 615:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 621:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 622:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 623:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 624:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 625:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //accessory
      case 631:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 632:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 633:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 634:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 635:
        str = 0; con = 0; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
        
    }//close switch
    
    //level requirement for item
    if(id > 100){
      this.level = (id % 10) * 5;
    }else{
      this.level = 1;
    }
  }
  
  /******************
  Setter
  ******************/
  public void set_img(String path){
    img = loadImage(path);
  }
  
  public void set_id(int x){
    this.id = x;
    
    if(this.id / 100 > 0){
      set_type("Equipment");
    }else{
      switch(this.id % 10){
        case 1:
        case 2:
        case 3:
          set_type("Consumable");
          break;
          
        default:
          set_type("Special");
          break;
      }
    }
  }
  
  protected void set_type(String s){
    this.type = s;
  }
  
  public void set_str(int x){
    this.str = x;
  }
  
  public void set_con(int x){
    this.con = x;
  }
  
  public void set_intel(int x){
    this.intel = x;
  }
  
  public void set_wis(int x){
    this.wis = x;
  }
  
  public void set_agi(int x){
    this.agi = x;
  }
  
  public void set_patk(int x){
    this.patk = x;
  }
  
  public void set_pdef(int x){
    this.pdef = x;
  }
  
  public void set_matk(int x){
    this.matk = x;
  }
  
  public void set_mdef(int x){
    this.mdef = x;
  }
  
  public void set_spd(int x){
    this.spd = x;
  }
  
  public void set_hp(int x){
    this.hp = x;
  }
  
  public void set_mp(int x){
    this.mp = x;
  }
  
  public void set_rec_hp(int x){
    this.rec_hp = x;
  }
  
  public void set_rec_mp(int x){
    this.rec_mp = x;
  }
  
  /**********************************
    Getters
  **********************************/
  
  public int get_id(){
    return this.id;
  }
  
  public String get_type(){
    return this.type;
  }
  
  public int get_str(){
    return this.str;
  }
  
  public int get_con(){
    return this.con;
  }
  
  public int get_intel(){
    return this.intel;
  }
  
  public int get_wis(){
    return this.wis;
  }
  
  public int get_agi(){
    return this.agi;
  }
  
  public int get_patk(){
    return this.patk;
  }
  
  public int get_pdef(){
    return this.pdef;
  }
  
  public int get_matk(){
    return this.matk;
  }
  
  public int get_mdef(){
    return this.mdef;
  }
  
  public int get_spd(){
    return this.spd;
  }
  
  public int get_hp(){
    return this.hp;
  }
  
  public int get_mp(){
    return this.mp;
  }
  
  public int get_rec_hp(){
    return this.rec_hp;
  }
  
  public int get_rec_mp(){
    return this.rec_mp;
  }
}//end Item class


public void load_items(){
  for(int i = 0; i < item_count; i++)
  {
     item_list[i] = new Item();
      
    /*****************************
    *  Knight equipment
    ******************************/
    if(i < 5){
      item_list[i].set_id(111 + i);
      item_list[i].set_img("src/item/equipment/knight/knight_weapon_" + ((i%5)+1) + ".png");
      
    }else if(i < 10){
      item_list[i].set_id(121 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_armour_" + ((i%5)+1) + ".png");
      
    }else if(i < 15){
      item_list[i].set_id(131 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_accessory_" + ((i%5)+1) + ".png");
    
    /*****************************
    *  Paladin equipment
    ******************************/
    }else if(i < 20){
      item_list[i].set_id(211 + i);
      item_list[i].set_img("src/item/equipment/paladin/paladin_weapon_" + ((i%5)+1) + ".png");
      
    }else if(i < 25){
      item_list[i].set_id(221 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_armour_" + ((i%5)+1) + ".png");
      
    }else if(i < 30){
      item_list[i].set_id(231 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_accessory_" + ((i%5)+1) + ".png");
    
    /*****************************
    *  Ranger equipment
    ******************************/
    }else if(i < 35){
      item_list[i].set_id(311 + i);
      item_list[i].set_img("src/item/equipment/ranger/ranger_weapon_" + ((i%5)+1) + ".png");
      
    }else if(i < 40){
      item_list[i].set_id(321 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_armour_" + ((i%5)+1) + ".png");
      
    }else if(i < 45){
      item_list[i].set_id(331 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_accessory_" + ((i%5)+1) + ".png");
    
    /*****************************
    *  Assassin equipment
    ******************************/
    }else if(i < 50){
      item_list[i].set_id(411 + i);
      item_list[i].set_img("src/item/equipment/assassin/assassin_weapon_" + ((i%5)+1) + ".png");
      
    }else if(i < 55){
      item_list[i].set_id(421 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_armour_" + ((i%5)+1) + ".png");
      
    }else if(i < 60){
      item_list[i].set_id(431 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_accessory_" + ((i%5)+1) + ".png");
    
    /*****************************
    *  Mage equipment
    ******************************/
    }else if(i < 65){
      item_list[i].set_id(511 + i);
      item_list[i].set_img("src/item/equipment/mage/mage_weapon_" + ((i%5)+1) + ".png");
      
    }else if(i < 70){
      item_list[i].set_id(521 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_armour_" + ((i%5)+1) + ".png");
      
    }else if(i < 75){
      item_list[i].set_id(531 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_accessory_" + ((i%5)+1) + ".png");
      
    /*****************************
    *  Priest equipment
    ******************************/ 
    }else if(i < 80){
      item_list[i].set_id(511 + i);
      item_list[i].set_img("src/item/equipment/priest/priest_weapon_" + ((i%5)+1) + ".png");
      
    }else if(i < 85){
      item_list[i].set_id(521 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_armour_" + ((i%5)+1) + ".png");
      
    }else if(i < 90){
      item_list[i].set_id(531 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_accessory_" + ((i%5)+1) + ".png");
      
    /*****************************
    *  HP consumable
    ******************************/ 
    }else if(i < 93){
      item_list[i].set_id(11 + (i%10));
      item_list[i].set_img("src/item/consumable/hp_" + ((i%10)+1) + ".png");
      
    /*****************************
    *  MP consumable
    ******************************/ 
    }else if(i < 96){
      item_list[i].set_id(18 + (i%10));
      item_list[i].set_img("src/item/consumable/mp_" + (((i%10)+18) % 10) + ".png");
      
    /*****************************
    *  max potion
    ******************************/ 
    }else if(i < 97){
      item_list[i].set_id(31);
      item_list[i].set_img("src/item/consumable/max_potion.png");
      
    /*****************************
    *  revive potion
    ******************************/ 
    }else if(i < 98){
      item_list[i].set_id(39);
      item_list[i].set_img("src/item/consumable/revive.png");
     
    /*****************************
    *  Keys
    ******************************/ 
    }else if(i < 101){
      item_list[i].set_id(i - 8);
      item_list[i].set_img("src/item/special/key_" + (i - 97) + ".jpg");
      
      
    }else{
      item_list[i].set_id(0);
      item_list[i].set_img("src/item/empty.jpg");
    }//end if
    
    item_list[i].init_stats();
  }//end for
}
