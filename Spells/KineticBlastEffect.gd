extends "res://Spells/SpellEffect.gd"


var detonating = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_effect():
	print("Detonating ", self.name)
	$AnimationPlayer.play("detonate")
	detonating = true

# Called when an explostion animation finishes, at which point this effect should be deleted
func finish_detonation():
	var bodies_within = $Area.get_overlapping_bodies()
	for body in bodies_within:
		if body.has_method("propagate_message"):
			# Get the direction to the body, set the length of that vector to the effect 
			# knockback, and send that in the message
			var direction_vector: Vector3 = body.global_transform.origin - self.global_transform.origin
			var knockback_vector: Vector2 = Vector2(direction_vector.z, direction_vector.x)
			knockback_vector = knockback_vector.normalized() * effect_knockback
			body.propagate_message({"StartSlide": knockback_vector})
	self.queue_free()

# Called when a body enters the area, should check if the light bomb is detonating, if so, damage
# the body.
func knockback_body(var body):
	if detonating and body.has_method("propagate_message"):
		body.propagate_message({"StartSlide": effect_knockback})

func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "detonate":
		finish_detonation()