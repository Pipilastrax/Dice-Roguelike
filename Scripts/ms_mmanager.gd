extends Node2D
var stage :int = 1
@onready var main_menu = $Main_menu
@onready var shop = $Shop
@onready var playing_table = $Playing_table

#@onready var battle_win = $Playing_table/battle_win_instance
func	 _ready() -> void:
	$BgMusic.play()
	#battle_win.goto_shop.connect(_on_battle_win_goto_shop)
	main_menu.play.connect(_on_play_button_pressed)
	shop.next_stage_button.connect(_on_next_stage_button_pressed)
	playing_table.boss_not_defeated_signal.connect(_boss_not_defeated)
	#hide everything except the main menu
	playing_table_hide()
	shop_hide()
			
#when boss defeated hide the playing table
func _on_playing_table_boss_defeated_signal() -> void:
	Global.stage += 1
	#TODO Animation betwwn scenes
	playing_table_hide()
	shop_show()
	$Shop.store_populator()
	
	#battle_win.goto_shop.connect(_on_battle_win_goto_shop)

func _on_play_button_pressed():
	for node in main_menu.get_children():
		if node.has_method("hide"):
			node.hide()
	playing_table_show()
	
func _on_next_stage_button_pressed():
	shop_hide()
	playing_table_show()
	playing_table.prepare_next_stage()
	
func _boss_not_defeated():
	playing_table.you_lose()
	pass
	
	

##Shows the playing table and all of its children
##
##It's done this way bc i have no idea why some stuff will
##not show or hide if i just do [code]playing_table.show()[/code]
##, same applies for all of the other show and hide functions
func playing_table_show():
	playing_table.show()
	for node in playing_table.get_children():
		if node.has_method("show"):
			node.show()

func playing_table_hide():
	#$Playing_table.hide()
	if $Playing_table.has_method("update_dice_position"):
		$Playing_table.update_dice_position()
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
	
