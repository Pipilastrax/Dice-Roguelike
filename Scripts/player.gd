extends Node2D
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
	
