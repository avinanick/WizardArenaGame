extends Spatial


export var effect_delay: float = 0
var effect_direction: Vector2 = Vector2(0,0) setget set_direction, get_direction


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func engage_spell_effect():
	pass

func get_direction() -> Vector2:
	return effect_direction

func set_direction(var direction: Vector2):
	effect_direction = direction