extends Node2D
var value :int
var reroll :bool = false
var mindice :int
var maxdice :int
func _ready() -> void:
	$Area2D.hide()
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.frame=mindice - 1
	
	

	
func roll():
	reroll = false
	value = randi_range(mindice,maxdice)
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = value - 1
	print("the new value is "+ str(value))
	
	
func select():
	reroll = true
	$AnimatedSprite2D.animation = "selected"
	$AnimatedSprite2D.frame = value - 1
	
func unselect():
	reroll = false
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.frame = value - 1	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		$Area2D.hide()
		if reroll:
			unselect()
		else:
			select()
		await get_tree().create_timer(0.3).timeout
		$Area2D.show()
		
