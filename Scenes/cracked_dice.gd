extends Dice
var crack:int
func _ready() -> void:
	super()
	crack = randi() % maxdice
	
func roll():
	super()
	if value == crack:
		value = value*2
#sometimes this dice will break and spawn two normal dice
func break_dice():
	if randi() % 5 == 1:
		print("DICE BROKEN")
		buy_dice("res://Scenes/dice.tscn")
		buy_dice("res://Scenes/dice.tscn")
		queue_free()
		
