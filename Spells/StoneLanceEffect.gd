extends "res://Spells/SpellEffect.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = $KinematicBody.move_and_collide(Vector3(0,0,effect_speed) * delta)
	if collision_info:
		print("Handle collision")

func activate_effect():
	$AnimationPlayer.play("spear_strike")