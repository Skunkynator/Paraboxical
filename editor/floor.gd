extends Tile
class_name Floor


enum floor_type {button, playerbutton, info, fasttravel, smile, show}


var type : int
var info : String


func _load(input : PoolStringArray):
	._load(input)
	match input[3]:
		"Button":
			type = floor_type.button
		"PlayerButton":
			type = floor_type.playerbutton
		"Info":
			type = floor_type.info
			info = input[4].replace("_", " ")
		"FastTravel":
			type = floor_type.fasttravel
		"Smile":
			type = floor_type.smile
		"Show":
			type = floor_type.show


func _save() -> String:
	var data := "Floor "
	data += ._save()
	match type:
		floor_type.button:
			data += " Button"
		floor_type.playerbutton:
			data += " PlayerButton"
		floor_type.info:
			data += " Info "
			data += info.replace(" ", "_")
		floor_type.fasttravel:
			data += " FastTravel"
		floor_type.smile:
			data += " Smile"
		floor_type.show:
			data += " Show"
	return data
