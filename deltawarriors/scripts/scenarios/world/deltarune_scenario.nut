this.deltarune_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.deltarune";
		this.m.Name = "Delta Warriors";
		this.m.Description = "[p=c][img]deltawarriors/gfx/ui/events/dscenariopic.png[/img][/p][p]Kris, Susie and Ralsei awake in the new world, where they must fight for coin. Will a company from another dimension succeed?\n\n[color=#bcad8c]Heroes:[/color] Start with three unique characters with special abilities.\n[color=#bcad8c]Glorious Three:[/color] You can never have more than 12 men in your roster, and if any of your three starting men should die, your campaign ends.\n[color=#bcad8c]Outlaws:[/color] Start with bad relations to most human factions.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 25;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
		return this.Const.DLC.Unhold;
		return this.Const.DLC.Desert;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx([
				"hedge_knight_background"
			]);
			bro.getSkills().removeByID("trait.survivor");
			bro.getSkills().removeByID("trait.greedy");
			bro.getSkills().removeByID("trait.loyal");
			bro.getSkills().removeByID("trait.disloyal");
			bro.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
			bro.setPlaceInFormation(3 + i);
			bro.getFlags().set("IsPlayerCharacter", true);
			bro.getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.m.PerkPoints = 0;
			bro.m.LevelUps = 0;
			bro.m.Level = 1;
			bro.m.Talents = [];
			bro.m.Attributes = [];
		}

		local bros = roster.getAll();
		local a;
		local u;
		bros[0].setTitle("Knight");
		bros[0].getTalents().resize(this.Const.Attributes.COUNT, 0);
		bros[0].getTalents()[this.Const.Attributes.MeleeDefense] = 2;
		bros[0].getTalents()[this.Const.Attributes.Fatigue] = 2;
		bros[0].getTalents()[this.Const.Attributes.MeleeSkill] = 3;
		bros[0].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		a = this.new("scripts/items/armor/mail_shirt");;
		bros[0].getItems().equip(a);
		bros[0].getItems().equip(this.new("scripts/items/weapons/longsword"));
		bros[0].improveMood(0.75, "Eager to explore new world");
		bros[1].setTitle("Dark Knight");
		bros[1].getTalents().resize(this.Const.Attributes.COUNT, 0);
		bros[1].getTalents()[this.Const.Attributes.Hitpoints] = 3;
		bros[1].getTalents()[this.Const.Attributes.Fatigue] = 2;
		bros[1].getTalents()[this.Const.Attributes.Bravery] = 2;
		bros[1].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		a = this.new("scripts/items/armor/ragged_surcoat");
		bros[1].getItems().equip(a);
		bros[1].getItems().equip(this.new("scripts/items/weapons/longaxe"));
		bros[1].improveMood(0.75, "Eager to explore new world");
		bros[2].setTitle("Dark Prince");
		bros[2].getTalents().resize(this.Const.Attributes.COUNT, 0);
		bros[2].getTalents()[this.Const.Attributes.MeleeDefense] = 2;
		bros[2].getTalents()[this.Const.Attributes.Initiative] = 3;
		bros[2].getTalents()[this.Const.Attributes.MeleeSkill] = 2;
		bros[2].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		a = this.new("scripts/items/armor/thick_dark_tunic");
		bros[2].getItems().equip(a);
		a = this.new("scripts/items/helmets/witchhunter_hat");
		bros[2].getItems().equip(a);
		bros[2].getItems().equip(this.new("scripts/items/weapons/oriental/battle_whip"));
		bros[2].improveMood(0.75, "Eager to explore new world");
		bros[0].getBackground().m.RawDescription = "{%fullname% thinks muscles make for glory. Wrong. Captain, it is I, " + bros[2].getName() + ", who commands the ladies of this realm. Need not ask me how. Behold! Look at it! Look at the size of it! Yeah. That\'s what I thought. Fools, train all you want, you can\'t have this!}";
		bros[0].getBackground().buildDescription(true);
		bros[1].getBackground().m.RawDescription = "{%fullname% is not the best warrior here, let\'s be clear. Captain, look at my muscles, is it not I, " + bros[0].getName() + ", who commands the greatest reward of life: the fear of one\'s own enemies! Look, if I lather a little and catch the light, the muscles gleam. Would it not be that the heavens were mistakened for above, when all the women say they find them right here, particularly here, upon my glorious pecs?}";
		bros[1].getBackground().buildDescription(true);
		bros[2].getBackground().m.RawDescription = "{Why are you looking at %fullname%? Captain, it is I, " + bros[1].getName() + ", who is your greatest gladiator. I am the one who swept the legs of a lindwurm and choked it out with its own tail! What you bastards say? You call that a tall tale? Pah! \'Tis a horizontal lizard at best.}";
		bros[2].getBackground().buildDescription(true);
		this.World.Assets.m.BusinessReputation = 50;
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() - 9);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_lamb_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2 - (this.World.Assets.getEconomicDifficulty() == 0 ? 0 : 300);
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 2;
		this.World.Assets.m.Ammo = 0;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(19);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.paladins_scenario_intro");
		}, null);
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

});