
::deltarune <- {
	ID = "mod_deltarune",
	Name = "deltawarriors",
	Version = "0.1.5",
}

::deltarune.HooksMod <- ::Hooks.register(::deltarune.ID, ::deltarune.Version, ::deltarune.Name);
::deltarune.HooksMod.require(["mod_msu"]);

::deltarune.HooksMod.queue(">mod_msu", function() {
	::deltarune.Mod <- ::MSU.Class.Mod(::deltarune.ID, ::deltarune.Version, ::deltarune.Name);

});


// Checklist:
// - replace all instances of "modMODID" (in all files) with your mods global key handle of choice. This id should be unique enough to hopefully not ever be picked by someone else
// - replace all instances of "mod_MODID" (in all files) with your modid of choice. Mods usually always start with "mod_". This id should be unique enough to hopefully not ever be picked by someone else
// - replace all instances of "mod_MODID" in all existing folders and scriptnames
// - replace "MODID" in the name of this (main) file with your modid of choice.
// - replace the value of 'Name' with your written out mod name separated with spacebars
// - 'Version' will normally start at 0.1.0 for your first version/release