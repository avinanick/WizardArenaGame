extends "res://Spells/SpellEffect.gd"


var stone_wall_scene = preload("res://Obstacles/StoneWall.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_effect():
	print("Summoning stone wall")
	var new_wall = stone_wall_scene.instance()
	get_tree().current_scene.add_child(new_wall)
	new_wall.global_transform.origin = self.global_transform.origin
	self.queue_free()