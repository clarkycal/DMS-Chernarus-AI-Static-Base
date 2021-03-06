/*
	"Ai Base" DMS static mission for Chernarus.
	Created by Clarkycal/ClarkycalLad using templates by eraser1 with mission code layout and features inspired by mission files from [CiC]red_ned and Riker. Thanks guys!	
	http://www.exilemod.com/topic/21734-release-dms-chernarus-static-ai-base-mission/
*/

////////////////////////////////////////////////
// Variable Declarations & Array configs
////////////////////////////////////////////////
private ["_pos", "_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate2", "_crate3", "_crate4", "_crate_loot_values0", "_crate_loot_values1", "_crate_loot_values2", "_crate_loot_values3", "_crate_loot_values4", "_crate_weapons0", "_crate_weapons1", "_crate_weapons2", "_crate_weapons3", "_crate_weapons4", "_crate_items0", "_crate_items1", "_crate_items2", "_crate_items3", "_crate_items4", "_crate_backpacks0", "_crate_backpacks1", "_crate_backpacks2", "_crate_backpacks3", "_crate_backpacks4", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_veh", "_veh1", "_veh2", "_crate1_item_list", "_crate1_weapon_list", "_crate3_Item_List", "_crate4_item_list", "_ai_vehicle_list", "_ai_vehicle_0", "_ai_vehicle_1", "_crate4_position_list", "_crate4_position"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

// Mission position (don't change this, all AI are at hardcoded locations)
_pos = [6445.300,14171.404,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Uncomment the line below if you want to use CUP Weapons in the crates or CUP vehicles in the AI vehicles
//#define USE_CUP_WEAPONS 1
//#define USE_CUP_VEHICLES 1

// Armed Roaming Vehicle Options for DMS to choose from (this is an override to allow you to specify harder vehicles and includes things like armed Striders and Gorgons by default)
_ai_vehicle_list = 
	[
		#ifdef USE_CUP_VEHICLES
		"CUP_B_LR_Special_CZ_W",
		"CUP_B_HMMWV_Crows_MK19_USA",
		"CUP_O_GAZ_Vodnik_BPPU_RU",
		"CUP_B_HMMWV_M2_GPK_USA",
		"CUP_B_HMMWV_DSHKM_GPK_ACR",
		"CUP_B_HMMWV_Crows_MK19_USA",
		"CUP_O_GAZ_Vodnik_BPPU_RU",
		"CUP_B_HMMWV_M2_GPK_USA",
		"CUP_B_HMMWV_DSHKM_GPK_ACR",
		#endif
		"Exile_Car_Offroad_Armed_Guerilla01",
		"Exile_Car_SUV_Armed_Black",
		"O_MRAP_02_hmg_F",
		"O_MRAP_02_hmg_F",
		"B_MRAP_01_hmg_F",
		"I_MRAP_03_hmg_F"
	];

// create possible difficulty add more of one difficulty to weight it towards that. If testing, comment this section out and uncomment the forced easy mode below.
_PossibleDifficulty		= 	[	
								"moderate",
								"moderate",
								"moderate",
								"difficult"
								//"difficult",
								//"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

// FOR TESTING ONLY, SETS DIFFICULTY TO EASY WITH MINIMAL AI
// _difficultyM = "easy";

// Define the Speciality Crate Item Lists
// Crate 1 is intended to be Sniper Rifles, Crate 3 is the one in the medical area and Crate 4 is the randomly placed one so was intended to have specialty gear in it.
// Note that these arrays are just there as a possible list of items, the mission picks a random selection from these lists each time.

_crate1_weapon_list	= 
	[
		#ifdef USE_CUP_WEAPONS 
		"CUP_srifle_M110",
		"CUP_srifle_AWM_wdl",
		"CUP_srifle_M107_Base",
		#endif
		"srifle_DMR_02_camo_F",
		"srifle_DMR_02_sniper_F",
		"srifle_DMR_03_khaki_F",
		"srifle_DMR_03_multicam_F",
		"srifle_DMR_03_woodland_F",
		"srifle_DMR_04_F",
		"srifle_DMR_04_Tan_F",
		"srifle_DMR_05_blk_F",
		"srifle_DMR_05_hex_F",
		"srifle_DMR_05_tan_f",
		"srifle_DMR_06_camo_F",
		"srifle_DMR_06_olive_F",
		"srifle_EBR_F",
		"srifle_GM6_camo_F",
		"srifle_LRR_camo_F"
	];

_crate1_item_list =
	[
		#ifdef USE_CUP_WEAPONS
		"CUP_5Rnd_86x70_L115A1",
		"CUP_5Rnd_86x70_L115A1",
		"CUP_10Rnd_127x99_m107",
		"CUP_20Rnd_TE1_Green_Tracer_762x51_M110",
		"CUP_20Rnd_TE1_Green_Tracer_762x51_M110",
		"CUP_20Rnd_TE1_Green_Tracer_762x51_M110",
		#endif
		"10Rnd_93x64_DMR_05_Mag",
		"10Rnd_93x64_DMR_05_Mag",
		"10Rnd_93x64_DMR_05_Mag",
		"10Rnd_93x64_DMR_05_Mag",
		"10Rnd_93x64_DMR_05_Mag",
		"10Rnd_93x64_DMR_05_Mag",
		"10Rnd_93x64_DMR_05_Mag",
		"100Rnd_65x39_caseless_mag",
		"10Rnd_127x54_Mag",
		"16Rnd_9x21_Mag",
		"100Rnd_65x39_caseless_mag",
		"10Rnd_127x54_Mag",
		"16Rnd_9x21_Mag",
		"16Rnd_9x21_Mag"
	];
	
_crate3_Item_List = 
	[
		"Exile_Item_InstaDoc",
		"Exile_Item_Vishpirin",
		"Exile_Item_Vishpirin",
		"Exile_Item_Vishpirin",
		"Exile_Item_Bandage",
		"Exile_Item_Bandage",
		"Exile_Item_Bandage",
		"Exile_Item_Bandage",
		"Exile_Item_Bandage"
	];

_crate4_weapon_list	= 
	[
		#ifdef USE_CUP_WEAPONS 
		"CUP_hgun_MicroUzi",
		"CUP_hgun_MicroUzi",
		"CUP_muzzle_snds_MicroUzi",
		#endif
		"launch_B_Titan_short_F",
		"launch_Titan_F",
		"launch_RPG32_F",
		"launch_NLAW_F"
	];

_crate4_item_list	= 
	[
		#ifdef USE_CUP_WEAPONS
		"CUP_30Rnd_9x19_UZI",
		"CUP_30Rnd_9x19_UZI",
		"CUP_30Rnd_9x19_UZI",
		"CUP_30Rnd_9x19_UZI",
		#endif
		"Laserdesignator",
		"H_HelmetO_ViperSP_hex_F",
		"H_HelmetO_ViperSP_ghex_F",
		"I_UAV_01_backpack_F",
		"RPG32_HE_F",
		"NLAW_F",
		"Titan_AT",
		"Titan_AP",
		"Titan_AA",
		"RPG32_F",
		"RPG32_HE_F",
		"Exile_SafeKit",
		"Exile_CodeLock",
		"optic_Nightstalker",
		"optic_TWS"
	];


/////////////////////////////////////////////
// Mission Difficulty and Loot level setups
/////////////////////////////////////////////

switch (_difficultyM) do
{
	case "easy":	//Used for TESTING purposes only, this is WAY too easy and has too much loot.
	{
_difficulty = "easy";									//AI difficulty
_AICount = (3 + (round (random 5)));					//AI starting numbers
_AIMaxReinforcements = (10 + (round (random 5)));		//AI reinforcement cap
_AItrigger = (2 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax
_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
_crate_weapons0 	= (50 + (round (random 20)));		//Crate 0 weapons number (General weapons)
_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
_crate_weapons1 	= (20 + (round (random 2)));		//Crate 1 weapons number	(sniper rifles)
_crate_items1 		= (50 + (round (random 40)));		//Crate 1 items number		(sniper ammo)
_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
_crate_weapons2 	= (1 + (round (random 1)));
_crate_items2		= (50 + (round (random 10)));		// Crate 2 = Building supplies
_crate_backpacks2 	= (1 + (round (random 1)));
_crate_weapons3		= (1 + (round (random 1)));			// Crate 3 = Medical
_crate_items3	 	= (50 + (round (random 10)));		
_crate_backpacks3	= (1 + (round (random 1)));
_crate_weapons4		= (10 + (round (random 1)));		// Crate 4 = Special items
_crate_items4	 	= (30 + (round (random 10)));
_crate_backpacks4	= (1 + (round (random 1)));
	};
	case "moderate":
	{
_difficulty = "moderate";
_AICount = (40 + (round (random 5))); 
_AIMaxReinforcements = (10 + (round (random 10)));
_AItrigger = (10 + (round (random 10)));
_AIwave = (5 + (round (random 3)));
_AIdelay = (55 + (round (random 120)));
_crate_weapons0 	= (20 + (round (random 15)));		// Crate 0 = General Items
_crate_items0 		= (10 + (round (random 15)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (10 + (round (random 3)));		// Crate 1 = Sniper Rifles
_crate_items1 		= (20 + (round (random 20)));
_crate_backpacks1 	= (30 + (round (random 4)));
_crate_weapons2 	= (1 + (round (random 1)));			// Crate 2 = Building Supplies
_crate_items2		= (50 + (round (random 10)));
_crate_backpacks2 	= (1 + (round (random 1)));
_crate_weapons3		= (1 + (round (random 1)));			// Crate 3 = Medical
_crate_items3	 	= (50 + (round (random 10)));
_crate_backpacks3	= (1 + (round (random 1)));
_crate_weapons4		= (4 + (round (random 1)));			// Crate 4 = Special items
_crate_items4	 	= (10 + (round (random 10)));
_crate_backpacks4	= (1 + (round (random 1)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (40 + (round (random 7)));
_AIMaxReinforcements = (15 + (round (random 10)));
_AItrigger = (10 + (round (random 10)));
_AIwave = (6 + (round (random 2)));
_AIdelay = (55 + (round (random 120)));
_crate_weapons0 	= (30 + (round (random 20)));		// Crate 0 = General Items
_crate_items0 		= (15 + (round (random 10)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (15 + (round (random 3)));		// Crate 1 = Sniper Rifles
_crate_items1 		= (25 + (round (random 30)));
_crate_backpacks1 	= (1 + (round (random 4)));
_crate_weapons2 	= (1 + (round (random 1)));			// Crate 2 = Building Supplies
_crate_items2		= (70 + (round (random 20)));
_crate_backpacks2 	= (1 + (round (random 1)));
_crate_weapons3		= (1 + (round (random 1)));			// Crate 3 = Medical
_crate_items3	 	= (70 + (round (random 20)));
_crate_backpacks3	= (1 + (round (random 1)));
_crate_weapons4		= (6 + (round (random 2)));			// Crate 4 = Special items
_crate_items4	 	= (15 + (round (random 10)));
_crate_backpacks4	= (1 + (round (random 1)));
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore"; 
_AICount = (50 + (round (random 10)));
_AIMaxReinforcements = (20 + (round (random 10)));
_AItrigger = (15 + (round (random 5)));
_AIwave = (6 + (round (random 2)));
_AIdelay = (55 + (round (random 120)));
_crate_weapons0 	= (30 + (round (random 15)));		// Crate 0 = General Items
_crate_items0 		= (20 + (round (random 5)));
_crate_backpacks0 	= (2 + (round (random 1)));
_crate_weapons1 	= (20 + (round (random 2)));		// Crate 1 = Sniper Rifles
_crate_items1 		= (50 + (round (random 10)));
_crate_backpacks1 	= (5 + (round (random 2)));	
_crate_weapons2 	= (1 + (round (random 1)));			// Crate 2 = Building Supplies
_crate_items2		= (100 + (round (random 10)));
_crate_backpacks2 	= (1 + (round (random 1)));
_crate_weapons3		= (1 + (round (random 1)));			// Crate 3 = Medical
_crate_items3	 	= (100 + (round (random 10)));
_crate_backpacks3	= (1 + (round (random 1)));
_crate_weapons4		= (8 + (round (random 4)));			// Crate 4 = Special items
_crate_items4	 	= (20 + (round (random 10)));		
_crate_backpacks4	= (1 + (round (random 1)));
	};
};


////////////////////////////////////////////////////////////////////////////
// Mission Creation Section - Don't touch the below unless you know what you're doing.
////////////////////////////////////////////////////////////////////////////

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[6457.58,14219.7,0],
	[6444.63,14190,0],
	[6438,14138.4,0],
	[6369.81,14205.5,0],
	[6378.74,14151.2,0],
	[6383.65,14116.1,0],
	[6490.03,14128.5,0],
	[6502.67,14213,0]
];
_group =
[
	_AISoldierSpawnLocations,			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,											// Set in difficulty select
	_difficulty,										// Set in difficulty select
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;

_staticGuns =
[
	[
		[6513.35,14100.7,0],
		[6505.72,14177.2,0],
		[6497.52,14226.1,0],
		[6445.1,14171.2,0],
		[6393.63,14092.7,0],
		[6392.54,14233.4,0],
		[6389.12,14173.4,0]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;

// This is the first AI Vehicle, randomly selected from the above array; _ai_vehicle_list.
_ai_vehicle_0 = selectRandom _ai_vehicle_list;
_veh =
[
	[
		[6557.35,14179.7,0],
		[6332.9,14067,0]
	],
	_group,
	"random",
	_difficulty,
	_side,
	_ai_vehicle_0	//Classname of the vehicle we want to spawn, use "random" if you just want one of the default DMS armed vehicles.
] call DMS_fnc_SpawnAIVehicle;

// This is the second AI Vehicle, randomly selected from the above array; _ai_vehicle_list.
_ai_vehicle_1 = selectRandom _ai_vehicle_list;
_veh1 =
[
	[
		[6417.93,13976,0],
		[6372.2,14351,0]
	],
	_group,
	"random",
	_difficulty,
	_side,
	_ai_vehicle_1	//Classname of the vehicle we want to spawn, use "random" if you just want one of the default DMS armed vehicles.
] call DMS_fnc_SpawnAIVehicle;

// Define the classnames and locations where the crates can spawn (at least 5, since we're spawning 5 crates), crate 4 contains high end gear so has random spawn location to make it harder to find :)
// Crate 4 has high end items so to make it more interesting, this has a random component to it. The list below sets the possible locations.
_crate4_position_list = 
[
	[6457.29,14093.2,0],
	[6444.37,14116.1,0],
	[6415.12,14239.3,0],
	[6365.77,14100.1,0],
	[6419.47,14158.1,0]
];
_crate4_position = selectRandom _crate4_position_list;

_crateClasses_and_Positions =
[
	[[6389.45,14181.5,0],"I_CargoNet_01_ammo_F"],
	[[6436.8,14172.7,0],"I_CargoNet_01_ammo_F"],
	[[6451.94,14171,0],"I_CargoNet_01_ammo_F"],
	[[6510.65,14185.4,0],"I_CargoNet_01_ammo_F"],
	[_crate4_position,"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list (I've disabled this as I don't feel it fits the mission, if you want playets to not know which crate has medical or snipers etc. then re-enable this)
// _crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;	// Contents - General
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;	// Contents - Sniper Rifles
_crate2 = [_crateClasses_and_Positions select 2 select 1, _crateClasses_and_Positions select 2 select 0] call DMS_fnc_SpawnCrate;	// Contents - Building Supplies
_crate3 = [_crateClasses_and_Positions select 3 select 1, _crateClasses_and_Positions select 3 select 0] call DMS_fnc_SpawnCrate;	// Contents - Medical
_crate4 = [_crateClasses_and_Positions select 4 select 1, _crateClasses_and_Positions select 4 select 0] call DMS_fnc_SpawnCrate;	// Contents - Special

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0,_crate1,_crate2,_crate3,_crate4];

// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				0,		// Let's limit number of units instead...
				0
			],
			[
				_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
		]
	]
];

// setup crates with items from choices
_crate_loot_values0 =
[
	_crate_weapons0,		// Set in difficulty select - Weapons
	_crate_items0,			// Set in difficulty select - Items
	_crate_backpacks0 		// Set in difficulty select - Backpacks
];
_crate_loot_values1 =
[
	[_crate_weapons1,_crate1_weapon_list],		// Set in difficulty select - Weapons
	[_crate_items1,_crate1_item_list],			// Set in difficulty select - Items
	_crate_backpacks1 		// Set in difficulty select - Backpacks
];
_crate_loot_values2 =		// This is the Building Supplies Crate
[
	_crate_weapons2,		// Set in difficulty select - Weapons
	[_crate_items2,DMS_BoxBuildingSupplies],			// Set in difficulty select - Items
	_crate_backpacks2 		// Set in difficulty select - Backpacks
];
_crate_loot_values3 =		// This is the medical crate
[
	_crate_weapons3,		// Set in difficulty select - Weapons
	[_crate_items3,_Crate3_Item_List],			// Set in difficulty select - Items, the item list is from an array below the difficulty selection.
	_crate_backpacks3 		// Set in difficulty select - Backpacks
];
_crate_loot_values4 =		// This is the medical crate
[
	[_crate_weapons4,_crate4_weapon_list],		// Set in difficulty select - Weapons
	[_crate_items4,_crate4_item_List],			// Set in difficulty select - Items, the item list is from an array below the difficulty selection.
	_crate_backpacks4 		// Set in difficulty select - Backpacks
];
// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns+[_veh]+[_veh1],			// static gun(s) & AI Vehicles. Note, we don't add the base itself because it already spawns on server start.
	[],							// no vehicle prize, they can capture the AI vehicles on originating server and there's HEAPS of loot here.....
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1],[_crate2,_crate_loot_values2],[_crate3,_crate_loot_values3],[_crate4,_crate_loot_values4]]
];

// Define Mission Start message
_msgStart = ['#FFFF00',format["A large group of Military Soldiers have built a base and are awaiting your arrival.....",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Military Soldiers and claimed all the loot for themselves!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The Military Soldiers have finished their beers and buggered off..."];

// Define mission name (for map marker and logging)
_missionName = "Military Soldiers Base";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficultyM
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 20;
_circle setMarkerSize [300,300];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[[],[]]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;

	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;

	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};

// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;

if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};
