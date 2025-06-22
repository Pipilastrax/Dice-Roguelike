extends Node2D
var stage :int = 1
@onready var main_menu = $Main_menu
@onready var shop = $Shop
@onready var playing_table = $Playing_table
#@onready var battle_win = $Playing_table/battle_win_instance
func	 _ready() -> void:
	#battle_win.goto_shop.connect(_on_battle_win_goto_shop)
	main_menu.play.connect(_on_play_button_pressed)
	#hide everything except the main menu
	playing_table_hide()
	shop_hide()
			
#when boss defeated hide the playing table
func _on_playing_table_boss_defeated_signal() -> void:
	#TODO Animation betwwn scenes
	playing_table_hide()
	#battle_win.goto_shop.connect(_on_battle_win_goto_shop)

func _on_play_button_pressed():
	for node in main_menu.get_children():
		if node.has_method("hide"):
			node.hide()
	playing_table_show()
	
	
	

################TRANSITIONS################
func playing_table_show():
	playing_table.show()
	for node in playing_table.get_children():
		if node.has_method("show"):
			node.show()

func playing_table_hide():
	#$Playing_table.hide()
	for node in $Playing_table.get_children():
		if node.has_method("hide"):
			node.hide()
			
func main_menu_hide():
	main_menu.hide()
	for node in main_menu.get_children():
		if node.has_method("hide"):
			node.hide()
			
func main_menu_show():
	main_menu.show()
	for node in main_menu.get_children():
		if node.has_method("show"):
			node.show()
			
func shop_hide():
	shop.hide()
	for node in shop.get_children():
		if node.has_method("hide"):
			node.hide()
			
func shop_show():
	shop.show()
	for node in shop.get_children():
		if node.has_method("show"):
			node.show()
	
