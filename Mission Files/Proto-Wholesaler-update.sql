INSERT INTO traders_data (`item`, `qty`, `buy`, `sell`, `tid`)
VALUES
	#wholesaler 1
	('["bulk_ItemSandbag",1]', 500, '[50,"ItemSilverBar",1]', '[10,"ItemSilverBar",1]', 111),
	('["bulk_ItemTankTrap",1]', 500, '[6,"ItemGoldBar",1]', '[10,"ItemSilverBar",1]', 111),
	('["bulk_ItemWire",1]', 500, '[50,"ItemSilverBar",1]', '[10,"ItemSilverBar",1]', 111),
	('["bulk_PartGeneric",1]', 500, '[150,"ItemSilverBar",1]', '[30,"ItemSilverBar",1]', 111),
	
	('["CinderBlocks",1]', 500, '[4,"ItemSilverBar",1]', '[1,"ItemSilverBar",1]', 111),
	('["MortarBucket",1]', 500, '[24,"ItemSilverBar",1]', '[18,"ItemSilverBar",1]', 111),
	('["PartPlankPack",1]', 500, '[3,"ItemSilverBar",1]', '[1,"ItemSilverBar",1]', 111),
	('["PartPlywoodPack",1]', 500, '[12,"ItemSilverBar",1]', '[6,"ItemSilverBar",1]', 111),
	
	('["ItemWoodWall",1]', 500, '[70,"ItemSilverBar",1]', '[46,"ItemSilverBar",1]', 111),
	('["ItemWoodFloor",1]', 500, '[90,"ItemSilverBar",1]', '[60,"ItemSilverBar",1]', 111),
	('["cinder_wall_kit",1]', 500, '[54,"ItemSilverBar",1]', '[36,"ItemSilverBar",1]', 111),
	
		#bulk ammo
	('["bulk_15Rnd_9x19_M9SD",1]', 500, '[3,"ItemSilverBar",1]', '[2,"ItemSilverBar",1]', 121),
	('["bulk_17Rnd_9x19_glock17",1]', 500, '[4,"ItemSilverBar",1]', '[3,"ItemSilverBar",1]', 121),
	('["bulk_30Rnd_556x45_StanagSD",1]', 500, '[13,"ItemSilverBar",1]', '[6,"ItemSilverBar",1]', 121),
	('["bulk_30Rnd_9x19_MP5SD",1]', 500, '[6,"ItemSilverBar",1]', '[4,"ItemSilverBar",1]', 121),
	
	#wholesaler 2
	('["bulk_ItemSandbag",1]', 500, '[50,"ItemSilverBar",1]', '[10,"ItemSilverBar",1]', 112),
	('["bulk_ItemTankTrap",1]', 500, '[6,"ItemGoldBar",1]', '[10,"ItemSilverBar",1]', 112),
	('["bulk_ItemWire",1]', 500, '[50,"ItemSilverBar",1]', '[10,"ItemSilverBar",1]', 112),
	('["bulk_PartGeneric",1]', 500, '[150,"ItemSilverBar",1]', '[30,"ItemSilverBar",1]', 112),
	
	('["CinderBlocks",1]', 500, '[4,"ItemSilverBar",1]', '[1,"ItemSilverBar",1]', 112),
	('["MortarBucket",1]', 500, '[24,"ItemSilverBar",1]', '[18,"ItemSilverBar",1]', 112),
	('["PartPlankPack",1]', 500, '[3,"ItemSilverBar",1]', '[1,"ItemSilverBar",1]', 112),
	('["PartPlywoodPack",1]', 500, '[12,"ItemSilverBar",1]', '[6,"ItemSilverBar",1]', 112),
	
	('["ItemWoodWall",1]', 500, '[70,"ItemSilverBar",1]', '[46,"ItemSilverBar",1]', 112),
	('["ItemWoodFloor",1]', 500, '[90,"ItemSilverBar",1]', '[60,"ItemSilverBar",1]', 112),
	('["cinder_wall_kit",1]', 500, '[54,"ItemSilverBar",1]', '[36,"ItemSilverBar",1]', 112),
	
		#bulk ammo
	('["bulk_15Rnd_9x19_M9SD",1]', 500, '[3,"ItemSilverBar",1]', '[2,"ItemSilverBar",1]', 122),
	('["bulk_17Rnd_9x19_glock17",1]', 500, '[4,"ItemSilverBar",1]', '[3,"ItemSilverBar",1]', 122),
	('["bulk_30Rnd_556x45_StanagSD",1]', 500, '[13,"ItemSilverBar",1]', '[6,"ItemSilverBar",1]', 122),
	('["bulk_30Rnd_9x19_MP5SD",1]', 500, '[6,"ItemSilverBar",1]', '[4,"ItemSilverBar",1]', 122);

Delete From Traders_DATA
Where tid=111 or tid=112;

#Delete current Wholesalers
Delete From Traders_DATA
Where tid=555 or tid=636;
