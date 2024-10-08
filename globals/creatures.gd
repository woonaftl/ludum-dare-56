extends Node


const NAME_BY_CREATURE = {
	ScenePaths.BOSS: "BOSS",
	ScenePaths.LICE: "LICE",
	ScenePaths.SPIDER: "SPIDER",
	ScenePaths.ROACH: "ROACH",
	ScenePaths.CRUSADER: "CRUSADER",
	ScenePaths.LASIK: "LASIK",
	ScenePaths.PYRO: "PYRO",
	ScenePaths.SCARAB: "SCARAB",
	ScenePaths.SHERIFF: "SHERIFF",
	ScenePaths.SPEARCAT: "SPEARCAT",
	ScenePaths.WITCH: "WITCH",
}
const SPRITE_BY_CREATURE = {
	ScenePaths.BOSS: preload("uid://6auxws5x7wir"),
	ScenePaths.LICE: preload("uid://bgq1r1n86k4ns"),
	ScenePaths.SPIDER: preload("uid://ffevggw1ukbv"),
	ScenePaths.ROACH: preload("uid://cc4k8bpe2sb66"),
	ScenePaths.CRUSADER: preload("uid://dhxeua2sngcos"),
	ScenePaths.LASIK: preload("uid://bhiwt71vycmfg"),
	ScenePaths.PYRO: preload("uid://y4e37406dwxd"),
	ScenePaths.SCARAB: preload("uid://dec61jndlaeml"),
	ScenePaths.SHERIFF: preload("uid://bui3yd7bvf77r"),
	ScenePaths.SPEARCAT: preload("uid://btnq8mtb8ge8e"),
	ScenePaths.WITCH: preload("uid://bqfvwsnumwt3f"),
}


var unlocks: Array = [
	ScenePaths.SHERIFF,
	ScenePaths.LICE,
]
