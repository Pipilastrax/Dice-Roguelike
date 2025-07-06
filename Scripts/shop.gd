extends Node2D

signal next_stage_button

func _process(_delta: float) -> void:
	$Panel2/stats_label.text = "Your stats:\n You have"

func _on_button_button_down() -> void:
	next_stage_button.emit()
