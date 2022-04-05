extends Object
class_name Extended


static func free_children(parent : Node):
	for child in parent.get_children():
		parent.remove_child(child)
		(child as Node).queue_free()


static func remove_children(parent : Node):
	for child in parent.get_children():
		parent.remove_child(child)
