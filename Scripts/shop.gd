extends Node2D

signal next_stage_button

func _on_button_button_down() -> void:
	next_stage_button.emit()
