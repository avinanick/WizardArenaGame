extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# For now this only deals with single player games, later this will need
	# to be amended to handle multiplayer
	choose_main_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func choose_main_player():
	var arena_wizards = get_tree().get_nodes_in_group("Wizards")
	var chosen_wizard = arena_wizards[randi() % arena_wizards.size()]
	print("Set the chosen wizard as the main")
	chosen_wizard.propagate_message({"MakeMain":true})