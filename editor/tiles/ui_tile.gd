extends Control
class_name UITile


var current_tile : Tile
var x : int
var y : int
var colour := Color.purple
var button_floor : Control
var player_button_floor : Control
var fast_travel_floor : Control
var info_floor : Control
var gallery_floor : Control
var grid : GridContainer
var copy_indicator : Control
var wall : ColorRect
var floor_rect : ColorRect
var epsilon : Control
var infinity : Control
var tile_scene := load("res://editor/tiles/ui_tile.tscn") as PackedScene


func _ready() -> void:
	button_floor = $Floor/Button
	player_button_floor = $Floor/PlayerButton
	fast_travel_floor = $Floor/FastTravel
	info_floor = $Floor/Info
	gallery_floor = $Floor/Gallery
	grid = $GridContainer
	copy_indicator = $CopyIndicator
	wall = $Wall
	epsilon = $Epsilon
	infinity = $Infinity
	floor_rect = $Floor


func refresh(layer : int = 0) -> void:
	floor_rect.color = colour * 0.8
	floor_rect.color.a = 1
	wall.color = colour
	disable_children()
	if not current_tile:
		return
	if current_tile is Wall:
		wall.visible = true
	if current_tile is Floor:
		display_floor()
	if current_tile is Block:
		colour = current_tile.colour
		if layer < 3:
			draw_children(layer, current_tile)
	if current_tile is Ref:
		copy_indicator.visible = true
		infinity.visible = current_tile.infexit
		colour = current_tile.ref_to.colour
		if layer < 3:
			draw_children(layer, current_tile.ref_to)


func draw_children(layer : int, block : Block) -> void:
	grid.visible = true
	Extended.free_children(grid)
	grid.rect_scale.x = 1.0 / block.width
	grid.rect_scale.y = 1.0 / block.height
	grid.rect_size.x = 16 * block.width
	grid.rect_size.y = 16 * block.height
	grid.columns = block.width
	var block_grid := []
	for i_y in block.height:
		for i_x in block.width:
			var curr := tile_scene.instance()
			block_grid.append(curr)
			grid.add_child(curr)
	for child in block.children:
		var child_tile : Tile = child as Tile
		if "floatinspace" in child_tile:
			if child_tile.floatinspace:
				continue
		var index := child_tile.x + (block.height - 1 - child_tile.y) * block.width
		(block_grid[index] as UITile).current_tile = child_tile
	for child in block_grid:
		(child as UITile).colour = block.colour
		(child as UITile).refresh(layer + 1)


func display_floor():
	button_floor.visible = \
			(current_tile as Floor).type == Floor.floor_type.button
	player_button_floor.visible = \
			(current_tile as Floor).type == Floor.floor_type.playerbutton
	fast_travel_floor.visible = \
			(current_tile as Floor).type == Floor.floor_type.fasttravel
	info_floor.visible = \
			(current_tile as Floor).type == Floor.floor_type.info or\
			(current_tile as Floor).type == Floor.floor_type.show or\
			(current_tile as Floor).type == Floor.floor_type.smile or\
			(current_tile as Floor).type == Floor.floor_type.break_floor or\
			(current_tile as Floor).type == Floor.floor_type.demoend
	gallery_floor.visible = \
			(current_tile as Floor).type == Floor.floor_type.gallery


func disable_children() -> void:
	button_floor.visible = false
	player_button_floor.visible = false
	fast_travel_floor.visible = false
	info_floor.visible = false
	gallery_floor.visible = false
	grid.visible = false
	copy_indicator.visible = false
	wall.visible = false
	epsilon.visible = false
	infinity.visible = false
