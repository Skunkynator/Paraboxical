extends Control
class_name EditorUi


var level_tree : Tree
var view : UITile
var presets : BoxContainer


func _ready() -> void:
	level_tree = get_node_or_null("MainUi/LevelTree") as Tree
	view = $MainUi/HSplitContainer/DrawArea/Control as UITile
	level_tree.connect("cell_selected",self,"on_tree_item_selected")
	setup_tree()
	setup_view()


func _on_tree_entered() -> void:
	if level_tree:
		setup_tree()
	if view:
		setup_view()
	$Pause.visible = false


func _on_tree_exited() -> void:
	pass # Replace with function body.


func on_tree_item_selected() -> void:
	var selected := level_tree.get_selected().get_meta("tile") as Tile
	view.current_tile = selected
	view.refresh()


func setup_tree() -> void:
	level_tree.clear()
	level_tree.hide_root = true
	var root := level_tree.create_item()
	add_tree_blocks(EditorController.current_level.root, root)


func add_tree_blocks(blocks : Array, parent : TreeItem):
	for block in blocks:
		if block is Block:
			if block.fillwithwalls:
				continue
			var item := level_tree.create_item(parent)
			item.set_text(0,"Block #" + String(block.id))
			item.set_meta("tile", block)
			add_tree_blocks((block as Block).children, item)
		elif block is Ref:
			var ref := block as Ref
			if ref.ref_to.fillwithwalls:
				continue
			var item := level_tree.create_item(parent)
			var text := "Ref #" + String(ref.id)
			if ref.infexit:
				text = "Iexit #" + String(ref.id)
				text += " num: " + String(ref.infexitnum)
			if ref.infenter:
				text += " Ienter #" + String(ref.infenterid)
				text += " num: " + String(ref.infenternum)
			item.set_text(0,text)
			item.set_meta("tile", block)


func setup_presets() -> void:
	pass


func setup_view() -> void:
	view.current_tile = EditorController.current_level.root[0]
	view.refresh()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE and not event.echo and event.pressed:
			$Pause.visible = !$Pause.visible


func quit():
	if view:
		Extended.free_children(view.grid)
	MainController.load_menu()


func save():
	if not EditorController.current_level:
		return
	var leveldata : String = EditorController.current_level.save()
	var level_file := File.new()
	level_file.open(EditorController.current_file,File.WRITE)
	level_file.store_string(leveldata)
	level_file.close()


func save_and_quit():
	save()
	quit()
