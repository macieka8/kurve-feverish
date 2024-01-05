extends CharacterBody2D
class_name Player

var player_data: PlayerData
@export var speed: float = 100.0
@export var rotate_speed: float = 4.0
@export var thickness: float = 10.0
@export var trail_color: Color

var trail_scene = preload("res://scenes/trail_body.tscn")

@onready var game_start_trail_timer: Timer = $GameStartTrailTimer
@onready var periodic_trail_timer: Timer = $PeriodicTrailTimer
@onready var pause_trail_timer: Timer = $PauseTrailTimer
@onready var collider = $CollisionShape2D

var prev_position: Vector2 = Vector2.ZERO
var prev_trail

func _ready() -> void:
	prev_position = position
	collider.shape.radius = 0.0

func _process(delta: float) -> void:
	if Input.is_key_pressed(player_data.left):
		rotate(-delta * rotate_speed)
	if Input.is_key_pressed(player_data.right):
		rotate(delta * rotate_speed)

func _physics_process(delta: float) -> void:
	prev_position = position
	var rot = get_transform().get_rotation()
	var dir = Vector2(cos(rot), sin(rot))
	
	var collision_info = move_and_collide(delta * speed * dir)
	if collision_info:
		_handle_collision()
	
	var current_trail = get_trail_positions()
	if (prev_position != position && 
	prev_trail && 
	_can_spawn_trail()):
		var trail = trail_scene.instantiate()
		trail.set_color(trail_color).set_collider(current_trail[0], current_trail[1], prev_trail[0], prev_trail[1])
		get_parent().add_child(trail)
		
	_check_border_collision()
	prev_trail = current_trail

func _check_border_collision() -> void:
	var b_pos := 315.0
	if position.x > b_pos || position.x < -b_pos || position.y > b_pos || position.y < -b_pos:
		_handle_collision()

func get_trail_positions():
	var rot = get_transform().get_rotation()
	var left = Vector2(cos(rot + PI / 2), sin(rot + PI / 2)) * thickness / 2
	var right = -left
	return [position + left, position + right]

func _handle_collision() -> void:
	self.queue_free()

func _can_spawn_trail() -> bool:
	return !periodic_trail_timer.is_stopped() && game_start_trail_timer.is_stopped()

func _on_pause_trail_timer_timeout() -> void:
	periodic_trail_timer.start()

func _on_periodic_trail_timer_timeout() -> void:
	pause_trail_timer.start()
