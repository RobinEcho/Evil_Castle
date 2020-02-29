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
  public float[] stats_inc = new float[stats_count];

  public Job(){
  }
  
  public Job(int x){
    this.code = x;
    
    switch(code){
      case 1:
        this.name = "Knight";
        Knight knight = new Knight();
        init_Knight(knight);

          this.stats = knight.get_base_stats();
          this.stats_inc = knight.get_stats_inc();

        break;
        
      case 2:
        this.name = "Paladin";
        Paladin paladin = new Paladin();
        init_Paladin(paladin);

          this.stats = paladin.get_base_stats();
          this.stats_inc = paladin.get_stats_inc();
        break;
      
      case 3:
        this.name = "Ranger";
        Ranger ranger = new Ranger();
        init_Ranger(ranger);

          this.stats = ranger.get_base_stats();
          this.stats_inc = ranger.get_stats_inc();
        break;
        
      case 4:
        this.name = "Assassin";
        Assassin assassin = new Assassin();
        init_Assassin(assassin);

          this.stats = assassin.get_base_stats();
          this.stats_inc = assassin.get_stats_inc();
        break;
        
      case 5:
        this.name = "Mage";
        Mage mage = new Mage();
        init_Mage(mage);

          this.stats = mage.get_base_stats();
          this.stats_inc = mage.get_stats_inc();
        break;
        
      case 6:
        this.name = "Priest";
        Priest priest = new Priest();
        init_Priest(priest);

          this.stats = priest.get_base_stats();
          this.stats_inc = priest.get_stats_inc();
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
    base_stats[0] = 10.0;
    base_stats[1] = 15.0;
    base_stats[2] = 5.0;
    base_stats[3] = 9.0;
    base_stats[4] = 7.0;
    
    stats_inc[0] = 2.2;
    stats_inc[1] = 3.6;
    stats_inc[2] = 0.8;
    stats_inc[3] = 2.0;
    stats_inc[4] = 1.8;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Paladin extends Jobs{
  //Skill skill = new Skill(4);
  
  public Paladin(){
    base_stats[0] = 8.0;
    base_stats[1] = 10.0;
    base_stats[2] = 8.0;
    base_stats[3] = 12.0;
    base_stats[4] = 6.0;
    
    stats_inc[0] = 1.8;
    stats_inc[1] = 3.0;
    stats_inc[2] = 1.8;
    stats_inc[3] = 3.0;
    stats_inc[4] = 1.5;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Ranger extends Jobs{
  //Skill skill = new Skill(5);
  
  public Ranger(){
    base_stats[0] = 11.0;
    base_stats[1] = 7.0;
    base_stats[2] = 11.0;
    base_stats[3] = 6.0;
    base_stats[4] = 12.0;
    
    stats_inc[0] = 2.8;
    stats_inc[1] = 1.8;
    stats_inc[2] = 2.8;
    stats_inc[3] = 1.2;
    stats_inc[4] = 3.1;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Assassin extends Jobs{
  //Skill skill = new Skill(5);
  
  public Assassin(){
    base_stats[0] = 13.0;
    base_stats[1] = 7.5;
    base_stats[2] = 3.0;
    base_stats[3] = 8.0;
    base_stats[4] = 15.0;
    
    stats_inc[0] = 3.0;
    stats_inc[1] = 2.0;
    stats_inc[2] = 0.4;
    stats_inc[3] = 1.5;
    stats_inc[4] = 3.6;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

public class Mage extends Jobs{
  //Skill skill = new Skill(3);
  
  public Mage(){
    base_stats[0] = 4.0;
    base_stats[1] = 6.0;
    base_stats[2] = 18.0;
    base_stats[3] = 10.0;
    base_stats[4] = 6.0;
    
    stats_inc[0] = 1.0;
    stats_inc[1] = 2.3;
    stats_inc[2] = 3.5;
    stats_inc[3] = 2.5;
    stats_inc[4] = 1.2;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}

class Priest extends Jobs{
  //Skill skill = new Skill(2);
  
  public Priest(){
    base_stats[0] = 6.0;
    base_stats[1] = 9.0;
    base_stats[2] = 11.0;
    base_stats[3] = 15.0;
    base_stats[4] = 7.0;
    
    stats_inc[0] = 1.0;
    stats_inc[1] = 2.7;
    stats_inc[2] = 2.0;
    stats_inc[3] = 3.6;
    stats_inc[4] = 1.8;
    
    patkAmp = 2;
    pdefAmp = 2;
    matkAmp = 2;
    mdefAmp = 2;
    spdAmp = 2;
    hpAmp = 5;
    mpAmp = 2;
  }
}
