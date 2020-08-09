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
			body.propagate_message({"StartSlide": effect_knockback})
	self.queue_free()

# Called when a body enters the area, should check if the light bomb is detonating, if so, damage
# the body.
func knockback_body(var body):
	if detonating and body.has_method("propagate_message"):
		body.propagate_message({"StartSlide": effect_knockback})

func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "detonate":
		finish_detonation()