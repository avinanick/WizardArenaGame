extends "res://Components/Component.gd"


export var player_character: bool = false setget set_player_character, get_player_character

var player_number: int = -1
var player_name: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	set_player_character(player_character)


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
	if Input.is_action_just_pressed("cast_spell_one"):
		main_body.propagate_message({"CastSpell":0})
	if Input.is_action_just_pressed("cast_spell_two"):
		main_body.propagate_message({"CastSpell":1})
	if Input.is_action_just_pressed("cast_spell_three"):
		main_body.propagate_message({"CastSpell":2})
	set_cursor_position()

func set_cursor_position():
	var position2D: Vector2 = get_viewport().get_mouse_position()
	var dropPlane  = Plane(Vector3(0, 1, 0), 1.5)
	var position3D = dropPlane.intersects_ray(
							$Camera.project_ray_origin(position2D),
							$Camera.project_ray_normal(position2D) * 1000)
	$Cursor.global_transform.origin = position3D

func get_player_character() -> bool:
	return player_character

func receive_message(var message: Dictionary):
	if message.has("AssignPlayer"):
		self.player_number = message["AssignPlayer"]
		if player_number == 0:
			set_player_character(true)

func set_player_character(var value: bool):
	set_process(value)
	$Camera.make_current()
	player_character = value
