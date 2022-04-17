extends Tile
class_name Block


var id : int
var width : int
var height : int
var colour : Color
var zoomfactor : float
var fillwithwalls : bool
var player : bool
var possessable : bool
var playerorder : int
var fliph : bool
var floatinspace : bool
var specialeffect : int
var children : Array


func _load(input : PoolStringArray):
	._load(input)
	id = int(input[3])
	width = int(input[4])
	height = int(input[5])
	colour = colour.from_hsv(float(input[6]), float(input[7]), float(input[8]))
	zoomfactor = float(input[9])
	fillwithwalls = bool(int(input[10]))
	player = bool(int(input[11]))
	possessable = bool(int(input[12]))
	playerorder = int(input[13])
	fliph = bool(int(input[14]))
	floatinspace = bool(int(input[15]))
	specialeffect = int(input[16])


func _save() -> String:
	var data := "Block "
	data += ._save()
	data += " " + String(id)
	data += " " + String(width)
	data += " " + String(height)
	data += " " + String(colour.h)
	data += " " + String(colour.s)
	data += " " + String(colour.v)
	data += " " + String(zoomfactor)
	data += " " + String(int(fillwithwalls))
	data += " " + String(int(player))
	data += " " + String(int(possessable))
	data += " " + String(playerorder)
	data += " " + String(int(fliph))
	data += " " + String(int(floatinspace))
	data += " " + String(specialeffect)
	var child_data := ""
	for child in children:
		if child_data:
			child_data += "\n"
		child_data += (child as Tile)._save()
	if child_data:
		child_data = child_data.indent("\t")
		data += "\n" + child_data
	return data
