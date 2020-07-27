extends "res://Scripts/Components/Component.gd"


export var move_speed: float = 1.0
export var min_move_time: float = 0 

var move_direction: Vector2 = Vector2(0,0)

signal end_move
signal start_move

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_movement(var direction):
	pass

func receive_message(var message: Dictionary):
	if message.has("StartMove"):
		emit_signal("start_move", message["StartMove"])
	if message.has("EndMove"):
		emit_signal("end_move", message["EndMove"])

func subtract_movement(var direction):
	pass