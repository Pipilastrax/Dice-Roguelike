extends Node2D

signal next_stage_button
#TODO
#Dictionary of all of the different dice and trinkets and their respective scene
var dice_directory : Dictionary = {"Glitched dice": "res://Scenes/glitched_dice.tscn"}

func _process(_delta: float) -> void:
	$Panel2/stats_label.text = "Your stats:\n You have"

func _on_button_button_down() -> void:
	next_stage_button.emit()
#TODO
#Populate each slot of the shop with a dice to buy
