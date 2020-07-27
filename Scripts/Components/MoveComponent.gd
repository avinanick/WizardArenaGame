extends "res://Scripts/Components/Component.gd"


export var move_speed: float = 1.0
export var min_move_time: float = 0 

var move_direction: Vector2 = Vector2(0,0)
var current_directions: Dictionary = {"Up":false,
									"Down":false,
									"Left":false,
									"Right":false}

signal end_move
signal start_move

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_movement(var direction):
	set_process(true)
	current_directions[direction] = true
	move_direction = Vector2(0,0)
	if current_directions["Up"]:
		move_direction.y += 1
	if current_directions["Down"]:
		move_direction.y -= 1
	if current_directions["Left"]:
		move_direction.x -= 1
	if current_directions["Right"]:
		move_direction.x += 1
	move_direction = move_direction.normalized()

func receive_message(var message: Dictionary):
	if message.has("StartMove"):
		emit_signal("start_move", message["StartMove"])
	if message.has("EndMove"):
		emit_signal("end_move", message["EndMove"])

func subtract_movement(var direction):
	pass