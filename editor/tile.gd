extends Reference
class_name Tile

var x : int
var y : int
var parent setget set_parent


func set_parent(new_parent) -> void:
	parent = new_parent
	parent.children.append(self)


func _load(input : PoolStringArray) -> void:
	x = int(input[1])
	y = int(input[2])


func _save() -> String:
	return String(x) + " " + String(y)
