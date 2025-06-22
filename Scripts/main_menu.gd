extends Node2D
signal play


func _on_play_button_button_down() -> void:
	play.emit()
