@tool
extends EditorScript

var buff_dir_string := "res://scenes/Buff/"
var pickable_dir_string := "res://scenes/Buff/pickable_generated/"
var icons_dir_string := "res://images/"
var pickable_base_dir_string := "res://scenes/Buff/pickable/base_pickable.tscn"

var pickable_name := "all_pickable_"
var material_path := "res://materials/buff_icon_all.tres"
var buff_source := BuffSource.BuffSource.ALL_PLAYERS

func _run() -> void:
	print("Generating pickable buffs...")
	var buff_dir := DirAccess.open(buff_dir_string)
	var base_pickable_scene := load(pickable_base_dir_string) as PackedScene
	for file_name in buff_dir.get_files():
		var file_dir_name := buff_dir_string + file_name
		
		# Create buff packed scene
		var instance = base_pickable_scene.instantiate() as PowerUp
		instance.buff = load(file_dir_name) as PackedScene
		instance.buff_source = buff_source
		instance.name = pickable_name + file_name
		(instance.get_node("Sprite2D") as Sprite2D).texture = load(icons_dir_string + file_name.trim_suffix(".tscn") + ".png")
		(instance.get_node("Sprite2D") as Sprite2D).material = load(material_path)
		var packed_buff = PackedScene.new()
		packed_buff.pack(instance)
		
		# Save buff
		var save_file_name := pickable_dir_string + pickable_name + file_name
		print(save_file_name)
		var error := ResourceSaver.save(packed_buff, save_file_name)
		if error != 0:
			print("Error saving resource:", error)
