extends Node

var player_name: String = "REBECCA"
var trainer_id: int = 45036
var money: int = 500
var pokedex: int = 3
var time_played: int = 70
var badges: Array = []

var pokemon: Array = [
	"res://Resources/Pokemon/Base/007_mudkip_starter.tres",
	"res://Resources/Pokemon/Custom/010_zigzagoon.tres"
]

var team: Array = []

func _ready():
	var resource
	var instance
	for i in range(Trainer.pokemon.size()):
			resource = ResourceLoader.load(Trainer.pokemon[i])
			instance = resource.duplicate()
			instance = Utils.update_pokemon_stats(instance)
			team.append(instance)
