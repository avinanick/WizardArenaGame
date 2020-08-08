extends "res://Components/Component.gd"


export var health_points: int = 100

signal taking_damage


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("taking_damage", self, "handle_damage")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func handle_damage(var amount: int):
	health_points -= amount
	print("Remaining health: ", health_points)
	if health_points <= 0:
		print("Out of health!")

func receive_message(var message: Dictionary):
	if message.has("Damage"):
		emit_signal("taking_damage", message["Damage"])