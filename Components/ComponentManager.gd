extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func propagate_message(var message: Dictionary):
	for child in self.get_children():
		if child.is_in_group("Components"):
			child.receive_message(message)
	pass