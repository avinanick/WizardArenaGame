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
	var angle = rad2deg(atan(effect_direction.y / effect_direction.x))
	if effect_direction.x < 0:
		angle = 180 - angle
	self.rotation_degrees = Vector3(0,angle,0)
	$AnimationPlayer.play("spear_strike")