extends Control
class_name EditorUi


var level_tree : Tree
var view : Control
var presets : BoxContainer


func _ready() -> void:
	level_tree = get_node_or_null("MainUi/LevelTree") as Tree
	setup_tree()


func _on_tree_entered() -> void:
	if level_tree:
		setup_tree()


func _on_tree_exited() -> void:
	pass # Replace with function body.


func setup_tree() -> void:
	level_tree.clear()
	level_tree.hide_root = true
	var root := level_tree.create_item()
	add_tree_blocks(EditorController.current_level.root, root)


func add_tree_blocks(blocks : Array, parent : TreeItem):
	for block in blocks:
		if block is Block:
			var item := level_tree.create_item(parent)
			item.set_text(0,"Block #" + String(block.id))
			add_tree_blocks((block as Block).children, item)
		elif block is Ref:
			var ref := block as Ref
			var item := level_tree.create_item(parent)
			var text := "Ref #" + String(ref.id)
			if ref.infexit:
				text = "Iexit #" + String(ref.id)
				text += " num: " + String(ref.infexitnum)
			if ref.infenter:
				text += " Ienter #" + String(ref.infenterid)
				text += " num: " + String(ref.infenternum)
			item.set_text(0,text)


func setup_presets() -> void:
	pass


func setup_view() -> void:
	pass
