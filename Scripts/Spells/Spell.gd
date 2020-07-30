extends Spatial


var camera: Camera
var targeting_spell: bool = false
var target: Vector2 = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_parent().get_parent().get_node("ControlComponent/Camera")
	if not camera:
		print("Error: no camera detected for spell casting!")
	pass # Replace with function body.


func physics_process(_delta):
	if targeting_spell:
		if not camera:
			print("Error: no camera detected for spell casting!")
		else:
			var mouse_intersect: Vector3 = camera.project_ray_origin(get_viewport().get_mouse_position())
			target = Vector2(mouse_intersect.z, mouse_intersect.y)
			targeting_spell = false
			activate_spell()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_spell():
	pass

func target_spell():
	targeting_spell = true