extends Node2D

enum scene {GBA, COPY, GAMEFREAK, BIKE, LEGENDARY, START}

@onready var timer = $Timer
@onready var first_scene = $Copyright
@onready var third_scene = $BikeScene
@onready var fourth_scene = $LegendaryScene
@onready var fifth_scene = $PressStart

var intro_state = scene.COPY

func _ready():
	first_scene.visible = true
	timer.wait_time = 3.0
	timer.start()
	next_scene()

func _input(event):
	if event.is_action_pressed("menu"):
		next_scene()

func _on_timer_timeout():
	next_scene()

func next_scene():
	intro_state += 1
	if intro_state > 5:
		get_tree().change_scene_to_file("res://Scenes/scene_manager.tscn")
		#Utils.get_scene_manager().transition_to("res://Scenes/map.tscn", Vector2(144, 96), Vector2(0, 1))
	match intro_state:
		2: next_scene()
		3:
			next_scene()
			third_scene.visible = true
			third_scene.get_node("AnimationPlayer").play("Cycling")
		4: 
			next_scene()
			third_scene.get_node("AnimationPlayer").stop()
			fourth_scene.visible = true
			fourth_scene.get_node("AnimationPlayer").play("Kyogre")
		5: 
			fourth_scene.get_node("AnimationPlayer").stop()
			fifth_scene.visible = true
