extends "res://Scripts/Components/Component.gd"


var player_character: bool = false setget set_player_character, get_player_character


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("move_up"):
		main_body.propagate_message({"StartMove":"Up"})
	if Input.is_action_just_pressed("move_left"):
		main_body.propagate_message({"StartMove":"Left"})
	if Input.is_action_just_pressed("move_right"):
		main_body.propagate_message({"StartMove":"Right"})
	if Input.is_action_just_pressed("move_down"):
		main_body.propagate_message({"StartMove":"Down"})
	if Input.is_action_just_released("move_up"):
		main_body.propagate_message({"EndMove":"Up"})
	if Input.is_action_just_released("move_left"):
		main_body.propagate_message({"EndMove":"Left"})
	if Input.is_action_just_released("move_right"):
		main_body.propagate_message({"EndMove":"Right"})
	if Input.is_action_just_released("move_down"):
		main_body.propagate_message({"EndMove":"Down"})

func get_player_character() -> bool:
	return player_character

func set_player_character(var value: bool):
	set_process(value)
	player_character = value