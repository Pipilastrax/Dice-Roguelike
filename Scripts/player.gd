extends Node2D
const STARTING_DICE = 3
var maxdice = 7
@export var dice :int 
var rerolls :int
@export var chips :int
var attacks : int
@export var o_rerolls :int = 3
@export var o_attacks	:int = 3
func _ready() -> void:
	if dice > maxdice:
		dice = maxdice
	if dice < 1:
		dice = 1
	attacks = o_attacks
	rerolls = o_rerolls

func dice_move_for_attack():
	var tween = create_tween()
	for sprite in get_children():
		if sprite.is_in_group("Dice"):
			sprite.originalpos = sprite.position
			tween.tween_property(sprite, "position", Vector2(580, 100), 0.1)
			tween.tween_property(sprite, "position", sprite.originalpos, 0.2)
