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
	$select_sound.play()

func unselect():
	reroll = false
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.frame = value - 1	

#select and unselect dice for rolling
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		$Area2D.hide()
		if reroll:
			unselect()
		else:
			select()
		await get_tree().create_timer(0.3).timeout
		$Area2D.show()


#movement and sound of the dice when hovered
func _on_hover_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"rotation",0.2,0.1)
	$hover_sound.play()


func _on_hover_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"rotation",0,0.1)
