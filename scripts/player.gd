extends CharacterBody2D
class_name Player

var player_data: PlayerData
@export var speed: float = 100.0
@export var rotate_speed: float = 4.0
@export var thickness: float = 10.0
@export var trail_color: Color

var trail_scene = preload("res://scenes/trail_body.tscn")

@onready var collider = $CollisionShape2D

var prev_position: Vector2 = Vector2.ZERO
var prev_trail

func _ready():
	prev_position = position
	collider.shape.radius = 0.0

func _process(delta):
	if Input.is_key_pressed(player_data.left.keycode):
		rotate(-delta * rotate_speed)
	if Input.is_key_pressed(player_data.right.keycode):
		rotate(delta * rotate_speed)

func _physics_process(delta):
	prev_position = position
	var rot = get_transform().get_rotation()
	var dir = Vector2(cos(rot), sin(rot))
	
	var collision_info = move_and_collide(delta * speed * dir)
	if collision_info:
		print("player hit trail")
		self.queue_free()
	
	var current_trail = get_trail_positions()
	if (prev_position != position && prev_trail):
		var trail = trail_scene.instantiate()
		trail.set_color(trail_color).set_collider(current_trail[0], current_trail[1], prev_trail[0], prev_trail[1])
		get_parent().add_child(trail)
	prev_trail = current_trail

func get_trail_positions():
	var rot = get_transform().get_rotation()
	var left = Vector2(cos(rot + PI / 2), sin(rot + PI / 2)) * thickness / 2
	var right = -left
	return [position + left, position + right]
