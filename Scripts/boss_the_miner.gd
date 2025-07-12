extends Boss

func _ready():
	super()
	get_tree().get_first_node_in_group("Shop").next_stage_button.connect(execute_dice)
##NOT DOING ANYTHING
func execute_dice():
	var dicenumber:int = len(player_node.get_children())
	var random :int = randi() % dicenumber
	var dice_array: Array
	await get_tree().create_timer(0.3).timeout
	for dice in player_node.get_children():
		if dice.is_in_group("Dice"):
			dice_array.push_front(dice)
			print(str(dice_array) + "DICE ARRAY")
	dice_array[random - 1].queue_free()
			
