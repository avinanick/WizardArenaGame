extends "res://Components/Component.gd"


export var move_speed: float = 1.0 

var move_direction: Vector2 = Vector2(0,0)
var current_directions: Dictionary = {"Up":false,
									"Down":false,
									"Left":false,
									"Right":false}
var sliding: bool = false

signal end_move
signal ending_slide
signal moving_direction
signal start_move
signal starting_slide

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	self.connect("start_move", self, "add_movement")
	self.connect("end_move", self, "subtract_movement")
	self.connect("starting_slide", self, "begin_slide")
	self.connect("ending_slide", self, "end_slide")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# I'm not a fan of the way godot orients 3d axis, for now I'll do: +z is horizontal right,
	# +x is horizontal up, and +y is vertical up
	# for now I'm using move_and_collide, I may later decide on move_and_slide depending on 
	# behavior
	var movement: Vector3 = Vector3(move_direction.y, 0, move_direction.x)
	var collision_info = main_body.move_and_collide(movement * delta * move_speed)
	if collision_info:
		handle_collision(collision_info)

func add_movement(var direction):
	set_process(true)
	current_directions[direction] = true
	if not sliding:
		calculate_overall_move()

func begin_slide(var direction: Vector2):
	sliding = true
	move_direction = direction
	set_process(true)

func calculate_overall_move():
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
	emit_signal("moving_direction", move_direction)

func end_slide():
	sliding = false
	calculate_overall_move()
	if move_direction.length() < 0.5:
		set_process(false)

func handle_collision(var collision_info: KinematicCollision):
	if sliding:
		end_slide()

func receive_message(var message: Dictionary):
	if message.has("StartMove"):
		emit_signal("start_move", message["StartMove"])
	if message.has("EndMove"):
		emit_signal("end_move", message["EndMove"])
	if message.has("StartSlide"):
		emit_signal("starting_slide", message["StartSlide"])
	if message.has("EndSlide"):
		emit_signal("ending_slide")


func subtract_movement(var direction):
	current_directions[direction] = false
	if not sliding:
		calculate_overall_move()
		if move_direction.length() < 0.5:
			set_process(false)