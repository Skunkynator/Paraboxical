extends Button
class_name FolderUi


var folder_name : String setget set_folder_name


func set_folder_name(new_name : String):
	folder_name = new_name
	text = new_name
	#$Button.visible = new_name != ".."


func _on_pressed() -> void:
	if folder_name == ".":
		return
	if folder_name == "..":
		MainController.current_path = MainController.current_path.get_base_dir()
	else:
		MainController.current_path = MainController.current_path.plus_file(folder_name)
	MainController.load_menu()
