extends Node2D

enum transitionType {NEW, MENU, DEX, PARTY, BAG, CARD, SAVE, OPTION}

var transition_type = transitionType.NEW

@onready var current_scene = $Current
var next_scene = null
var player_location = Vector2(0, 0)
var player_direction = Vector2(0, 0)

func transition_to_menu(menuName):
	$Transition/AnimationPlayer.play("FadeIn")
	match menuName:
		"menu": transition_type = transitionType.MENU
		"dex": transition_type = transitionType.DEX
		"party": transition_type = transitionType.PARTY
		"bag": transition_type = transitionType.BAG
		"card": transition_type = transitionType.CARD
		"save": transition_type = transitionType.SAVE
		"option": transition_type = transitionType.OPTION
	
func transition_to(new_scene: String, spawn_point, spawn_direction):
	next_scene = new_scene
	player_location = spawn_point
	player_direction = spawn_direction
	transition_type = transitionType.NEW
	$Transition/AnimationPlayer.play("FadeIn")

func finished_fading():
	match transition_type:
		transitionType.NEW:
			current_scene.get_child(0).queue_free()
			current_scene.add_child(load(next_scene).instantiate())
			var player = Utils.get_player()
			player.set_spawn(player_location, player_direction)
		transitionType.MENU:
			$Menu.load_menu_screen()
		transitionType.PARTY:
			$Menu.load_screen($Menu.screenLoaded.PARTY, $Menu.PartyScreen)
		transitionType.BAG:
			$Menu.load_screen($Menu.screenLoaded.BAG, $Menu.BagScreen)
	$Transition/AnimationPlayer.play("FadeOut")
