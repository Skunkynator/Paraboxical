extends Control


var folders_cont : Control
var files_cont : Control
var folder_scene := preload("res://menu/folder.tscn") as PackedScene
var file_scene := preload("res://menu/file.tscn") as PackedScene


func _ready() -> void:
	folders_cont = $ScrollContainer/Items/Folders as Control
	files_cont = $ScrollContainer/Items/Levels as Control
	update_folder()


func update_folder():
	Extended.free_children(folders_cont)
	Extended.free_children(files_cont)
	var dir := Directory.new()
	dir.open(MainController.current_path)
	dir.list_dir_begin()
	var current := dir.get_next()
	var directories : Array
	var files : Array
	while current != "":
		if current == ".":
			pass
		elif dir.current_is_dir():
			directories.append(current)
		else:
			files.append(current)
		current = dir.get_next()
	files.sort()
	directories.sort()
	for name in files:
		var file := file_scene.instance() as FileUi
		file.file_name = name
		files_cont.add_child(file)
	for name in directories:
		var folder := folder_scene.instance() as FolderUi
		folder.folder_name = name
		folders_cont.add_child(folder)


func _on_tree_entered() -> void:
	if folders_cont && files_cont:
		update_folder()
