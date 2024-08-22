extends Node2D

enum Options {FIRST_SLOT, SECOND_SLOT, THIRD_SLOT, FOURTH_SLOT, FIFTH_SLOT, SIXTH_SLOT, CANCEL}
var selected_option: int = Options.FIRST_SLOT

@onready var options: Dictionary = {
	Options.FIRST_SLOT: $FirstSlot/Background,
	Options.SECOND_SLOT: null,
	Options.THIRD_SLOT: null,
	Options.FOURTH_SLOT: null,
	Options.FIFTH_SLOT: null,
	Options.SIXTH_SLOT: null,
	Options.CANCEL: $Cancel
}
var pokemon = []

func unset_active_option():
	options[selected_option].frame = 0
func set_active_option():
	options[selected_option].frame = 1

func _ready():
	var resource
	var instance
	var last_instance
	for i in range(Trainer.team.size()):
		"""resource = ResourceLoader.load(Trainer.team[i])
		instance = resource.duplicate()
		pokemon.append(instance)"""
		pokemon.append(Trainer.team[i])
	$FirstSlot/MonsterMin.texture = pokemon[0].icons
	$FirstSlot/Name.text = pokemon[0].get_pokemon_name()
	$FirstSlot/Gender.frame = pokemon[0].gender
	$FirstSlot/Level.text = str(pokemon[0].level)
	$FirstSlot/HP.text = str(pokemon[0].hp)
	$FirstSlot/MaxHP.text = str(pokemon[0].max_hp)
	for i in range(1, Trainer.team.size()):
		instance = preload("res://Scenes/other_slot.tscn")
		instance = instance.instantiate()
		$OtherSlots.add_child(instance)
		options[get_enum_value_by_index(i)] = instance.get_node("Background")
		instance.position.y = instance.position.y + 24*i
		instance.get_node("MonsterMin").texture =  pokemon[i].icons
		instance.get_node("Name").text = pokemon[i].get_pokemon_name()
		instance.get_node("Gender").frame =  pokemon[i].gender
		instance.get_node("Level").text = str(pokemon[i].level)
		instance.get_node("HP").text = str(pokemon[i].hp)
		instance.get_node("MaxHP").text = str(pokemon[i].hp)
	set_active_option()

func get_enum_value_by_index(i):
	match i:
		0: return Options.FIRST_SLOT
		1: return Options.SECOND_SLOT
		2: return Options.THIRD_SLOT
		3: return Options.FOURTH_SLOT
		4: return Options.FIFTH_SLOT
		5: return Options.SIXTH_SLOT
		6: return Options.CANCEL

func _input(event):
	if event.is_action_pressed("ui_down"):
		unset_active_option()
		selected_option = (selected_option + 1) % 7
		while options[selected_option] == null:
			selected_option = (selected_option + 1) % 7
		set_active_option()
	elif event.is_action_pressed("ui_up"):
		unset_active_option()
		if selected_option == 0:
			selected_option = Options.CANCEL
		else: 
			selected_option -= 1
			while options[selected_option] == null:
				selected_option -= 1
		set_active_option()
	elif event.is_action_pressed("ui_left"):
		unset_active_option()
		selected_option = 0
		set_active_option()
	elif event.is_action_pressed("ui_right") and selected_option == Options.FIRST_SLOT:
		unset_active_option()
		selected_option = 1
		set_active_option()
	elif event.is_action_pressed("z"):
		match selected_option:
			Options.CANCEL:
				Utils.get_scene_manager().transition_to_menu("menu")
