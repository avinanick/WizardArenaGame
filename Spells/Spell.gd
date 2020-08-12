extends Spatial


export var spell_range: float = 2.0
export var spell_effect: PackedScene
export var is_targeted_spell: bool = true
export var spell_name: String = ""
export var spell_cooldown: float = 2.0

var camera: Camera
var targeting_spell: bool = false
var target: Vector3 = Vector3(0,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_parent().get_parent().get_node("ControlComponent/Camera")
	if not camera:
		print("Error: no camera detected for spell casting!")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_spell():
	print("Activating ", self.spell_name)
	targeting_spell = false
	set_physics_process(false)
	var spawn_location: Vector3 = Vector3(0,0,0)
	if not spell_effect:
		print("Error: No spell effect assigned to spell")
		return
	var new_spell_effect = spell_effect.instance()
	get_tree().current_scene.add_child(new_spell_effect)
	if is_targeted_spell:
		# This should spawn the spell effect as close to the target location as possible
		spawn_location = target
		spawn_location.y = self.global_transform.origin.y
		if self.global_transform.origin.distance_to(spawn_location) > spell_range:
			# Spawn the effect at the edge of max range if the mouse is outside that range
			var target_direction = to_local(target)
			target_direction.y = 0
			target_direction = target_direction.normalized() * spell_range
			spawn_location = to_global(target_direction) 
	else:
		# This should create the spell effect and launch it in the target direction
		var target_direction = to_local(target)
		target_direction.y = 0
		target_direction = target_direction.normalized() * 0.6
		spawn_location = to_global(target_direction)
		# This also needs to set the spell effect velocity here
		print("Impliment adding spell velocity!")
	new_spell_effect.global_transform.origin = spawn_location
	# At this point, the new spell effect needs to be set off, or something
	new_spell_effect.set_direction(Vector2(to_local(spawn_location).z, to_local(spawn_location).x))
	new_spell_effect.start_spell_effect(get_parent().get_parent())

func target_spell():
	targeting_spell = true
	print("Targeting spell: ", targeting_spell)
	if not camera:
		print("Error: no camera detected for spell casting!")
	else:
		#var mouse_intersect: Vector3 = camera.project_ray_origin(get_viewport().get_mouse_position())
		#target = Vector2(mouse_intersect.z, mouse_intersect.y)
		var position2D: Vector2 = get_viewport().get_mouse_position()
		var dropPlane  = Plane(Vector3(0, 1, 0), 1.5)
		var position3D = dropPlane.intersects_ray(
                             camera.project_ray_origin(position2D),
                             camera.project_ray_normal(position2D) * 1000)
		print(position3D)
		target = position3D
		activate_spell()
