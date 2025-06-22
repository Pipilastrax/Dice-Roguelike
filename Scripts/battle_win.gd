extends Control
signal goto_shop
@onready var msm_manager = $ms_mmanager
func _ready() -> void:
	$Panel/Label.text = "Congrats, goto shop"
	pass


func _on_continue_button_button_down() -> void:
	goto_shop.emit()
	print("continue button pressed")
	hide()
