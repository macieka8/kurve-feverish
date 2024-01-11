extends Node2D
class_name BuffDisplayer

const first_scale := 0.16
const scale_increment := 0.06

var buff_progress_scene := preload("res://scenes/buff_progress.tscn")

var buffs: Array[BuffProgress]

func add_buff(buff: Buff) -> void:
	var buff_progress = buff_progress_scene.instantiate() as BuffProgress
	add_child(buff_progress)
	buff_progress.buff = buff
	buff_progress.scale = Vector2.ONE * (first_scale + scale_increment * buffs.size())
	buffs.push_back(buff_progress)

func _process(delta: float) -> void:
	global_rotation_degrees = 0.0
	for i in range(buffs.size() - 1, -1, -1):
		if buffs[i].buff == null:
			print("NUll")
			buffs[i].queue_free()
			buffs.remove_at(i)
			continue

		buffs[i].scale = Vector2.ONE * (first_scale + scale_increment * i)
		var material := buffs[i].material as ShaderMaterial
		var timer := buffs[i].buff.get_node("Timer") as Timer
		material.set_shader_parameter("progress", timer.time_left / timer.wait_time)
