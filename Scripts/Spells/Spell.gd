extends Spatial


export var spell_range: float = 2.0
export var spell_effect: PackedScene
export var is_targeted_spell: bool = true
export var spell_name: String = ""
export var spell_cooldown: float = 2.0

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
	if is_targeted_spell:
		print("This should drop a new spell effect at the target location, or as close as possible")
		var spawn_location: Vector3 = Vector3(self.global_transform.origin.x, target.y, target.x)
		if not spell_effect:
			print("Error: No spell effect assigned to spell")
			return
		var new_spell_effect = spell_effect.instance()
		new_spell_effect.global_transform = spawn_location
		
	else:
		print("This should create the spell effect and launch it in the target direction")

func target_spell():
	targeting_spell = true