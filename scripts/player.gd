extends CharacterBody2D
class_name Player

signal on_death(player_id: int)

@export var speed: float = 100.0
@export var rotate_speed: float = 4.0
@export var thickness: float = 10.0

var trail_scene = preload("res://scenes/trail_body.tscn")
var player_data: PlayerData
var player_id: int
var prev_position: Vector2 = Vector2.ZERO
var prev_trail
var reverse_controls_count: int
var pass_through_walls_count: int

@onready var game_start_trail_timer: Timer = $GameStartTrailTimer
@onready var periodic_trail_timer: Timer = $PeriodicTrailTimer
@onready var pause_trail_timer: Timer = $PauseTrailTimer
@onready var collider = $CollisionShape2D

func _ready() -> void:
	add_to_group("gameplay")
	prev_position = position
	collider.shape.radius = 0.0

func _process(delta: float) -> void:
	var reverse_multiplier: float = 1.0
	if reverse_controls_count > 0:
		reverse_multiplier = -1.0

	if Input.is_key_pressed(player_data.left):
		rotate(-delta * rotate_speed * reverse_multiplier)
	if Input.is_key_pressed(player_data.right):
		rotate(delta * rotate_speed * reverse_multiplier)

func _physics_process(delta: float) -> void:
	prev_position = position
	var rot = get_transform().get_rotation()
	var dir = Vector2(cos(rot), sin(rot))
	
	var current_trail = _get_trail_positions()
	var collision_info = move_and_collide(delta * speed * dir)
	if collision_info:
		_handle_collision()
	
	if (prev_position != position && 
	prev_trail && 
	_can_spawn_trail()):
		var trail = trail_scene.instantiate()
		trail.set_color(player_data.color).set_collider(current_trail[0], current_trail[1], prev_trail[0], prev_trail[1])
		trail.add_to_group("trail")
		get_parent().add_child(trail)
	
	prev_trail = current_trail
	_check_border_collision()

func _check_border_collision() -> void:
	var b_pos := 315.0
	if position.x > b_pos || position.x < -b_pos || position.y > b_pos || position.y < -b_pos:
		if pass_through_walls_count == 0:
			_handle_collision()
		else:
			if position.x > b_pos:
				position = Vector2(-b_pos + 0.01, position.y)
			elif position.x < -b_pos:
				position = Vector2(b_pos - 0.01, position.y)
			if position.y > b_pos:
				position = Vector2(position.x, -b_pos + 0.01)
			elif position.y < -b_pos:
				position = Vector2(position.x, b_pos - 0.01)
			prev_trail = null
			

func _get_trail_positions():
	var rot = get_transform().get_rotation()
	var left = Vector2(cos(rot + PI / 2), sin(rot + PI / 2)) * thickness / 2
	var right = -left
	return [position + left, position + right]

func _handle_collision() -> void:
	on_death.emit(player_id)
	queue_free()

func _can_spawn_trail() -> bool:
	return !periodic_trail_timer.is_stopped() && game_start_trail_timer.is_stopped()

func _on_pause_trail_timer_timeout() -> void:
	periodic_trail_timer.start()

func _on_periodic_trail_timer_timeout() -> void:
	pause_trail_timer.start()
