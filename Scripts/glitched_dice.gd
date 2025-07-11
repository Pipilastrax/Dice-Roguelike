extends Dice
func _init():
	dicename = "Glitched Dice"

func roll():
	reroll = false
	value = randi_range(mindice,maxdice)
	#rerolls if value is 2 or 1
	if value < 3:
		print("Glitched Dice REROLLED")
		value = randi_range(mindice,maxdice)

	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = value - 1
	print("the new GLITCHED DICE value is "+ str(value))
