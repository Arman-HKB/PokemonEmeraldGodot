extends CharacterBody2D

enum state {IDLE, TURNING, WALKING, RUNING}
enum facing {UP, DOWN, LEFT, RIGHT}

signal player_moving_signal
signal player_stopped_signal
signal player_entering_door_signal
signal player_entered_door_signal

const landingDustEffect = preload("res://Scenes/landing_dust_effect.tscn")

@export var speed = 4.0
@export var run_speed = 8.0
@export var jump_speed = 4.0
const TILE_SIZE = 16

@onready var inital_position = position
@onready var shadow = $Shadow
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var raycast = $RayCast2D
@onready var ledge_raycast = $LedgeRayCast2D
@onready var door_raycast = $DoorRayCast2D
var jumping: bool = false

var player_state = state.IDLE
var facing_direction = facing.DOWN
var direction = Vector2(0,1)
var is_moving = false
var stop_input: bool = false
var percent_moved_to_next_tile: float = 0.0

func _ready():
	$Sprite2D.visible = true
	shadow.visible = false
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Turn/blend_position", direction)
	animation_tree.set("parameters/Walk/blend_position", direction)
	animation_tree.set("parameters/Run/blend_position", direction)

func set_spawn(location, spawn_direction):
	animation_tree.set("parameters/Idle/blend_position", spawn_direction)
	animation_tree.set("parameters/Turn/blend_position", spawn_direction)
	animation_tree.set("parameters/Walk/blend_position", spawn_direction)
	animation_tree.set("parameters/Run/blend_position", spawn_direction)
	position = location

func _physics_process(delta):
	if player_state == state.TURNING or stop_input:
		return
	elif is_moving == false:
		process_player_input()
	elif direction != Vector2.ZERO:
		if Input.is_action_pressed("x"):
			animation_state.travel("Run")
			speed = run_speed
		else: 
			speed = 4.0
			animation_state.travel("Walk")
		move(delta)
	else: 
		animation_state.travel("Idle")
		is_moving = false

func process_player_input():
	if direction.y == 0:
		direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if direction.x == 0:
		direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Turn/blend_position", direction)
		animation_tree.set("parameters/Walk/blend_position", direction)
		animation_tree.set("parameters/Run/blend_position", direction)
		if turn():
			player_state = state.TURNING
			animation_state.travel("Turn")
		else:
			if Input.is_action_pressed("x"):
				animation_state.travel("Run")
				speed = run_speed
			else: 
				speed = 4.0
				animation_state.travel("Walk")
			inital_position = position
			is_moving = true
	else: animation_state.travel("Idle")

func turn():
	var new_direction
	if direction.x < 0: new_direction = facing.LEFT
	elif direction.x > 0: new_direction = facing.RIGHT
	elif direction.y < 0: new_direction = facing.UP
	elif direction.y > 0: new_direction = facing.DOWN
	
	if facing_direction != new_direction:
		facing_direction = new_direction
		return true
	facing_direction = new_direction
	return false

func finished_turning():
	player_state = state.IDLE

func entered_door():
	emit_signal("player_entered_door_signal")

func move(delta):
	var desired_step: Vector2 = direction * TILE_SIZE / 2
	raycast.target_position = desired_step
	raycast.force_raycast_update()
	
	ledge_raycast.target_position = desired_step
	ledge_raycast.force_raycast_update()
	
	door_raycast.target_position = desired_step
	door_raycast.force_raycast_update()
	
	if door_raycast.is_colliding():
		if percent_moved_to_next_tile == 0.0:
			emit_signal("player_entering_door_signal")
		percent_moved_to_next_tile += speed * delta
		if percent_moved_to_next_tile >= 1.0:
			position = inital_position + (direction * TILE_SIZE)
			percent_moved_to_next_tile = 0.0
			is_moving = false
			stop_input = true
			animation_player.play("Disappear")
			emit_signal("player_entering_door_signal")
			#$Camera2D.force_update_scroll()
		else: 
			position = inital_position + (direction * TILE_SIZE * percent_moved_to_next_tile)
	elif (ledge_raycast.is_colliding() && direction == Vector2(0, 1)) or jumping:
		percent_moved_to_next_tile += jump_speed * delta
		if percent_moved_to_next_tile >= 2.0:
			# Move of 2 tiles
			position = inital_position + (direction * TILE_SIZE * 2)
			percent_moved_to_next_tile = 0.0
			is_moving = false
			jumping = false
			shadow.visible = false
			var dust_effect = landingDustEffect.instantiate()
			dust_effect.position = position
			Utils.get_current_scene().add_child(dust_effect)
			$Sprite2D.offset.y = -4
		else:
			jumping = true
			shadow.visible = true
			var input = direction.y * TILE_SIZE * percent_moved_to_next_tile
			# Jumping animation
			position.y = inital_position.y + (input + 0.05 / pow(input, 2))
			$Sprite2D.offset.y = -14
	elif !raycast.is_colliding():
		if percent_moved_to_next_tile == 0:
			emit_signal("player_moving_signal")
		percent_moved_to_next_tile += speed * delta
		if percent_moved_to_next_tile >= 1.0:
			position = inital_position + (TILE_SIZE * direction)
			percent_moved_to_next_tile = 0.0
			is_moving = false
			emit_signal("player_stopped_signal")
		else:
			position = inital_position + (direction * TILE_SIZE * percent_moved_to_next_tile)
	else:
		percent_moved_to_next_tile = 0.0
		is_moving = false
