extends Node2D
var stage :int = 1
@onready var main_menu = $Main_menu
@onready var shop = $Shop
@onready var playing_table = $Playing_table
@onready var battle_win = $Playing_table/HUD/battle_win

func	 _ready() -> void:
	battle_win.goto_shop.connect(_on_battle_win_goto_shop)
	main_menu.play.connect(_on_play_button_pressed)
	#hide everything except the main menu
	for node in $Playing_table.get_children():
		if node.has_method("hide"):
			node.hide()
	for node in $Shop.get_children():
		if node.has_method("hide"):
			node.hide()
			
#when boss defeated hide the playing table
func _on_playing_table_boss_defeated_signal() -> void:
	#TODO Animation betwwn scenes
	$Playing_table.hide()
	for node in $Playing_table.get_children():
		if node.has_method("hide"):
			node.hide()
			
			
func _on_battle_win_goto_shop():
	print("Goint to shop")
	
func _on_play_button_pressed():
	print("play")
