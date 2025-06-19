extends Node2D
var maxdice = 7
@export var dice :int 
@export var rerolls :int
@export var chips :int
@export var attacks : int

func _ready() -> void:
	if dice > maxdice:
		dice = maxdice
	if dice < 1:
		dice = 1
	
