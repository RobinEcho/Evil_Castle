/*
  monster skill list:
  
  /************
  Normal:
  
  physical:
      
   patk * 1.4:
   
      Collision
      
      Body Blow
   
   patk * 1.6:
   
      Body Smash
      
      Fierce Fang
   
   patk * 1.8:
   
      Strike
      
      Armorbreak
  
  magical:
  
     matk * 1.6:
        
        Flame Branch
        
        Calamity

    matk * 1.8:
        
        Grumburst
        
        Magical power
    
    recovery mp or hp:
        
        rest
  
        focus
  /************ 
    Elite:
    
    Recovery self mp or hp and friendly hp:
        
        Synergistic effect
        
        Evil Pollution
        
   permanent patk increase and cause physical damage:
       
       Reshape
       
       Battle Posture
       
       patk * 1.1
    
   Recovery all mp but cause damage to self:
   
       Autophagy
       
       Factor conversion
       
   AOE physical damge:
   
       Luna's Howl
       
       Power of Dracula
   
   when hp < 50%, recovery 30% of hp, else mp recovery 50%:
   
       Nature choice
       
       Phototaxis evolution
       
   magical aoe:
       Space collapse
       
       Black hole devour
       
       matk * 1.4
   
   magical damage and steal lift
       
       Dim extraction
       
       Bloodthirsty
       
    
  /************  
*/



/*
   buff list:

   
    knight:
     
     0: pdef increase   
     
     1: Taunt
     
     2: patk increase
     
     3: AOE bleed
    
    Paladin:
     
     4: stun
     
     5: wont death
     
     6: heal
     
     7: sleep stun
    
    Ranger:
    
     8: Patk add Matk up, so as Matk
     
     9: AOE, stun
     
    Assassin:
     
     10: AGI increase
     
     11: AOE bleed
     
     12: Patk increase
     
    Mage:
     
     13: AOE stun
    
    Priest:
     
     14: All stats increase
     
     15: AOE all stats increase
*/


/*
    skill type:
      0: self as target
      1: ally as target
      2: enemy as target
    
    damage type:
      0: true damage
      1: physical damage
      2: magic damage
      3: recovery hp,mp
      4: buff
*/

/*
  command 0 - 5 : skills 1 - 6
  command 6 : normal attack
  command 7 : item usage
*/
/********************************************
room functions:

0: main menu
1: choose job
90: battle UI
80: bag UI, profile UI
81: bag option menu
99: option menu


*/

/************
ITEMS

3 hp
3 mp
1 full recover
1 revive
3 keys
90 equipment

(types)3 * (lv)5 * (job)6
***************

******       id     *********
//hp
11 - 13

//mp
21 - 23

//max pot
31

//revive
39

//knight
111 - 115
121 - 125
131 - 135

//paladin
211 - 215
221 - 225
231 - 235

//ranger
311 - 315
321 - 325
331 - 335

//assassin
411 - 415
421 - 425
431 - 435

//mage
511 - 515
521 - 525
531 - 535

//priest
611 - 615
621 - 625
631 - 635

//special
90 - 99
*/
