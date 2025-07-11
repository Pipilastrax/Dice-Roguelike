extends Node2D
var slot1 :int
var slot2 :int
var slot3 :int
#TODO add trinket slot when its implemented
@onready var PlayerNode:Node2D = self.get_tree().get_first_node_in_group("Player")
signal next_stage_button
#TODO
#Dictionary of all of the different dice and trinkets and their respective scene
var all_dice_dict :Dictionary = {
	0:{
		"Name": "Dice",
		"Cost": 20,
		"Rarity": 1,
		"Flavor": "Just a regular dice",
		"Path":"res://Scenes/dice.tscn"},
	1:{
		"Name": "Glitched Dice",
		"Cost": 30,
		"Rarity": 2,
		##TODO un mejor flavor para esto xd
		"Flavor": "Its Glitched",
		"Path":"res://Scenes/glitched_dice.tscn"},
	2:{
		"Name": "Cracked Dice",
		"Cost": 35,
		"Rarity": 3,
		"Flavor": "One of it's faces its broken",
		"Path":"res://Scenes/cracked_dice.tscn"},
	3:{
		"Name": "D20",
		"Cost": 50,
		"Rarity": 5,
		"Flavor": "Critical hit!",
		"Path":"res://Scenes/cracked_dice.tscn"}
}
func _init() -> void:
	pass
	
func _process(_delta: float) -> void:
	$Panel2/stats_label.text = "Your stats:\n You have ¢" + str(PlayerNode.chips) + "\nYou have " + str(PlayerNode.count_dice()) + " Dice"
	update_buttons()

func _on_button_button_down() -> void:
	next_stage_button.emit()
	
func buy_dice(dice:String):
	var dicescene : PackedScene = load(str(dice))
	var dicenode = dicescene.instantiate()
	PlayerNode.add_child(dicenode)
	var i = 0
	for node in PlayerNode.get_children():
		if node.is_in_group("Dice"):
			node.position.x = 200 + (80*i)
			node.position.y = 600
			i+=1
			if node.has_method("reset"):
				node.reset()
	
##Store populator is called from the mms manager to populate the shop with items to buy
func store_populator():
	slot1 = randi() % all_dice_dict.size()
	slot2 = randi() % all_dice_dict.size()
	slot3 = randi() % all_dice_dict.size()
	$slot1/item_name.text = all_dice_dict[slot1].get("Name")
	$slot2/item_name.text = all_dice_dict[slot2].get("Name")
	$slot3/item_name.text = all_dice_dict[slot3].get("Name")
	$slot1/item_cost.text = "¢ " + str(all_dice_dict[slot1].get("Cost"))
	$slot2/item_cost.text = "¢ " + str(all_dice_dict[slot2].get("Cost"))
	$slot3/item_cost.text = "¢ " + str(all_dice_dict[slot3].get("Cost"))
		
			
	
func _buy_button1_down() -> void:
	buy_dice(all_dice_dict[slot1].get("Path"))
	PlayerNode.chips -= all_dice_dict[slot1].get("Cost")
func _buy_button2_down() -> void:
	buy_dice(all_dice_dict[slot2].get("Path"))
	PlayerNode.chips -= all_dice_dict[slot2].get("Cost")
func _on_buy_button_button_down() -> void:
	buy_dice(all_dice_dict[slot3].get("Path"))
	PlayerNode.chips -= all_dice_dict[slot3].get("Cost")


func update_buttons():
	var dice_count = PlayerNode.count_dice()
	if PlayerNode.chips < all_dice_dict[slot1].get("Cost") || dice_count >= 10:
		$slot1/buy_button.disabled = true
	else:
		$slot1/buy_button.disabled = false
	if PlayerNode.chips < all_dice_dict[slot2].get("Cost") || dice_count >= 10:
		$slot2/buy_button.disabled = true
	else:
		$slot2/buy_button.disabled = false
	if PlayerNode.chips < all_dice_dict[slot3].get("Cost") || dice_count >= 10:
		$slot3/buy_button.disabled = true
	else:
		$slot3/buy_button.disabled = false
