extends Node


var config : Config
var menu_scene := preload("res://menu/file_select.tscn") as PackedScene
var editor_scene := preload("res://editor/editor.tscn") as PackedScene
var editor : EditorUi
var menu : Node
var current_path : String


func load_menu():
	Extended.remove_children(self)
	if not menu:
		menu = menu_scene.instance()
	add_child(menu)


func load_editor(file : String):
	file = current_path.plus_file(file)
	var level_file := File.new()
	level_file.open(file,File.READ)
	var level_string : String = level_file.get_as_text()
	level_file.close()
	var level := Level.new()
	level.interpret(level_string)
	EditorController.current_level = level
	Extended.remove_children(self)
	if not editor:
		editor = editor_scene.instance()
	add_child(editor)
