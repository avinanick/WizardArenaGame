extends Spatial


var defeated_wizards: Array = []


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
	arena_wizards.shuffle()
	for i in range(arena_wizards.size()):
		print("Set the chosen wizard as the main")
		arena_wizards[i].propagate_message({"AssignPlayer":i})

# This should be called when a wizard runs out of health, check how many wizards 
# remain and, if only one, then that one is the winner.
func on_wizard_defeated(var player_number: int):
	defeated_wizards.append(player_number)
	var arena_wizards = get_tree().get_nodes_in_group("Wizards")
	if defeated_wizards.size() == (arena_wizards.size() - 1):
		print("Only one wizard remains! Credit the victor!")
	pass