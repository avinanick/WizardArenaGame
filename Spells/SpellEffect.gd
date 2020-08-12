extends Spatial


export var effect_damage: int = 0
export var effect_delay: float = 0
export var effect_knockback: float = 0
export var effect_speed: float = 0
var effect_direction: Vector2 = Vector2(0,0) setget set_direction, get_direction
var spell_caster


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_effect():
	pass

func get_direction() -> Vector2:
	return effect_direction

func set_direction(var direction: Vector2):
	effect_direction = direction

func start_spell_effect(var caster):
	spell_caster = caster
	print("Spell location at ", self.global_transform.origin)
	if effect_delay > 0:
		$Timer.wait_time = effect_delay
		$Timer.start()
	else:
		activate_effect()