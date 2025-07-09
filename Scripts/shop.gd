extends Node2D
var slot1 :int
var slot2 :int
var slot3 :int
signal next_stage_button
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
		"Path":"res://Scenes/glitched_dice.tscn"}
}
func _process(_delta: float) -> void:
	$Panel2/stats_label.text = "Your stats:\n You have"

func _on_button_button_down() -> void:
	next_stage_button.emit()

func store_populator():
	slot1 = randi() % all_dice_dict.size()
	slot2 = randi() % all_dice_dict.size()
	slot3 = randi() % all_dice_dict.size()
	
	
	
