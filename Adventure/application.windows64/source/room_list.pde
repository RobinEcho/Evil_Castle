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
  BOSS
  
  floor 2:
  
  Manipulator of Flame: magical damage, matk*1.8, mpdec = 30%
  
  Endlessly: if hp < 50%, regenerate hp 15%, otherwise regenerate all mp, mpdec = 0
  
  Oppression of libraries: AOE magical attack, matk * 1.2, mpdec = 40%
  
  Parsing: cause magical damage and increse self matk, matk * 1.4, mpdec = 40%
  
  
  floor 3:
  
  Feeding mania: physical, patk * 1.4 , mpdec = 20%
  
  Cannibalism: cause physical damage and regenerate same hp, mpdec = 30%
  
  Digestion: regenerate 60%mp and if hp < 50%, pdef increse 20% otherwise patk incrse 10%
  
  Necrotic Realm: physical AOE damage, patk * 1.4,mp_dec = 60%
  
  floor 4: 
  
  Duke engine: Case magical damage matk * 1.2 mpdec = 10%
  
  Reset: Reset all playerside buff and regenerate hp 20% mp_dec = 40%
  
  Meditation: Regenerate 50 % mp and increse 10 % matk
  
  Elemental Storm: cause magical damage, matk * 1.6 mpdec = 60 %
  
  floor 5:
  
  
  
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
