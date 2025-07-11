class_name Dice extends Node2D
var dicename :String
var value :int
var reroll :bool = false
var mindice :int = 1
var maxdice :int = 6
var originalpos :Vector2
var cost : int
@onready var PlayerNode:Node2D = self.get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	$Area2D.hide()
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.frame=mindice - 1
	
func roll():
	reroll = false
	value = randi_range(mindice,maxdice)
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()
	await get_tree().create_timer(0.3).timeout
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = value - 1
	
	
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
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
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
	
func reset():
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.frame = 0
	
func buy_dice(dice:String):
	var dicescene : PackedScene = load(str(dice))
	var dicenode = dicescene.instantiate()
	PlayerNode.add_child(dicenode)
	var i = 0
	for node in PlayerNode.get_children():
		if node.is_in_group("Dice"):
			node.position.x = 200 + (80*i)
			node.position.y = 600
			i+=1
			if node.has_method("reset"):
				node.reset()
