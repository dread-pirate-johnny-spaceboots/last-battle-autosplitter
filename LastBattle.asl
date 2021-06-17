state("Fusion") {
	byte state1 : 0x002A52D4, 0x0180; // 00 -> 00 -> 00
	byte state2 : 0x002A52D4, 0xE809; // 04 -> 04 -> 04
	byte state3 : 0x002A52D4, 0xEA01; // 1c -> 1c -> 1c
	byte boss1: 0x002A52D4, 0x5001; // 10 -> 10 -> 10
	byte boss2: 0x002A52D4, 0xE780; // 60 -> 47 -> 00
	byte boss3: 0x002A52D4, 0xFB49; // 22 -> 22 -> 22
	byte stagetrigger : 0x002A52D4, 0xEA00;
	byte bosshealth : 0x002A52D4, 0xE7BD;
	byte playerhealth : 0x002A52D4, 0xFE0D;
	byte title1 : 0x002A52D4, 0xFB03; // 0xEE while on title screen, 0x00 otherwise (including titlescreen demo)
	byte title2 : 0x002A52D4, 0xF73D; // 0x96 while running title demo, 0x00 -> 0x8A on game start
	byte newgame : 0x002A52D4, 0x00d7;
}

start {
	if (old.newgame == 0x00 && current.newgame == 0x3B) {
		return true;
	}
}

reset {
	if ( (old.title1 != 0xEE && current.title1 == 0xEE) || (old.playerhealth > 0 && current.playerhealth == 0) ) {
		return true;
	}
}

split {

	if (settings["stageTrigger"] && old.stagetrigger == 0x25 && current.stagetrigger == 0x60) {
		return true;
	}
	
	if (settings["hulkster"] && current.boss2 == 0x00 && old.boss2 == 0x3C && old.bosshealth == 0xFF && current.bosshealth == 0x00) {
		return true;
	}

	if (settings["butcher"] && (current.boss1 == 0x1E) && old.bosshealth > 0 && current.bosshealth == 0) {
		return true;
	}
 	
	if (settings["bossGroup1"] && current.boss2 == 0x3E && old.bosshealth < 0x8F && current.bosshealth > 0x8F) { // boss health jumps up past initial value on death
		return true;
	}
	
	if (settings["dareDevil"] && current.state2 == 0x04 && current.boss3 == 0x4C && old.state3 != 0x72 && current.state3 == 0x72) {
		return true;
	}
	
	if (settings["matador"] && current.state2 == 0x04 && current.boss3 == 0x22 && current.state1 == 0x00 && current.state3 == 0x1c && current.boss1 == 0x10 && (old.boss2 == 0x47 && current.boss2 == 0x00)) {
		return true;
	}
	
	if (settings["gromm"] && current.boss3 == 0xAE && (old.state3 == 0x1C && current.state3 == 0x10) ) {
		return true;
	}
	
	if (settings["garokkTalk"] && old.stagetrigger == 0x25 && current.stagetrigger == 0x00) {
		return true;
	}

	if (settings["gross"] && current.boss1 == 0x10 && old.boss2 == 0x60 && current.boss2 == 0x45) {
		return true;
	}
	
	if (settings["garokk"] && current.boss2 == 0x4A && (old.state2 == 0x04 && current.state2 == 0x3C) ) {
		return true;
	}
}

startup {
	settings.Add("stageTrigger", true, "End of level NPC encounters");
	settings.SetToolTip("stageTrigger", "Triggers a split whenever the player triggers dialogue with a friendly NPC at the end of a level");
	
	settings.Add("hulkster", true, "Hulkster");
	settings.SetToolTip("hulkster", "Triggers a split when the player beats the Hulkster");

	settings.Add("butcher", true, "Butcher");
	settings.SetToolTip("butcher", "Triggers a split when the player beats Butcher (stubby green goblin who throws balls)");
	
	settings.Add("bossGroup1", true, "Boss Group 1");
	settings.SetToolTip("bossGroup1", "Triggers a split when the player beats Syd, Duke or Sheeno (red masked guy)");
	
	settings.Add("dareDevil", true, "Dare Devil");
	settings.SetToolTip("dareDevil", "Triggers a split when the player beats Dare Devil (sea captain)");
	
	settings.Add("matador", true, "Matador / Alf of the Hourglass");
	settings.SetToolTip("matador", "Triggers a split when the player beats the matador (Alf of the Hourglass in HnK2, can't find a name for him in the Last Battle localization though)");
	
	settings.Add("gromm", true, "Gromm");
	settings.SetToolTip("gromm", "Triggers a split when the player beats Gromm");
	
	settings.Add("garokkTalk", true, "Spoke to Garokk");
	settings.SetToolTip("garokkTalk", "Triggers a split when the player speaks with Garokk in Chapter 4s The Garokk Castle area");
	
	settings.Add("gross", true, "Gross");
	settings.SetToolTip("gross", "Triggers a split when the player beats Gross");
	
	settings.Add("garokk", true, "Garokk");
	settings.SetToolTip("garokk", "Triggers a split when the player beats the final boss, Garokk, and wins the game");
}