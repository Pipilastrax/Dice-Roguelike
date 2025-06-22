extends Control

func _ready() -> void:
	$Panel/Label.text = "Congrats, goto shop"
	pass


func _on_continue_button_button_down() -> void:
	print("continue button pressed")
