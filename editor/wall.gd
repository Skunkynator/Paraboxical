extends Tile
class_name Wall


var player : bool
var possessable : bool
var playerorder : int


func _load(input : PoolStringArray):
	._load(input)
	player = bool(int(input[3]))
	possessable = bool(int(input[4]))
	playerorder = int(input[5])


func _save() -> String:
	var data := "Wall "
	data += ._save()
	data += " " + String(int(player))
	data += " " + String(int(possessable))
	data += " " + String(playerorder)
	return data
