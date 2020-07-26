extends Node


var main_body


# Called when the node enters the scene tree for the first time.
func _ready():
	main_body = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# To be implimented in inherited classes
func receive_message(var message: Dictionary):
	pass