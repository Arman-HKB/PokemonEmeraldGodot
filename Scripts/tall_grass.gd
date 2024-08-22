extends Node2D

@onready var animation_player = $AnimationPlayer
const grass_overlay_texture = preload("res://Assets/Tilesets/stepped_tall_grass.png")
const GrassStepEffect = preload("res://Scenes/grass_step_effect.tscn")

var grass_overlay: TextureRect = null
var player_inside: bool = false

func _ready():
	Utils.get_player().connect("player_moving_signal", player_out)
	Utils.get_player().connect("player_stopped_signal", player_in)

func player_out():
	player_inside = false
	if is_instance_valid(grass_overlay):
		grass_overlay.queue_free()

func player_in():
	if player_inside:
		var grass_step_effect = GrassStepEffect.instantiate()
		grass_step_effect.position = position
		grass_step_effect.z_index = 3
		Utils.get_current_scene().add_child(grass_step_effect)
		
		grass_overlay = TextureRect.new()
		grass_overlay.texture = grass_overlay_texture
		grass_overlay.global_position = position
		grass_overlay.z_index = 2
		Utils.get_current_scene().add_child(grass_overlay)

func _on_area_2d_body_entered(_body):
	player_inside = true
	Global.check_wild_encounter()
