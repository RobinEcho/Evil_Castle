public class Stats{
	public static void main(String[] args){
		float patk, pdef, matk, mdef, spd, hp, mp;
		
		float str = 1, con = 3, intel = 13, wis = 8, agi = 5;
		
		float amp[] = {0.5f,
						1.0f,
						2.8f,
						2.0f,
						1.0f,
						3.0f,
						2.2f
						};
						
		for(int i = 1; i < 26; i++){
			str += 0;
			con += 1;
			intel += 2;
			wis += 2;
			agi += 0;
			
			patk = str * amp[0] + i * (2 + amp[0]);
			pdef = con * amp[1] + i * 3.0f;
			matk = intel * amp[2] + i * (2 + amp[2]);
			mdef = wis * amp[3] + i * 3.5f;
			spd = agi * amp[4] + i * (1 + amp[4]);
			hp = con * (3 + amp[5]) * 2 + i * (8 + amp[5]);
			mp = wis * (2 + amp[6]) + i * (3 + amp[6]);
			
			System.out.printf("Level: %d patk: %.2f pdef: %.2f matk: %.2f mdef: %.2f spd: %.2f hp: %.2f mp: %.2f\n", i, patk, pdef, matk, mdef, spd, hp, mp);
			
		}
	}
}