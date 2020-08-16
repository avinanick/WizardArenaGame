extends "res://Spells/SpellEffect.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = $KinematicBody.move_and_collide(Vector3(effect_direction.y,0,effect_direction.x).normalized() * effect_speed * delta)
	if collision_info:
		lance_impact(collision_info)

func activate_effect():
	var angle = rad2deg(atan(effect_direction.y / effect_direction.x))
	if effect_direction.x < 0:
		angle = 180 + angle
	self.rotation_degrees = Vector3(0,angle,0)
	$AnimationPlayer.play("spear_strike")

# Called when the lance collides with a physics body
func lance_impact(var collision_info: KinematicCollision):
	if not collision_info.collider == spell_caster:
		var velocity_vector: Vector3 = collision_info.collider.global_transform.origin - self.global_transform.origin
		velocity_vector.y = 0
		velocity_vector = velocity_vector.normalized() * effect_knockback
		var knockback: Vector2 = Vector2(velocity_vector.z, velocity_vector.x)
		if collision_info.collider.has_method("propagate_message"):
			collision_info.collider.propagate_message({"StartSlide": knockback,
														"Damage": effect_damage})
		spell_caster.propagate_message({"StartSlide": knockback * -0.5})
		self.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "spear_strike":
		print("Better end of strike handling?")
		self.queue_free()