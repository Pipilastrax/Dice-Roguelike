extends Node2D
const STARTING_DICE = 3
var maxdice = 10
@export var dice :int 
var rerolls :int
@export var chips :int
var attacks : int
@export var o_rerolls :int = 3
@export var o_attacks	:int = 3
signal animationfinished
func _ready() -> void:
	attacks = o_attacks
	rerolls = o_rerolls

func dice_move_for_attack():
	var tween = create_tween()
	for sprite in get_children():
		if sprite.is_in_group("Dice"):
			sprite.originalpos = sprite.position
			tween.tween_property(sprite, "position", Vector2(580, 100), 0.1)
			tween.tween_property(sprite, "position", sprite.originalpos, 0.2)
			animationfinished.emit()

func count_dice():
	var dice_count : int = 0
	for node in self.get_children():
		if node.is_in_group("Dice"):
			dice_count += 1
	dice = dice_count
	return dice_count
