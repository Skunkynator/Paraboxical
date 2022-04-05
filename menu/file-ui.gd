extends Button
class_name FileUi


var file_name : String setget set_file_name


func set_file_name(new_name : String):
	file_name = new_name
	text = new_name


func _on_pressed() -> void:
	MainController.load_editor(file_name)
	pass # Replace with function body.
