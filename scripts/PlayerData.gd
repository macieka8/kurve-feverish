class_name PlayerData

var name: String
var left: Key
var right: Key

var left_name: String
var right_name: String

var color: Color

static func from(name: String, left: Key, right: Key, left_name: String, right_name: String, color: Color) -> PlayerData:
	var data: PlayerData = PlayerData.new()
	data.name = name
	data.left = left
	data.right = right
	data.left_name = left_name
	data.right_name = right_name
	data.color = color
	return data
