extends Node2D
var stage :int = 1
@onready var battle_win = $Playing_table/HUD/battle_win

func	 _ready() -> void:
	#hide everything except the main menu
	for node in $Playing_table.get_children():
		if node.has_method("hide"):
			node.hide()
	for node in $Shop.get_children():
		if node.has_method("hide"):
			node.hide()
#when boss defeated hide the playing table
func _on_playing_table_boss_defeated_signal() -> void:
	$Playing_table.hide()
	for node in $Playing_table.get_children():
		if node.has_method("hide"):
			node.hide()
	
