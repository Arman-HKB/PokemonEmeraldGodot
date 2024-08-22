extends Area2D

@export var dialog_id: int = 0
@export var is_npc: bool = false

func _input(event):
	if event.is_action_pressed("z") and has_overlapping_bodies() and Utils.get_scene_manager().get_node("Menu").screen_loaded == 0:
		var player = Utils.get_player()
		var self_pos = position
		if is_npc:
			self_pos = get_parent().position
		# left / down / right / up
		if player.position + Vector2(16,0) == self_pos and player.facing_direction == 3 or player.position + Vector2(0,16) == self_pos  and player.facing_direction == 1 or player.position - Vector2(16,0) == self_pos  and player.facing_direction == 2 or player.position - Vector2(0,16) == self_pos and player.facing_direction == 0 :
			start_dialog()

func start_dialog():
	Utils.get_scene_manager().get_node("DialogBox").start(dialog_id)
