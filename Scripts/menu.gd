extends CanvasLayer

const PartyScreen = preload("res://Scenes/pokemon_party_screen.tscn")
const BagScreen = preload("res://Scenes/bag_screen.tscn")

@onready var cursor = $Control/NinePatchRect/Cursor
@onready var menu = $Control

enum screenLoaded {NOTHING, MENU, DEX, PARTY, BAG, CARD, SAVE, OPTION}
var screen_loaded = screenLoaded.NOTHING

var selected_option: int = 0

func _ready():
	$Control/NinePatchRect/VBoxContainer/PlayerNameLabel.text = Trainer.player_name
	menu.visible = false
	cursor.position.y = 20 + (selected_option % 7) * 15

func load_menu_screen():
	menu.visible = true
	screen_loaded = screenLoaded.MENU
	var child_count = get_child_count()
	remove_child(get_child(child_count - 1))

func load_screen(toLoad, scene):
	menu.visible = false
	screen_loaded = toLoad
	var new_screen = scene.instantiate()
	add_child(new_screen)

func close_menu():
	var player = Utils.get_player()
	player.set_physics_process(true)
	menu.visible = false
	screen_loaded = screenLoaded.NOTHING

func _unhandled_input(event):
	match screen_loaded:
		screenLoaded.NOTHING:
			if event.is_action_pressed("menu") and !Utils.get_scene_manager().get_node("DialogBox").active:
				var player = Utils.get_player()
				if !player.is_moving:
					player.set_physics_process(false)
					menu.visible = true
					screen_loaded = screenLoaded.MENU
		screenLoaded.MENU:
			if event.is_action_pressed("menu") or event.is_action_pressed("x"):
				close_menu()
			elif event.is_action_pressed("ui_up"):
				if selected_option == 0:
					selected_option = 6
				else:
					selected_option -= 1
				cursor.position.y = 20 + (selected_option % 7) * 15
			elif event.is_action_pressed("ui_down"):
				if selected_option >= 7: selected_option = 0
				selected_option += 1
				cursor.position.y = 20 + (selected_option % 7) * 15
			elif event.is_action_pressed("z"):
				match selected_option:
					0: # Dex
						print("dex")
					1: # Party
						Utils.get_scene_manager().transition_to_menu("party")
					2: # Bag
						Utils.get_scene_manager().transition_to_menu("bag")
					3: # Trainer card
						print("card")
					4: # Save
						print("save")
						#Global.save_data()
					5: # Option
						print("option")
					6: # Exit
						close_menu()
		screenLoaded.PARTY:
			if event.is_action_pressed("x"):
				Utils.get_scene_manager().transition_to_menu("menu")
		screenLoaded.BAG:
			if event.is_action_pressed("x"):
				Utils.get_scene_manager().transition_to_menu("menu")
