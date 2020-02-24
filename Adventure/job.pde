/*******************************************
set job, 6 in total
********************************************/ 
int p_class = 0;
int stats_count = 5;

public class Jobs{
  protected float patkAmp, pdefAmp, matkAmp, mdefAmp, spdAmp, hpAmp, mpAmp;
  protected float[] base_stats = new float[stats_count];
  protected float[] stats_inc = new float[stats_count];
  
  public Jobs(){
    patkAmp = 1;
    pdefAmp = 1;
    matkAmp = 1;
    mdefAmp = 1;
    spdAmp = 1;
    hpAmp = 1;
    mpAmp = 1;
  }
  
  public float getPatkAmp(){
    return this.patkAmp;
  }
  public float getPdefAmp(){
    return this.pdefAmp;
  }
  public float getMatkAmp(){
    return this.matkAmp;
  }
  public float getMdefAmp(){
    return this.mdefAmp;
  }
  public float getSpdAmp(){
    return this.spdAmp;
  }
  public float getHpAmp(){
    return this.hpAmp;
  }
  public float getMpAmp(){
    return this.mpAmp;
  }
  
  public float[] get_base_stats(){
    return this.base_stats;
  }
  
  public float[] get_stats_inc(){
    return this.stats_inc;
  }
}


/*******************************************
class job
********************************************/ 

class Job{
  public String name;
  public float[] amplifier = new float[7];
  public int code = 0;
  public float[] stats = new float[stats_count];

  public Job(){
  }
  
  public Job(int x){
    this.code = x;
    
    switch(code){
      case 1:
        this.name = "Knight";
        Knight knight = new Knight();
        init_Knight(knight);
        for(int i = 0; i < stats_count; i++){
          this.stats[i] = knight.get_base_stats()[i];
        }
        break;
        
      case 2:
        this.name = "Paladin";
        Paladin paladin = new Paladin();
        init_Paladin(paladin);
        for(int i = 0; i < stats_count; i++){
          this.stats[i] = paladin.get_base_stats()[i];
        }
        break;
      
      case 3:
        this.name = "Ranger";
        Ranger ranger = new Ranger();
        init_Ranger(ranger);
        for(int i = 0; i < stats_count; i++){
          this.stats[i] = ranger.get_base_stats()[i];
        }
        break;
        
      case 4:
        this.name = "Assassin";
        Assassin assassin = new Assassin();
        init_Assassin(assassin);
        for(int i = 0; i < stats_count; i++){
          this.stats[i] = assassin.get_base_stats()[i];
        }
        break;
        
      case 5:
        this.name = "Mage";
        Mage mage = new Mage();
        init_Mage(mage);
        for(int i = 0; i < stats_count; i++){
          this.stats[i] = mage.get_base_stats()[i];
        }
        break;
        
      case 6:
        this.name = "Priest";
        Priest priest = new Priest();
        init_Priest(priest);
        for(int i = 0; i < stats_count; i++){
          this.stats[i] = priest.get_base_stats()[i];
        }
        break;
    }
  }
  
  public void init_Knight(Knight k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }

  public void init_Priest(Priest k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Mage(Mage k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Paladin(Paladin k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Ranger(Ranger k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
  
  public void init_Assassin(Assassin k){
    amplifier[0] = k.getPatkAmp();
    amplifier[1] = k.getPdefAmp();
    amplifier[2] = k.getMatkAmp();
    amplifier[3] = k.getMdefAmp();
    amplifier[4] = k.getSpdAmp();
    amplifier[5] = k.getHpAmp();
    amplifier[6] = k.getMpAmp();
  }
}


public class Knight extends Jobs{
  //Skill skill = new Skill(1);
  
  public Knight(){
    base_stats[0] = 7.0;
    base_stats[1] = 11.0;
    base_stats[2] = 2.0;
    base_stats[3] = 6.0;
    base_stats[4] = 4.0;
    
    stats_inc[0] = 1.0;
    stats_inc[1] = 2.0;
    stats_inc[2] = 0.0;
    stats_inc[3] = 1.0;
    stats_inc[4] = 1.0;
    
    patkAmp = 1.5;
    pdefAmp = 2.0;
    matkAmp = 0.5;
    mdefAmp = 1.5;
    spdAmp = 1.0;
    hpAmp = 5;
    mpAmp = 1.5;
  }
}

class Paladin extends Jobs{
  //Skill skill = new Skill(4);
  
  public Paladin(){
    base_stats[0] = 5.0;
    base_stats[1] = 7.0;
    base_stats[2] = 5.0;
    base_stats[3] = 9.0;
    base_stats[4] = 4.0;
    
    stats_inc[0] = 1.0;
    stats_inc[1] = 1.0;
    stats_inc[2] = 1.0;
    stats_inc[3] = 2.0;
    stats_inc[4] = 0.0;
    
    patkAmp = 1.2;
    pdefAmp = 1.5;
    matkAmp = 1.5;
    mdefAmp = 2.0;
    spdAmp = 0.8;
    hpAmp = 5;
    mpAmp = 2.0;
  }
}

class Ranger extends Jobs{
  //Skill skill = new Skill(5);
  
  public Ranger(){
    base_stats[0] = 7.0;
    base_stats[1] = 5.0;
    base_stats[2] = 7.0;
    base_stats[3] = 2.0;
    base_stats[4] = 9.0;
    
    stats_inc[0] = 1.0;
    stats_inc[1] = 1.0;
    stats_inc[2] = 1.0;
    stats_inc[3] = 0.6;
    stats_inc[4] = 2.0;
    
    patkAmp = 2.0;
    pdefAmp = 1.0;
    matkAmp = 2.0;
    mdefAmp = 1.6;
    spdAmp = 2.2;
    hpAmp = 3.6;
    mpAmp = 1.6;
  }
}

class Assassin extends Jobs{
  //Skill skill = new Skill(5);
  
  public Assassin(){
    base_stats[0] = 8.0;
    base_stats[1] = 5.0;
    base_stats[2] = 1.0;
    base_stats[3] = 6.0;
    base_stats[4] = 10.0;
    
    stats_inc[0] = 1.0;
    stats_inc[1] = 1.0;
    stats_inc[2] = 0.6;
    stats_inc[3] = 1.0;
    stats_inc[4] = 2.0;
    
    patkAmp = 2.2;
    pdefAmp = 1.4;
    matkAmp = 0.5;
    mdefAmp = 1.6;
    spdAmp = 2.5;
    hpAmp = 4.5;
    mpAmp = 1.2;
  }
}

public class Mage extends Jobs{
  //Skill skill = new Skill(3);
  
  public Mage(){
    base_stats[0] = 1.0;
    base_stats[1] = 3.0;
    base_stats[2] = 13.0;
    base_stats[3] = 8.0;
    base_stats[4] = 5.0;
    
    stats_inc[0] = 0.0;
    stats_inc[1] = 1.0;
    stats_inc[2] = 2.0;
    stats_inc[3] = 2.0;
    stats_inc[4] = 0.0;
    
    patkAmp = 0.2;
    pdefAmp = 1.0;
    matkAmp = 2.8;
    mdefAmp = 2;
    spdAmp = 1.0;
    hpAmp = 3.5;
    mpAmp = 2.2;
  }
}

class Priest extends Jobs{
  //Skill skill = new Skill(2);
  
  public Priest(){
    base_stats[0] = 2.0;
    base_stats[1] = 6.0;
    base_stats[2] = 7.0;
    base_stats[3] = 10.0;
    base_stats[4] = 5.0;
    
    stats_inc[0] = 0.0;
    stats_inc[1] = 1.0;
    stats_inc[2] = 1.0;
    stats_inc[3] = 2.0;
    stats_inc[4] = 1.0;
    
    patkAmp = 1.0;
    pdefAmp = 1.5;
    matkAmp = 1.0;
    mdefAmp = 1.8;
    spdAmp = 1.2;
    hpAmp = 2.2;
    mpAmp = 2.3;
  }
}
