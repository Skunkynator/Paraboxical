extends Tile
class_name Floor


enum floor_type {button, playerbutton, info, fasttravel, smile, show, demoend, gallery, break_floor}


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
		"DemoEnd":
			type = floor_type.demoend
		"Gallery":
			type = floor_type.gallery
		"Break":
			type = floor_type.break_floor


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
		floor_type.demoend:
			data += " DemoEnd"
		floor_type.gallery:
			data += " Gallery"
		floor_type.break_floor:
			data += " Break"
	return data
