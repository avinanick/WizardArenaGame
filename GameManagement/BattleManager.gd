extends Spatial


var defeated_wizards: Array = []
var all_wizards: Array = []


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
	all_wizards = get_tree().get_nodes_in_group("Wizards")
	all_wizards.shuffle()
	for i in range(all_wizards.size()):
		print("Set the chosen wizard as the main")
		all_wizards[i].propagate_message({"AssignPlayer":i})
		var control = all_wizards[i].get_node("ControlComponent")
		if not control:
			print("Error: Control component not found in wizard")
			return
		control.connect("player_defeated", self, "on_wizard_defeated")

# This should be called when a wizard runs out of health, check how many wizards 
# remain and, if only one, then that one is the winner.
func on_wizard_defeated(var player_number: int):
	defeated_wizards.append(player_number)
	if defeated_wizards.size() == (all_wizards.size() - 1):
		print("Only one wizard remains! Credit the victor!")
		for i in range(all_wizards.size()):
			if not i in defeated_wizards:
				print("Player ", i, " wins!")
	pass