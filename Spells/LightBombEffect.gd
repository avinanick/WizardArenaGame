extends "res://Spells/SpellEffect.gd"


var detonating: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_effect():
	$AnimationPlayer.play("detonate")

# Called when an explostion animation finishes, at which point this effect should be deleted
func finish_detonation():
	self.queue_free()

# Called when a body enters the area, should check if the light bomb is detonating, if so, damage
# the body.
func damage_body(var body):
	if detonating and body.has_method("propagate_message"):
		pass
	pass