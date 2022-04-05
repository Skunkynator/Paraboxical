extends Tile
class_name Ref


var id : int
var exitblock : bool
var infexit : bool
var infexitnum : int
var infenter : bool
var infenternum : int
var infenterid : int
var player : bool
var possessable : bool
var playerorder : int
var fliph : bool
var floatinspace : bool
var specialeffect : int
var ref_to : Block
var infenter_to : Block


func _load(input : PoolStringArray):
	._load(input)
	id = int(input[3])
	exitblock = bool(int(input[4]))
	infexit = bool(int(input[5]))
	infexitnum = int(input[6])
	infenter = bool(int(input[7]))
	infenternum = int(input[8])
	infenterid = int(input[9])
	player = bool(int(input[10]))
	possessable = bool(int(input[11]))
	playerorder = int(input[12])
	fliph = bool(int(input[13]))
	floatinspace = bool(int(input[14]))
	specialeffect = int(input[15])


func _save() -> String:
	var data := "Ref "
	data += ._save()
	data += " " + String(id)
	data += " " + String(int(exitblock))
	data += " " + String(int(infexit))
	data += " " + String(infexitnum)
	data += " " + String(int(infenter))
	data += " " + String(infenternum)
	data += " " + String(infenterid)
	data += " " + String(int(player))
	data += " " + String(int(possessable))
	data += " " + String(playerorder)
	data += " " + String(int(fliph))
	data += " " + String(int(floatinspace))
	data += " " + String(specialeffect)
	return data
