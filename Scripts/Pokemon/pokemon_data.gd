extends Resource

enum Type {
	NONE, 
	NORMAL,
	FIGHTING,
	FLYING,
	POISON,
	GROUND,
	ROCK,
	BUG,
	GHOST,
	STEEL,
	FIRE, 
	WATER, 
	GRASS,
	ELECTRIC,
	PSYCHIC,
	ICE,
	DRAGON,
	DARK,
	FAIRY
}

enum status {OK, FAINTED, POISONED, PARALYZED, ASLEEP, BURNED, FROZEN}
enum genders {MALE, FEMALE}

enum natures { 
	HARDY, LONELY, ADAMANT, NAUGHTY, BRAVE, 
	BOLD, DOCILE, IMPISH, LAX, RELAXED, 
	MODEST, MILD, BASHFUL, RASH, QUIET, 
	CALM, GENTLE, CAREFUL, QUIRKY, SASSY, 
	TIMID, HASTY, JOLLY, NAIVE, SERIOUS 
}

# Sprites
@export var battlers: Texture
@export var icons: Texture
@export var foot_print: Texture

# Basic data
@export var name = ""
@export var pokedex_number = ""
@export var pokedex_entry = ""
@export var height = ""
@export var weight = ""
@export var type_1: Type = 0
@export var type_2: Type = 0

# Base stats
@export var base_hp: int = 0
@export var base_attack: int = 0
@export var base_defence: int = 0
@export var base_special_attack: int = 0
@export var base_special_defence: int = 0
@export var base_speed: int = 0

@export var friendship = 0
@export var ev_yield_hp = 0
@export var ev_yield_attack = 0
@export var ev_yield_defence = 0
@export var ev_yield_special_attack = 0
@export var ev_yield_special_defence = 0
@export var ev_yield_speed = 0

# Evolution
@export var evolves_at_level: int = 0
@export var evolves_into: Resource

# Learnsets
@export var learnset = []

@export var nickname: String

@export var nature: natures

@export var ability: String

@export var gender: genders

# Stats
@export var level: int
var max_hp: int
var hp: int
var attack: int = 0
var defence: int = 0
var special_attack: int = 0
var special_defence: int = 0
var speed: int = 0
var experience: int = 0

# IV/EV
@export var hp_iv: int
@export var attack_iv: int = 0
@export var defence_iv: int = 0
@export var special_attack_iv: int = 0
@export var special_defence_iv: int = 0
@export var speed_iv: int = 0
@export var hp_ev: int
@export var attack_ev: int = 0
@export var defence_ev: int = 0
@export var special_attack_ev: int = 0
@export var special_defence_ev: int = 0
@export var speed_ev: int = 0

# Status condition
@export var condition: status

@export var item: Resource

# Moves
@export var moves: Array = [
#	{
#		"base_move": null,
#		"pp": 0,
#		"max_pp": 0,
#	},
]

func get_pokemon_name():
	if nickname:
		return nickname
	return name
