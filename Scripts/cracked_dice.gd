extends Dice
var crack:int
func _ready() -> void:
	super()
	crack = randi() % maxdice
	
func roll():
	super()
	if value == crack:
		value = value*2
	break_dice()
#sometimes this dice will break and spawn two normal dice
func break_dice():
	if randi() % 5 == 1:
		Global.game_print("Dice Broken!", self.position, 15, 1)
		print("DICE BROKEN")
		#TODO gotta fix the buy dice func for this dice, as it resets all of the dices faces when it breaks
		buy_dice("res://Scenes/dice.tscn")
		buy_dice("res://Scenes/dice.tscn")
		queue_free()
		
