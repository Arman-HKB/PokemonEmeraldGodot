extends Node

var rng = RandomNumberGenerator.new()
@onready var next_encounter = rng.randi_range(10, 25)

func _ready():
	print(next_encounter)

func check_wild_encounter():
	next_encounter -= 1
	if next_encounter <= 0:
		print("A wild pokemon appeared!")
		next_encounter = rng.randi_range(10, 25)
