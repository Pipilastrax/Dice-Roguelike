extends Control
signal goto_shop
#TODO fix this var
#@onready var msm_manager = get_tree().get_node("ms_mmanager")
func _ready() -> void:
	$Panel/Label.text = "Congrats, goto shop"


func _on_continue_button_button_down() -> void:
	goto_shop.emit()
	print("continue button pressed")
	hide()
