extends Node


func _ready() -> void:
	var conf_file := File.new()
	if conf_file.file_exists("user://main.conf"):
		conf_file.open("user://main.conf", File.READ)
		var conf := str2var(conf_file.get_pascal_string()) as Config
		conf_file.close()
		start(conf)
	else:
		var dialog : FileDialog = get_node_or_null("FileDialog") as FileDialog
		dialog.get_cancel().visible = false
		dialog.get_close_button().visible = false
		dialog.current_path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
		dialog.popup_centered()
		dialog.connect("dir_selected",self,"folder_selected")


func folder_selected(var path : String):
	var conf := Config.new()
	conf.level_path = path
	var file := File.new()
	file.open("user://main.conf",File.WRITE)
	file.store_pascal_string(var2str(conf))
	file.close()
	start(conf)


func start(config : Config):
	MainController.config = config
	MainController.current_path = config.level_path
	MainController.load_menu()
	queue_free()


