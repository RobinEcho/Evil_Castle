class Monster_AI{
  protected int target, mode;
  
  public int get_target(){
    return this.target;
  }
  
  public void attack_mode(){
  }
}

class Normal extends Monster_AI{
  public Normal(){
    mode = 1;
  }
  
  @Override
  public void attack_mode(){
    do{
      this.target = r.nextInt(100) % c_pt;
    }while(!p[this.target].is_alive());
    
    attack(mid, target, 1);
  }
}

class Elite extends Monster_AI{

}

class Boss extends Monster_AI{


}
