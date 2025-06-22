extends Node2D


func _on_playing_table_boss_defeated_signal() -> void:
	$Playing_table.hide()
	for node in $Playing_table.get_children():
		if node.has_method("hide"):
			node.hide()
