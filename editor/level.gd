extends Reference
class_name Level


enum style {tui, grid, oldstyle, normal}


var version : int = 4
var attempt_order : PoolStringArray
var shed : bool = false
var inner_push : bool = false
var draw_style : int = style.normal
var music : int = -1
var pallete : int = -1
var root : Array
var valid : bool = false


func interpret(data : String):
	var is_header := true
	var prev_depth : int = -1
	var prev_tile : Tile
	var blocks : Dictionary = {}
	var refs : Array = []
	for line in data.split("\n", false):
		var args := (line as String).split(" ",false)
		if is_header:
			match args[0]:
				"version":
					version = int(args[1])
					if version != 4:
						return
				"attempt_order":
					attempt_order = args[1].split(",")
				"shed":
					shed = bool(int(args[1]))
				"inner_push":
					inner_push = bool(int(args[1]))
				"draw_style":
					match args[1]:
						"tui":
							draw_style = style.tui
						"grid":
							draw_style = style.grid
						"oldstyle":
							draw_style = style.oldstyle
						_:
							draw_style = style.normal
				"custom_level_music":
					music = int(args[1])
				"custom_level_palette":
					pallete = int(args[1])
				"#":
					is_header = false
		else:
			var current_depth : int = 0
			var current_tile : Tile
			while args[0][current_depth] == '\t':
				current_depth += 1
			if current_depth - 1 > prev_depth:
				return # cant indent two further
			args[0] = args[0].replace("\t","")
			match args[0]:
				"Block":
					current_tile = Block.new()
				"Ref":
					current_tile = Ref.new()
					refs.append(current_tile)
				"Wall":
					current_tile = Wall.new()
				"Floor":
					current_tile = Floor.new()
			current_tile._load(args)
			if current_tile is Block:
				blocks[current_tile.id] = current_tile
			
			for i in prev_depth - current_depth:
				prev_tile = prev_tile.parent
			
			if current_depth == 0:
				root.append(current_tile)
			elif current_depth > prev_depth:
				current_tile.parent = prev_tile
			else:
				current_tile.parent = prev_tile.parent
			prev_tile = current_tile
			prev_depth = current_depth
	for tile in refs:
		var ref_tile := tile as Ref
		ref_tile.ref_to = blocks[ref_tile.id]
		if ref_tile.infenter:
			ref_tile.infenter_to = blocks[ref_tile.infenterid]
	valid = true


func save() -> String:
	var save_data : String = ""
	save_data += "version " + String(version)
	if attempt_order:
		save_data += "\nattempt_order " + attempt_order.join(",")
	if shed:
		save_data += "\nshed 1"
	if inner_push:
		save_data += "\ninner_push 1"
	match draw_style:
		style.tui:
			save_data += "\ndraw_style tui"
		style.grid:
			save_data += "\ndraw_style grid"
		style.oldstyle:
			save_data += "\ndraw_style oldstyle"
	if music != -1:
		save_data += "\ncustom_level_music " + String(music)
	if pallete != -1:
		save_data += "\ncustom_level_palette " + String(pallete)
	save_data += "\n#"
	for element in root:
		save_data += "\n" + (element as Tile)._save()
	return save_data
