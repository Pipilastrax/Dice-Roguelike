extends Node2D
var hp :int

func _ready() -> void:
	hp = 25 * Global.stage
	
	
	
func _process(delta: float) -> void:
	if hp < 1:
		Global.stage += 1
	pass
