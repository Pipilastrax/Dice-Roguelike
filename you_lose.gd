extends Node2D

signal restart
signal mainmenu

func _ready() -> void:
	pass

func _on_restart_button_down() -> void:
	restart.emit()


func _on_main_menu_button_down() -> void:
	mainmenu.emit()

func youlose_namer(bossname : String):
	pass
