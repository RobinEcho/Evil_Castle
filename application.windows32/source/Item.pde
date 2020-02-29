class Item{
  public int id;
  PImage img;
  public int level = 1, gold = 0;
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
        this.rec_hp = 100;
        this.rec_mp = 0;
        this.gold = 50;
        break;
      case 12:
        this.name = "Medium HP Potion";
        this.rec_hp = 500;
        this.rec_mp = 0;
        this.gold = 150;
        break;
      case 13:
        this.name = "Large HP Potion";
        this.rec_hp = 1000;
        this.rec_mp = 0;
        this.gold = 400;
        break;
    
    
      /*****************************
      *  MP consumable
      ******************************/ 
      case 21:
        this.name = "Small MP Potion";
        this.rec_mp = 100;
        this.rec_hp = 0;
        this.gold = 50;
        break;
      case 22:
        this.name = "Small MP Potion";
        this.rec_mp = 500;
        this.rec_hp = 0;
        this.gold = 150;
        break;
      case 23:
        this.name = "Small MP Potion";
        this.rec_mp = 1000;
        this.rec_hp = 0;
        this.gold = 400;
        break;
        
      /*****************************
      *  max potion
      ******************************/ 
      case 31:
        this.name = "Max Potion";
        this.rec_hp = 99999;
        this.rec_mp = 99999;
        this.gold = 1000;
        break;
        
      /*****************************
      *  revive potion
      ******************************/ 
      case 39:
        this.name = "Revive";
        this.rec_hp = 10;
        this.rec_mp = 0;
        this.gold = 100;
        break;
       
      /*****************************
      *  Special Items
      ******************************/ 
      case 90:
        this.name = "Chest";
        break;
      
      case 91:
        this.name = "Prison Cell Key";
        break;
        
      case 92:
        this.name = "Golden Key";
        break;
      /*****************************
      *  Knight equipment
      ******************************/
      //weapon
      case 111:
        this.name = "Old Sword";
        str = 2; con = 5; intel = 0; wis = 0; agi = 0; patk = 5; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 112:
        this.name = "Great Sword";
        str = 6; con = 10; intel = 0; wis = 0; agi = 0; patk = 15; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 113:
        this.name = "Knight Sword";
        str = 12; con = 15; intel = 0; wis = 0; agi = 0; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 114:
        this.name = "Light Saber";
        str = 20; con = 20; intel = 0; wis = 0; agi = 0; patk = 70; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 115:
        this.name = "Devil's Sword - Dante";
        str = 30; con = 30; intel = 0; wis = 0; agi = 0; patk = 90; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 121:
        this.name = "Worn Breastplate";
        str = 0; con = 10; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 5; spd = 0; hp = 50; mp = 0;
        break;
      case 122:
        this.name = "Knight Armour";
        str = 0; con = 15; intel = 0; wis = 0; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 10; spd = 0; hp = 80; mp = 0;
        break;
      case 123:
        this.name = "Shining Silver Breastplate";
        str = 0; con = 25; intel = 0; wis = 1; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 20; spd = 0; hp = 105; mp = 0;
        break;
      case 124:
        this.name = "Dragonscale Breastplate";
        str = 0; con = 30; intel = 0; wis = 2; agi = 0; patk = 0; pdef = 70; matk = 0; mdef = 35; spd = 0; hp = 140; mp = 0;
        break;
      case 125:
        this.name = "Imperial Armour";
        str = 0; con = 40; intel = 0; wis = 3; agi = 0; patk = 0; pdef = 100; matk = 0; mdef = 60; spd = 0; hp = 250; mp = 0;
        break;
      
      //accessory
      case 131:
        this.name = "Ordinary Handguard";
        str = 0; con = 4; intel = 0; wis = 0; agi = 0; patk = 10; pdef = 10; matk = 0; mdef = 5; spd = 0; hp = 30; mp = 30;
        break;
      case 132:
        this.name = "Guardian";
        str = 0; con = 8; intel = 0; wis = 0; agi = 0; patk = 20; pdef = 20; matk = 0; mdef = 10; spd = 0; hp = 60; mp = 40;
        break;
      case 133:
        this.name = "Blood Hanguard";
        str = 5; con = 12; intel = 0; wis = 0; agi = 0; patk = 30; pdef = 30; matk = 0; mdef = 15; spd = 0; hp = 90; mp = 50;
        break;
      case 134:
        this.name = "Mysterious Hanguard";
        str = 10; con = 16; intel = 0; wis = 0; agi = 0; patk = 40; pdef = 40; matk = 0; mdef = 20; spd = 0; hp = 120; mp = 60;
        break;
      case 135:
        this.name = "Emperor's Hand";
        str = 15; con = 20; intel = 0; wis = 0; agi = 0; patk = 50; pdef = 50; matk = 0; mdef = 25; spd = 0; hp = 300; mp = 70;
        break;
      
      /*****************************
      *  Paladin equipment
      ******************************/ 
      //weapon
      case 211:
        this.name = "Old Shield";
        str = 2; con = 2; intel = 2; wis = 1; agi = 0; patk = 3; pdef = 0; matk = 3; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 212:
        this.name = "Silve Shield";
        str = 3; con = 3; intel = 3; wis = 2; agi = 0; patk = 4; pdef = 0; matk = 4; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 213:
        this.name = "Holy Shield";
        str = 4; con = 4; intel = 4; wis = 3; agi = 0; patk = 5; pdef = 0; matk = 5; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 214:
        this.name = "Magic Shield";
        str = 5; con = 5; intel = 5; wis = 4; agi = 0; patk = 6; pdef = 0; matk = 6; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      case 215:
        this.name = "Captain America's Shield";
        str = 6; con = 6; intel = 6; wis = 5; agi = 0; patk = 7; pdef = 0; matk = 7; mdef = 0; spd = 0; hp = 0; mp = 0;
        break;
      
      //armour
      case 221:
        this.name = "Old Armour";
        str = 1; con = 3; intel = 1; wis = 2; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 0; hp = 30; mp = 10;
        break;
      case 222:
        this.name = "Standard Armour";
        str = 2; con = 4; intel = 2; wis = 3; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 40; mp = 20;
        break;
      case 223:
        this.name = "Cruciform Armour";
        str = 3; con = 5; intel = 3; wis = 4; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 50; mp = 30;
        break;
      case 224:
        this.name = "Black Dragon Armour";
        str = 4; con = 6; intel = 4; wis = 5; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 60; mp = 40;
        break;
      case 225:
        this.name = "Archangel's Blessing";
        str = 5; con = 7; intel = 5; wis = 6; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 70; mp = 50;
        break;
      
      //accessory
      case 231:
        this.name = "Low-Tier Gemstone";
        str = 0; con = 2; intel = 0; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 20; mp = 20;
        break;
      case 232:
        this.name = "Common Gemstone";
        str = 0; con = 3; intel = 0; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 0; hp = 30; mp = 30;
        break;
      case 233:
        this.name = "High-Tier Gemstone";
        str = 1; con = 4; intel = 1; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 2; hp = 40; mp = 40;
        break;
      case 234:
        this.name = "Excellent Gemstone";
        str = 2; con = 5; intel = 2; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 4; hp = 50; mp = 50;
        break;
      case 235:
        this.name = "Super Rare Gemstone";
        str = 3; con = 6; intel = 3; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 0; mdef = 0; spd = 6; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Ranger equipment
      ******************************/ 
      //weapon
      case 311:
        this.name = "Old Bow";
        str = 2; con = 0; intel = 2; wis = 0; agi = 4; patk = 20; pdef = 0; matk = 20; mdef = 0; spd = 10; hp = 0; mp = 0;
        break;
      case 312:
        this.name = "Wooden Bow";
        str = 3; con = 0; intel = 3; wis = 0; agi = 5; patk = 30; pdef = 0; matk = 30; mdef = 0; spd = 20; hp = 0; mp = 0;
        break;
      case 313:
        this.name = "Long Bow";
        str = 4; con = 0; intel = 4; wis = 0; agi = 6; patk = 40; pdef = 0; matk = 40; mdef = 0; spd = 30; hp = 0; mp = 0;
        break;
      case 314:
        this.name = "Phathom Bow";
        str = 5; con = 0; intel = 5; wis = 0; agi = 7; patk = 50; pdef = 0; matk = 50; mdef = 0; spd = 40; hp = 0; mp = 0;
        break;
      case 315:
        this.name = "Bow of Wind";
        str = 6; con = 0; intel = 6; wis = 0; agi = 8; patk = 60; pdef = 0; matk = 60; mdef = 0; spd = 50; hp = 0; mp = 0;
        break;
      
      //armour
      case 321:
        this.name = "Old Cloak";
        str = 0; con = 2; intel = 0; wis = 0; agi = 1; patk = 0; pdef = 10; matk = 0; mdef = 20; spd = 10; hp = 30; mp = 0;
        break;
      case 322:
        this.name = "Magic Cloak";
        str = 0; con = 3; intel = 0; wis = 0; agi = 2; patk = 0; pdef = 20; matk = 0; mdef = 30; spd = 20; hp = 40; mp = 0;
        break;
      case 323:
        this.name = "Silver Cloak";
        str = 0; con = 4; intel = 0; wis = 0; agi = 3; patk = 0; pdef = 30; matk = 0; mdef = 40; spd = 30; hp = 50; mp = 0;
        break;
      case 324:
        this.name = "Devil's Cloak";
        str = 0; con = 5; intel = 0; wis = 0; agi = 4; patk = 0; pdef = 40; matk = 0; mdef = 50; spd = 40; hp = 60; mp = 0;
        break;
      case 325:
        this.name = "Elven Cloak";
        str = 0; con = 6; intel = 0; wis = 0; agi = 5; patk = 0; pdef = 50; matk = 0; mdef = 60; spd = 50; hp = 70; mp = 0;
        break;
      
      //accessory
      case 331:
        this.name = "Old Ring";
        str = 1; con = 1; intel = 1; wis = 0; agi = 2; patk = 5; pdef = 0; matk = 5; mdef = 0; spd = 2; hp = 20; mp = 20;
        break;
      case 332:
        this.name = "Speed Ring";
        str = 2; con = 2; intel = 2; wis = 0; agi = 3; patk = 6; pdef = 0; matk = 6; mdef = 0; spd = 3; hp = 30; mp = 30;
        break;
      case 333:
        this.name = "Mysterious Ring";
        str = 3; con = 3; intel = 3; wis = 0; agi = 4; patk = 7; pdef = 0; matk = 7; mdef = 0; spd = 4; hp = 40; mp = 40;
        break;
      case 334:
        this.name = "Purple Dragon Ring";
        str = 4; con = 4; intel = 4; wis = 0; agi = 5; patk = 8; pdef = 0; matk = 8; mdef = 0; spd = 5; hp = 50; mp = 50;
        break;
      case 335:
        this.name = "Wind's Ring";
        str = 5; con = 5; intel = 5; wis = 0; agi = 6; patk = 9; pdef = 0; matk = 9; mdef = 0; spd = 6; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Assassin equipment
      ******************************/ 
      //weapon
      case 411:
        this.name = "Old Dagger";
        str = 5; con = 0; intel = 0; wis = 0; agi = 5; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 10; hp = 0; mp = 0;
        break;
      case 412:
        this.name = "Common Dagger";
        str = 6; con = 0; intel = 0; wis = 0; agi = 6; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 20; hp = 0; mp = 0;
        break;
      case 413:
        this.name = "Military Dagger";
        str = 7; con = 0; intel = 0; wis = 0; agi = 7; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 30; hp = 0; mp = 0;
        break;
      case 414:
        this.name = "Paw Dagger";
        str = 8; con = 0; intel = 0; wis = 0; agi = 8; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 40; hp = 0; mp = 0;
        break;
      case 415:
        this.name = "Godlike Dagger";
        str = 9; con = 0; intel = 0; wis = 0; agi = 9; patk = 50; pdef = 0; matk = 0; mdef = 0; spd = 50; hp = 0; mp = 0;
        break;
      
      //armour
      case 421:
        this.name = "Mask";
        str = 0; con = 3; intel = 0; wis = 1; agi = 2; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 10; hp = 10; mp = 0;
        break;
      case 422:
        this.name = "Thief's Mask";
        str = 0; con = 4; intel = 0; wis = 2; agi = 3; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 20; hp = 20; mp = 0;
        break;
      case 423:
        this.name = "Red Scarf";
        str = 0; con = 5; intel = 0; wis = 3; agi = 4; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 30; hp = 30; mp = 0;
        break;
      case 424:
        this.name = "Mysterious Scarf";
        str = 0; con = 6; intel = 0; wis = 4; agi = 5; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 40; hp = 40; mp = 0;
        break;
      case 425:
        this.name = "Kakashi's Mask";
        str = 0; con = 7; intel = 0; wis = 5; agi = 6; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 50; hp = 50; mp = 0;
        break;
      
      //accessory
      case 431:
        this.name = "Traveller's Shoes";
        str = 10; con = 1; intel = 0; wis = 0; agi = 10; patk = 10; pdef = 0; matk = 0; mdef = 0; spd = 10; hp = 10; mp = 10;
        break;
      case 432:
        this.name = "Iron Secret Boots";
        str = 20; con = 2; intel = 0; wis = 0; agi = 20; patk = 20; pdef = 0; matk = 0; mdef = 0; spd = 20; hp = 20; mp = 20;
        break;
      case 433:
        this.name = "Boots Of Speed";
        str = 30; con = 3; intel = 0; wis = 0; agi = 30; patk = 30; pdef = 0; matk = 0; mdef = 0; spd = 30; hp = 30; mp = 30;
        break;
      case 434:
        this.name = "Secret Boots";
        str = 40; con = 4; intel = 0; wis = 0; agi = 40; patk = 40; pdef = 0; matk = 0; mdef = 0; spd = 40; hp = 40; mp = 40;
        break;
      case 435:
        this.name = "Flying Boots";
        str = 50; con = 5; intel = 0; wis = 0; agi = 50; patk = 50; pdef = 0; matk = 0; mdef = 0; spd = 50; hp = 50; mp = 50;
        break;
        
        
      /*****************************
      *  Mage equipment
      ******************************/ 
      //weapon
      case 511:
        this.name = "Magic Book";
        str = 0; con = 0; intel = 10; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 0; mp = 10;
        break;
      case 512:
        this.name = "Ancient Magic Book";
        str = 0; con = 0; intel = 20; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 0; mp = 20;
        break;
      case 513:
        this.name = "Magic Clover";
        str = 0; con = 0; intel = 30; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 0; mp = 30;
        break;
      case 514:
        this.name = "Lucky Clover";
        str = 0; con = 0; intel = 40; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 0; mp = 40;
        break;
      case 515:
        this.name = "Death Note";
        str = 0; con = 0; intel = 50; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 60; mdef = 0; spd = 0; hp = 0; mp = 50;
        break;
      
      //armour
      case 521:
        this.name = "Old Robe";
        str = 0; con = 3; intel = 4; wis = 2; agi = 0; patk = 0; pdef = 10; matk = 0; mdef = 10; spd = 0; hp = 20; mp = 20;
        break;
      case 522:
        this.name = "Traveller's Robe";
        str = 0; con = 4; intel = 5; wis = 3; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 523:
        this.name = "Smurf's Robe";
        str = 0; con = 5; intel = 6; wis = 4; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 524:
        this.name = "Mysterious Robe";
        str = 0; con = 6; intel = 7; wis = 5; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 525:
        this.name = "Robe Of Hellfire";
        str = 0; con = 7; intel = 8; wis = 6; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
      
      //accessory
      case 531:
        this.name = "Common Magic Ball";
        str = 0; con = 2; intel = 4; wis = 2; agi = 0; patk = 0; pdef = 0; matk = 10; mdef = 0; spd = 0; hp = 20; mp = 20;
        break;
      case 532:
        this.name = "Green Magic Ball";
        str = 0; con = 3; intel = 5; wis = 3; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 30; mp = 30;
        break;
      case 533:
        this.name = "Blue Magic Ball";
        str = 0; con = 4; intel = 6; wis = 4; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 40; mp = 40;
        break;
      case 534:
        this.name = "Dark Magic Ball";
        str = 0; con = 5; intel = 7; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 50; mp = 50;
        break;
      case 535:
        this.name = "Infernal Magic Ball";
        str = 0; con = 6; intel = 8; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 60; mp = 60;
        break;
        
        
      /*****************************
      *  Priest equipment
      ******************************/ 
      //weapon
      case 611:
        this.name = "Old Wand";
        str = 0; con = 0; intel = 3; wis = 5; agi = 0; patk = 0; pdef = 0; matk = 10; mdef = 0; spd = 0; hp = 0; mp = 20;
        break;
      case 612:
        this.name = "Wand Of Forest";
        str = 0; con = 0; intel = 4; wis = 6; agi = 0; patk = 0; pdef = 0; matk = 20; mdef = 0; spd = 0; hp = 0; mp = 30;
        break;
      case 613:
        this.name = "Crystal Wand";
        str = 0; con = 0; intel = 5; wis = 7; agi = 0; patk = 0; pdef = 0; matk = 30; mdef = 0; spd = 0; hp = 0; mp = 40;
        break;
      case 614:
        this.name = "Magical Wand";
        str = 0; con = 0; intel = 6; wis = 8; agi = 0; patk = 0; pdef = 0; matk = 40; mdef = 0; spd = 0; hp = 0; mp = 50;
        break;
      case 615:
        this.name = "Poseidon's Triden";
        str = 0; con = 0; intel = 7; wis = 9; agi = 0; patk = 0; pdef = 0; matk = 50; mdef = 0; spd = 0; hp = 0; mp = 60;
        break;
      
      //armour
      case 621:
        this.name = "Worn Robe";
        str = 0; con = 5; intel = 1; wis = 6; agi = 0; patk = 0; pdef = 20; matk = 0; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 622:
        this.name = "Monk's Robe";
        str = 0; con = 6; intel = 2; wis = 7; agi = 0; patk = 0; pdef = 30; matk = 0; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 623:
        this.name = "Servant's Robe";
        str = 0; con = 7; intel = 3; wis = 8; agi = 0; patk = 0; pdef = 40; matk = 0; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 624:
        this.name = "Holy Robe";
        str = 0; con = 8; intel = 4; wis = 9; agi = 0; patk = 0; pdef = 50; matk = 0; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
      case 625:
        this.name = "Angel's Descent";
        str = 0; con = 9; intel = 5; wis = 10; agi = 0; patk = 0; pdef = 60; matk = 0; mdef = 60; spd = 0; hp = 70; mp = 70;
        break;
      
      //accessory
      case 631:
        this.name = "Gold Necklace";
        str = 0; con = 2; intel = 1; wis = 3; agi = 1; patk = 0; pdef = 10; matk = 10; mdef = 10; spd = 0; hp = 20; mp = 20;
        break;
      case 632:
        this.name = "Crystal Necklace";
        str = 0; con = 3; intel = 2; wis = 4; agi = 2; patk = 0; pdef = 20; matk = 20; mdef = 20; spd = 0; hp = 30; mp = 30;
        break;
      case 633:
        this.name = "Arcane Necklace";
        str = 0; con = 4; intel = 3; wis = 5; agi = 3; patk = 0; pdef = 30; matk = 30; mdef = 30; spd = 0; hp = 40; mp = 40;
        break;
      case 634:
        this.name = "Guardian's Cross";
        str = 0; con = 5; intel = 4; wis = 6; agi = 4; patk = 0; pdef = 40; matk = 40; mdef = 40; spd = 0; hp = 50; mp = 50;
        break;
      case 635:
        this.name = "Millennium Puzzle";
        str = 0; con = 6; intel = 5; wis = 7; agi = 5; patk = 0; pdef = 50; matk = 50; mdef = 50; spd = 0; hp = 60; mp = 60;
        break;
        
    }//close switch
    
    //level requirement for item
    if(id > 100){
      this.level = (id % 10) * 5;
      this.gold = (id % 10) * 50;
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
  
  public void desc(float display_x, float display_y, int dg){
    int count = 0, not_displayed = 0;
    String[] attr = {"Level: ", "Strength: ", "Constitution: ", "Intelligence: ", "Wisdom: ", "Agility: ", 
                    "Physical Attack: ", "Physical Defense: ", "Magical Attack: ", "Magical Defense: ", 
                    "Speed: ", "HP: ", "MP: ", "Recover HP: ", "Recover MP: ", "Gold: "};
                    
    int[] pt = {this.level, this.str, this.con, this.intel, this.wis, this.agi, 
                this.patk, this.pdef, this.matk, this.mdef, this.spd, this.hp, this.mp, 
                this.rec_hp, this.rec_mp, this.gold};
    
    for(int i = 0; i < pt.length - dg; i++){
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
      for(int i = 0; i < pt.length - dg; i++){
        if(pt[i] != 0){
          text(attr[i] + pt[i], display_x + bag.square_width * 1.5, display_y + 15 + (i+1 - not_displayed) * 30);
        }else{
          not_displayed++;
        }
      }
    }
    
  }// end function desc
  
  public void use(int target){
    int temp_item;
    
    
      if(this.id < 50){
        if(this.id == 39){
          if(!p[target].is_alive()){
            p[target].ress();
            p[target].rec_hp(this.rec_hp);
            p[target].rec_mp(this.rec_mp);
            bag.inv[bag_y][bag_x] = item_count - 1;
          }
        }else{
          if(p[target].get_cur_hp() < p[target].get_max_hp()){
            p[target].rec_hp(this.rec_hp);
            p[target].rec_mp(this.rec_mp);
            bag.inv[bag_y][bag_x] = item_count - 1;
          }
        }
        
        p[target].calc_stats();
      }else if(this.id > 100){
        if(p[target].job_code == (this.id / 100)){
          if(p[target].level >= item_list[bag.inv[bag_y][bag_x]].level){
            temp_item = p[target].equipment[((this.id % 100) / 10) - 1];
            
            update_player_bonus(target, temp_item, bag.inv[bag_y][bag_x]);
            
            p[target].equipment[((this.id % 100) / 10) - 1] = bag.inv[bag_y][bag_x];
            bag.inv[bag_y][bag_x] = temp_item;
          }else{
            println("You don't meet the level requirement for this item!");
          }
        }else{
          println("Wrong Job equipment!");
        }
      }
    
  }
  
  
  public void update_player_bonus(int target, int prev_eq_code, int new_eq_code){
    //decrease player stats added by previous equipment
    p[target].inc_str(-1 * item_list[prev_eq_code].get_str());
    p[target].inc_con(-1 * item_list[prev_eq_code].get_con());
    p[target].inc_int(-1 * item_list[prev_eq_code].get_intel());
    p[target].inc_wis(-1 * item_list[prev_eq_code].get_wis());
    p[target].inc_agi(-1 * item_list[prev_eq_code].get_agi());
    p[target].inc_patk(-1 * item_list[prev_eq_code].get_patk());
    p[target].inc_pdef(-1 * item_list[prev_eq_code].get_pdef());
    p[target].inc_matk(-1 * item_list[prev_eq_code].get_matk());
    p[target].inc_mdef(-1 * item_list[prev_eq_code].get_mdef());
    p[target].inc_spd(-1 * item_list[prev_eq_code].get_spd());
    p[target].inc_hp(-1 * item_list[prev_eq_code].get_hp());
    p[target].inc_mp(-1 * item_list[prev_eq_code].get_mp());
    println("dec stats");
    println("str:  " + item_list[prev_eq_code].get_str());
    println("con:  " + item_list[prev_eq_code].get_con());
    println("hp:  " + item_list[prev_eq_code].get_hp());
    
    //increase player stats by new equipment bonuses
    p[target].inc_str(item_list[new_eq_code].get_str());
    p[target].inc_con(item_list[new_eq_code].get_con());
    p[target].inc_int(item_list[new_eq_code].get_intel());
    p[target].inc_wis(item_list[new_eq_code].get_wis());
    p[target].inc_agi(item_list[new_eq_code].get_agi());
    p[target].inc_patk(item_list[new_eq_code].get_patk());
    p[target].inc_pdef(item_list[new_eq_code].get_pdef());
    p[target].inc_matk(item_list[new_eq_code].get_matk());
    p[target].inc_mdef(item_list[new_eq_code].get_mdef());
    p[target].inc_spd(item_list[new_eq_code].get_spd());
    p[target].inc_hp(item_list[new_eq_code].get_hp());
    p[target].inc_mp(item_list[new_eq_code].get_mp());
    println("dec stats");
    println("str:  " + item_list[new_eq_code].get_str());
    println("con:  " + item_list[new_eq_code].get_con());
    println("hp:  " + item_list[new_eq_code].get_hp());
    
    p[target].calc_stats();
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
      item_list[i].set_img("src/item/equipment/knight/knight_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 10){
      item_list[i].set_id(121 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 15){
      item_list[i].set_id(131 + (i%5));
      item_list[i].set_img("src/item/equipment/knight/knight_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Paladin equipment
    ******************************/
    }else if(i < 20){
      item_list[i].set_id(211 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 25){
      item_list[i].set_id(221 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 30){
      item_list[i].set_id(231 + (i%5));
      item_list[i].set_img("src/item/equipment/paladin/paladin_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Ranger equipment
    ******************************/
    }else if(i < 35){
      item_list[i].set_id(311 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 40){
      item_list[i].set_id(321 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 45){
      item_list[i].set_id(331 + (i%5));
      item_list[i].set_img("src/item/equipment/ranger/ranger_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Assassin equipment
    ******************************/
    }else if(i < 50){
      item_list[i].set_id(411 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 55){
      item_list[i].set_id(421 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_armour_" + ((i%5)+1) + ".jpg");

    }else if(i < 60){
      item_list[i].set_id(431 + (i%5));
      item_list[i].set_img("src/item/equipment/assassin/assassin_accessory_" + ((i%5)+1) + ".jpg");
    
    /*****************************
    *  Mage equipment
    ******************************/
    }else if(i < 65){
      item_list[i].set_id(511 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 70){
      item_list[i].set_id(521 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 75){
      item_list[i].set_id(531 + (i%5));
      item_list[i].set_img("src/item/equipment/mage/mage_accessory_" + ((i%5)+1) + ".jpg");
      
    /*****************************
    *  Priest equipment
    ******************************/ 
    }else if(i < 80){
      item_list[i].set_id(611 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_weapon_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 85){
      item_list[i].set_id(621 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_armour_" + ((i%5)+1) + ".jpg");
      
    }else if(i < 90){
      item_list[i].set_id(631 + (i%5));
      item_list[i].set_img("src/item/equipment/priest/priest_accessory_" + ((i%5)+1) + ".jpg");
      
    /*****************************
    *  HP consumable
    ******************************/ 
    }else if(i < 93){
      item_list[i].set_id(11 + (i%10));
      item_list[i].set_img("src/item/consumable/hp_" + ((i%10)+1) + ".jpg");
      
    /*****************************
    *  MP consumable
    ******************************/ 
    }else if(i < 96){
      item_list[i].set_id(18 + (i%10));
      item_list[i].set_img("src/item/consumable/mp_" + (((i%10)+18) % 10) + ".jpg");
      
    /*****************************
    *  max potion
    ******************************/ 
    }else if(i < 97){
      item_list[i].set_id(31);
      item_list[i].set_img("src/item/consumable/max_potion.jpg");
      
    /*****************************
    *  revive potion
    ******************************/ 
    }else if(i < 98){
      item_list[i].set_id(39);
      item_list[i].set_img("src/item/consumable/revive.jpg");
     
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
                item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY, 1);
              }
              
          }
          break;
          
        case 2:
          if(i > bag.row / 2 - ((bag.row + 1) % 2)){
            if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + width/2) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 + bag.square_width)
              && mouseY >= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin 
              && mouseY <= ((i+1-(bag.row / 2 + bag.row % 2))*bag.vs + ((i-(bag.row / 2 + ((bag.row) % 2))) * bag.square_height))+ bag.vertical_margin + bag.square_height){
                
                if(bag.inv[i][j] != item_count - 1){
                    item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY, 1);
                }
            }    
          }else{
              if(mouseX >= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width) && mouseX <= ((j+1)*bag.hs + (j*bag.square_width) + width/2 - bag.UI_width + bag.square_width) 
                && mouseY >= ( ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin ) && mouseY <= ((i+1)*bag.vs + (i * bag.square_height))+ bag.vertical_margin + bag.square_height){
                  
                   if(bag.inv[i][j] != item_count - 1){
                       item_list[bag.inv[i][j]].desc(mouseX - bag.square_width * 3, mouseY, 1);
                   }
              }    
          }
          break;
      }
            
    }    //for loop(j)
  }    //for loop (i)
  
  //shop
  if(bag_mode == 3){
    
    item_desc(1);
    
    shop.dis_y = bag.vertical_margin + bag.vs;
    for(int i = 0; i < shop.sale_count; i++){
      if(i % 5 == 0){
        shop.dis_y += bag.vs + bag.square_height;
      }
      
      if(mouseX >= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width)
        && mouseX <= (bag.horizontal_margin + ((i%5)+1)*bag.hs + (i%5)*bag.square_width) + bag.square_width
        && mouseY >= shop.dis_y && mouseY <= shop.dis_y + bag.square_height){
          
          if(shop.sell[i] != item_list[item_count - 1]){
            shop.sell[i].desc(mouseX - bag.square_width * 3, mouseY, 0);
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
            shop.cart[i].desc(mouseX - bag.square_width * 3, mouseY, 0);
          }
          
      }
              
    }//end cart for
    
    
  }
}
