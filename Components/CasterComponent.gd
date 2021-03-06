extends "res://Components/Component.gd"


signal cast_spell


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("cast_spell", self, "cast_spell")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func cast_spell(var spell_number: int):
	var spell_to_cast = get_child(spell_number)
	if spell_to_cast:
		spell_to_cast.target_spell()
	else:
		print("No spell for slot ", spell_number)

func receive_message(var message: Dictionary):
	if message.has("CastSpell"):
		emit_signal("cast_spell", message["CastSpell"])