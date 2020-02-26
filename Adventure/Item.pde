class Item{
  public int id;
  PImage img;
  public int level = 1;
  protected int str = 0, con = 0, intel = 0, wis = 0, agi = 0, patk = 0, pdef = 0, matk = 0, mdef = 0, spd = 0, hp = 0, mp = 0, rec_hp = 0, rec_mp = 0;
  public String name;
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
        this.name = "Small HP Potion";
        this.rec_hp = 30;
        break;
      case 12:
        this.name = "Medium HP Potion";
        this.rec_hp = 100;
        break;
      case 13:
        this.name = "Large HP Potion";
        this.rec_hp = 300;
        break;
    
    
      /*****************************
      *  MP consumable
      ******************************/ 
      case 21:
        this.name = "Small MP Potion";
        this.rec_mp = 30;
        break;
      case 22:
        this.name = "Small MP Potion";
        this.rec_mp = 100;
        break;
      case 23:
        this.name = "Small MP Potion";
        this.rec_mp = 300;
        break;
        
      /*****************************
      *  max potion
      ******************************/ 
      case 31:
        this.name = "Max Potion";
        this.rec_hp = 99999;
        this.rec_mp = 99999;
        break;
        
      /*****************************
      *  revive potion
      ******************************/ 
      case 39:
        this.name = "Revive";
        this.rec_hp = 10;
        break;
       
      /*****************************
      *  Special Items
      ******************************/ 
      case 90:
        this.name = "Key 1";
        break;
      
      case 91:
        this.name = "Key 2";
        break;
        
      case 92:
        this.name = "Key 3";
        break;
      /*****************************
      *  Knight equipment
      ******************************/
      //weapon
      case 111:
        this.name = "Knight Sword 1";
        str = 1; con = 2; intel = 0; wis = 0; agi = 0; patk = 5; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 112:
        this.name = "Knight Sword 2";
        str = 2; con = 4; intel = 0; wis = 0; agi = 0; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 113:
        this.name = "Knight Sword 3";
        str = 3; con = 6; intel = 0; wis = 0; agi = 0; patk = 15; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 114:
        this.name = "Knight Sword 4";
        str = 4; con = 8; intel = 0; wis = 0; agi = 0; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 115:
        this.name = "Knight Sword 5";
        str = 5; con = 10; intel = 0; wis = 0; agi = 0; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 121:
        this.name = "Knight Armour 1";
        str = 0; con = 3; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 5; spd = 0; hp = 50; mp = 0;
        break;
      case 122:
        this.name = "Knight Armour 2";
        str = 1; con = 4; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 10; spd = 0; hp = 80; mp = 0;
        break;
      case 123:
        this.name = "Knight Armour 3";
        str = 2; con = 5; intel = 0; wis = 1; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 15; spd = -1; hp = 105; mp = 0;
        break;
      case 124:
        this.name = "Knight Armour 3";
        str = 3; con = 6; intel = 0; wis = 2; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 20; spd = -2; hp = 140; mp = 0;
        break;
      case 125:
        this.name = "Knight Armour 5";
        str = 4; con = 7; intel = 0; wis = 3; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 30; spd = -3; hp = 0; mp = 0;
        break;
      
      //accessory
      case 131:
        this.name = "Knight Accessory 1";
        str = 1; con = 2; intel = 0; wis = 0; agi = 0; patk = 1; pdef = 5; matk = 0; mdef = 2; spd = 0; hp = 10; mp = 3;
        break;
      case 132:
        this.name = "Knight Accessory 2";
        str = 2; con = 4; intel = 0; wis = 0; agi = 0; patk = 2; pdef = 6; matk = 0; mdef = 3; spd = 0; hp = 20; mp = 4;
        break;
      case 133:
        this.name = "Knight Accessory 3";
        str = 3; con = 6; intel = 0; wis = 0; agi = 0; patk = 3; pdef = 7; matk = 0; mdef = 4; spd = 0; hp = 30; mp = 5;
        break;
      case 134:
        this.name = "Knight Accessory 4";
        str = 4; con = 8; intel = 0; wis = 0; agi = 0; patk = 4; pdef = 8; matk = 0; mdef = 5; spd = 0; hp = 40; mp = 6;
        break;
      case 135:
        this.name = "Knight Accessory 5";
        str = 5; con = 10; intel = 0; wis = 0; agi = 0; patk = 5; pdef = 9; matk = 0; mdef = 6; spd = 0; hp = 50; mp = 7;
        break;
      
      /*****************************
      *  Paladin equipment
      ******************************/ 
      //weapon
      case 211:
        this.name = "Paladin Shield 1";
        str = 2; con = 2; intel = 2; wis = 1; agi = 0; patk = 3; pdef = 0; matk = 3; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 212:
        this.name = "Paladin Shield 2";
        str = 3; con = 3; intel = 3; wis = 2; agi = 0; patk = 4; pdef = 0; matk = 4; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 213:
        this.name = "Paladin Shield 3";
        str = 4; con = 4; intel = 4; wis = 3; agi = 0; patk = 5; pdef = 0; matk = 5; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 214:
        this.name = "Paladin Shield 4";
        str = 5; con = 5; intel = 5; wis = 4; agi = 0; patk = 6; pdef = 0; matk = 6; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 215:
        this.name = "Paladin Shield 5";
        str = 6; con = 6; intel = 6; wis = 5; agi = 0; patk = 7; pdef = 0; matk = 7; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 221:
        this.name = "Paladin Armour 1";
        str = 1; con = 3; intel = 1; wis = 2; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 0; hp = 30; mp = 10;
        break;
      case 222:
        this.name = "Paladin Armour 2";
        str = 2; con = 4; intel = 2; wis = 3; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 40; mp = 20;
        break;
      case 223:
        this.name = "Paladin Armour 3";
        str = 3; con = 5; intel = 3; wis = 4; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 50; mp = 30;
        break;
      case 224:
        this.name = "Paladin Armour 4";
        str = 4; con = 6; intel = 4; wis = 5; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 60; mp = 40;
        break;
      case 225:
        this.name = "Paladin Armour 5";
        str = 5; con = 7; intel = 5; wis = 6; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 70; mp = 50;
        break;
      
      //accessory
      case 231:
        this.name = "Paladin Accessory 1";
        str = 0; con = 2; intel = 0; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 20; mp = 20;
        break;
      case 232:
        this.name = "Paladin Accessory 2";
        str = 0; con = 3; intel = 0; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 30; mp = 30;
        break;
      case 233:
        this.name = "Paladin Accessory 3";
        str = 1; con = 4; intel = 1; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 2; hp = 40; mp = 40;
        break;
      case 234:
        this.name = "Paladin Accessory 4";
        str = 2; con = 5; intel = 2; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 4; hp = 50; mp = 50;
        break;
      case 235:
        this.name = "Paladin Accessory 5";
        str = 3; con = 6; intel = 3; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 6; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Ranger equipment
      ******************************/ 
      //weapon
      case 311:
        this.name = "Ranger Bow 1";
        str = 2; con = 0; intel = 2; wis = 0; agi = 4; patk = 20; pdef = 0; matk = 20; mdef = 0; spd = 10; hp = 0; mp = 0;
        break;
      case 312:
        this.name = "Ranger Bow 2";
        str = 3; con = 0; intel = 3; wis = 0; agi = 5; patk = 30; pdef = 0; matk = 30; mdef = 0; spd = 20; hp = 0; mp = 0;
        break;
      case 313:
        this.name = "Ranger Bow 3";
        str = 4; con = 0; intel = 4; wis = 0; agi = 6; patk = 40; pdef = 0; matk = 40; mdef = 0; spd = 30; hp = 0; mp = 0;
        break;
      case 314:
        this.name = "Ranger Bow 4";
        str = 5; con = 0; intel = 5; wis = 0; agi = 7; patk = 50; pdef = 0; matk = 50; mdef = 0; spd = 40; hp = 0; mp = 0;
        break;
      case 315:
        this.name = "Ranger Bow 5";
        str = 6; con = 0; intel = 6; wis = 0; agi = 8; patk = 60; pdef = 0; matk = 60; mdef = 0; spd = 50; hp = 0; mp = 0;
        break;
      
      //armour
      case 321:
        this.name = "Ranger Armour 1";
        str = 0; con = 2; intel = 0; wis = 0; agi = 1; patk = 0; pdef = 10; matk = 0; mdef = 20; spd = 10; hp = 30; mp = 0;
        break;
      case 322:
        this.name = "Ranger Armour 2";
        str = 0; con = 3; intel = 0; wis = 0; agi = 2; patk = 0; pdef = 20; matk = 0; mdef = 30; spd = 20; hp = 40; mp = 0;
        break;
      case 323:
        this.name = "Ranger Armour 3";
        str = 0; con = 4; intel = 0; wis = 0; agi = 3; patk = 0; pdef = 30; matk = 0; mdef = 40; spd = 30; hp = 50; mp = 0;
        break;
      case 324:
        this.name = "Ranger Armour 4";
        str = 0; con = 5; intel = 0; wis = 0; agi = 4; patk = 0; pdef = 40; matk = 0; mdef = 50; spd = 40; hp = 60; mp = 0;
        break;
      case 325:
        this.name = "Ranger Armour 5";
        str = 0; con = 6; intel = 0; wis = 0; agi = 5; patk = 0; pdef = 50; matk = 0; mdef = 60; spd = 50; hp = 70; mp = 0;
        break;
      
      //accessory
      case 331:
        this.name = "Ranger Accessory 1";
        str = 1; con = 1; intel = 1; wis = 0; agi = 2; patk = 5; pdef = 0; matk = 5; mdef = 0; spd = 2; hp = 20; mp = 20;
        break;
      case 332:
        this.name = "Ranger Accessory 2";
        str = 2; con = 2; intel = 2; wis = 0; agi = 3; patk = 6; pdef = 0; matk = 6; mdef = 0; spd = 3; hp = 30; mp = 30;
        break;
      case 333:
        this.name = "Ranger Accessory 3";
        str = 3; con = 3; intel = 3; wis = 0; agi = 4; patk = 7; pdef = 0; matk = 7; mdef = 0; spd = 4; hp = 40; mp = 40;
        break;
      case 334:
        this.name = "Ranger Accessory 4";
        str = 4; con = 4; intel = 4; wis = 0; agi = 5; patk = 8; pdef = 0; matk = 8; mdef = 0; spd = 5; hp = 50; mp = 50;
        break;
      case 335:
        this.name = "Ranger Accessory 5";
        str = 5; con = 5; intel = 5; wis = 0; agi = 6; patk = 9; pdef = 0; matk = 9; mdef = 0; spd = 6; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Assassin equipment
      ******************************/ 
      //weapon
      case 411:
        this.name = "Assassin Knife 1";
        str = 5; con = 0; intel = 0; wis = 0; agi = 5; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 10; hp = 0; mp = 0;
        break;
      case 412:
        this.name = "Assassin Knife 2";
        str = 6; con = 0; intel = 0; wis = 0; agi = 6; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 20; hp = 0; mp = 0;
        break;
      case 413:
        this.name = "Assassin Knife 3";
        str = 7; con = 0; intel = 0; wis = 0; agi = 7; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 30; hp = 0; mp = 0;
        break;
      case 414:
        this.name = "Assassin Knife 4";
        str = 8; con = 0; intel = 0; wis = 0; agi = 8; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 40; hp = 0; mp = 0;
        break;
      case 415:
        this.name = "Assassin Knife 5";
        str = 9; con = 0; intel = 0; wis = 0; agi = 9; patk = 50; pdef = 0; matk = 0; mdef = 0; spd = 50; hp = 0; mp = 0;
        break;
      
      //armour
      case 421:
        this.name = "Assassin Armour 1";
        str = 0; con = 3; intel = 0; wis = 1; agi = 2; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 10; hp = 10; mp = 0;
        break;
      case 422:
        this.name = "Assassin Armour 2";
        str = 0; con = 4; intel = 0; wis = 2; agi = 3; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 20; hp = 20; mp = 0;
        break;
      case 423:
        this.name = "Assassin Armour 3";
        str = 0; con = 5; intel = 0; wis = 3; agi = 4; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 30; hp = 30; mp = 0;
        break;
      case 424:
        this.name = "Assassin Armour 4";
        str = 0; con = 6; intel = 0; wis = 4; agi = 5; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 40; hp = 40; mp = 0;
        break;
      case 425:
        this.name = "Assassin Armour 5";
        str = 0; con = 7; intel = 0; wis = 5; agi = 6; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 50; hp = 50; mp = 0;
        break;
      
      //accessory
      case 431:
        this.name = "Assassin Accessory 1";
        str = 10; con = 1; intel = 0; wis = 0; agi = 10; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 10; hp = 10; mp = 10;
        break;
      case 432:
        this.name = "Assassin Accessory 2";
        str = 20; con = 2; intel = 0; wis = 0; agi = 20; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 20; hp = 20; mp = 20;
        break;
      case 433:
        this.name = "Assassin Accessory 3";
        str = 30; con = 3; intel = 0; wis = 0; agi = 30; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 30; hp = 30; mp = 30;
        break;
      case 434:
        this.name = "Assassin Accessory 4";
        str = 40; con = 4; intel = 0; wis = 0; agi = 40; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 40; hp = 40; mp = 40;
        break;
      case 435:
        this.name = "Assassin Accessory 5";
        str = 50; con = 5; intel = 0; wis = 0; agi = 50; patk = 50; pdef = 0; matk = 0; mdef = 0; spd = 50; hp = 50; mp = 50;
        break;
        
        
      /*****************************
      *  Mage equipment
      ******************************/ 
      //weapon
      case 511:
        this.name = "Mage Book 1";
        str = 0; con = 0; intel = 10; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 0; mp = 10;
        break;
      case 512:
        this.name = "Mage Book 2";
        str = 0; con = 0; intel = 20; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 0; mp = 20;
        break;
      case 513:
        this.name = "Mage Book 3";
        str = 0; con = 0; intel = 30; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 0; mp = 30;
        break;
      case 514:
        this.name = "Mage Book 4";
        str = 0; con = 0; intel = 40; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 0; mp = 40;
        break;
      case 515:
        this.name = "Mage Book 5";
        str = 0; con = 0; intel = 50; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 60; mdef = 0; spd = 0; hp = 0; mp = 50;
        break;
      
      //armour
      case 521:
        this.name = "Mage Armour 1";
        str = 0; con = 3; intel = 4; wis = 2; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 0; hp = 20; mp = 20;
        break;
      case 522:
        this.name = "Mage Armour 2";
        str = 0; con = 4; intel = 5; wis = 3; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 523:
        this.name = "Mage Armour 3";
        str = 0; con = 5; intel = 6; wis = 4; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 524:
        this.name = "Mage Armour 4";
        str = 0; con = 6; intel = 7; wis = 5; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 525:
        this.name = "Mage Armour 5";
        str = 0; con = 7; intel = 8; wis = 6; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
      
      //accessory
      case 531:
        this.name = "Mage Accessory 1";
        str = 0; con = 2; intel = 4; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 10; mdef = 0; spd = 0; hp = 20; mp = 20;
        break;
      case 532:
        this.name = "Mage Accessory 2";
        str = 0; con = 3; intel = 5; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 30; mp = 30;
        break;
      case 533:
        this.name = "Mage Accessory 3";
        str = 0; con = 4; intel = 6; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 40; mp = 40;
        break;
      case 534:
        this.name = "Mage Accessory 4";
        str = 0; con = 5; intel = 7; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 50; mp = 50;
        break;
      case 535:
        this.name = "Mage Accessory 5";
        str = 0; con = 6; intel = 8; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Priest equipment
      ******************************/ 
      //weapon
      case 611:
        this.name = "Priest Staff 1";
        str = 0; con = 0; intel = 3; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 10; mdef = 0; spd = 0; hp = 0; mp = 20;
        break;
      case 612:
        this.name = "Priest Staff 2";
        str = 0; con = 0; intel = 4; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 0; mp = 30;
        break;
      case 613:
        this.name = "Priest Staff 3";
        str = 0; con = 0; intel = 5; wis = 7; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 0; mp = 40;
        break;
      case 614:
        this.name = "Priest Staff 4";
        str = 0; con = 0; intel = 6; wis = 8; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 0; mp = 50;
        break;
      case 615:
        this.name = "Priest Staff 5";
        str = 0; con = 0; intel = 7; wis = 9; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 0; mp = 60;
        break;
      
      //armour
      case 621:
        this.name = "Priest Armour 1";
        str = 0; con = 5; intel = 1; wis = 6; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 622:
        this.name = "Priest Armour 2";
        str = 0; con = 6; intel = 2; wis = 7; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 623:
        this.name = "Priest Armour 3";
        str = 0; con = 7; intel = 3; wis = 8; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 624:
        this.name = "Priest Armour 4";
        str = 0; con = 8; intel = 4; wis = 9; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
      case 625:
        this.name = "Priest Armour 5";
        str = 0; con = 9; intel = 5; wis = 10; agi = 0; patk = 0; pdef = 60; matk = 0; mdef = 60; spd = 0; hp = 70; mp = 70;
        break;
      
      //accessory
      case 631:
        this.name = "Priest Accessory 1";
        str = 0; con = 2; intel = 1; wis = 3; agi = 1; patk = 0; pdef = 10; matk = 10; mdef = 10; spd = 0; hp = 20; mp = 20;
        break;
      case 632:
        this.name = "Priest Accessory 2";
        str = 0; con = 3; intel = 2; wis = 4; agi = 2; patk = 0; pdef = 20; matk = 20; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 633:
        this.name = "Priest Accessory 3";
        str = 0; con = 4; intel = 3; wis = 5; agi = 3; patk = 0; pdef = 30; matk = 30; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 634:
        this.name = "Priest Accessory 4";
        str = 0; con = 5; intel = 4; wis = 6; agi = 4; patk = 0; pdef = 40; matk = 40; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 635:
        this.name = "Priest Accessory 5";
        str = 0; con = 6; intel = 5; wis = 7; agi = 5; patk = 0; pdef = 50; matk = 50; mdef = 50; spd = 0; hp = 60; mp = 60;
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
  
  public void desc(float display_x, float display_y){
    int count = 0, not_displayed = 0;
    String[] attr = {"Level: ", "Strength: ", "Constitution: ", "Intelligence: ", "Wisdom: ", "Agility: ", 
                    "Physical Attack: ", "Physical Defense: ", "Magical Attack: ", "Magical Defense: ", 
                    "Speed: ", "HP: ", "MP: ", "Recover HP: ", "Recover MP: "};
                    
    int[] pt = {this.level, this.str, this.con, this.intel, this.wis, this.agi, 
                this.patk, this.pdef, this.matk, this.mdef, this.spd, this.hp, this.mp, 
                this.rec_hp, this.rec_mp};
    
    for(int i = 0; i < pt.length; i++){
      if(pt[i] != 0){
        count++;
      }
    }
    
    noStroke();
    fill(52,50,75);
    textAlign(CENTER, CENTER);
    textSize(20);
    rect(display_x, display_y, bag.square_width * 3, (count + 1) * 30);
    
    fill(0,100,100);
    stroke(0,100,100);
    textAlign(CENTER, CENTER);
    textSize(20);
    //println("ID: " + this.id);
    text(this.name, display_x + bag.square_width * 1.5, display_y + 15);
    
    if(count > 0){
      for(int i = 0; i < pt.length; i++){
        if(pt[i] != 0){
          text(attr[i] + pt[i], display_x + bag.square_width * 1.5, display_y + 15 + (i+1 - not_displayed) * 30);
        }else{
          not_displayed++;
        }
      }
    }
    
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
      item_list[i].set_id(111 + (i%5));
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
      item_list[i].set_id(211 + (i%5));
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
      item_list[i].set_id(311 + (i%5));
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
      item_list[i].set_id(411 + (i%5));
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
      item_list[i].set_id(511 + (i%5));
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
      item_list[i].set_id(511 + (i%5));
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

void item_desc(int bag_mode){
  for(int i = 0; i < bag.row; i++){
    for(int j = 0; j < bag.col; j++){
      switch(bag_mode){
        case 1:
          if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + (width + bag.UI_dis)/2) + bag.square_width
            && mouseY >= ((i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin) && mouseY <= ((i+1)*bag.vs + (i * bag.square_height) + bag.vertical_margin) + bag.square_height){
              
              if(bag.inv[i][j] != item_count - 1){
                item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY);
              }
              
          }
          break;
          
        case 2:
          if(i > bag.row / 2 - ((bag.row + 1) % 2)){
            if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + width/2) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 + bag.square_width)
              && mouseY >= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin 
              && mouseY <= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin + bag.square_height){
                
                if(bag.inv[i][j] != item_count - 1){
                    item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY);
                }
            }    
          }else{
              if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width + bag.square_width) 
                && mouseY >= ( ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin ) && mouseY <= ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin + bag.square_height){
                  
                   if(bag.inv[i][j] != item_count - 1){
                       item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY);
                   }
              }    
          }
          break;
      }
            
    }    //for loop(j)
  }    //for loop (i)
}
