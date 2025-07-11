extends Node
var stage :int = 1

##Game Print
##Game print function creates a label in the desired position that has the text that you pass to it,
## and dissapears after the desired time
##@experimental
#TODO
func game_print(text_pass: String, position_passed: Vector2, text_size: int, time: int):
	var newlabel = Label.new()
	newlabel.text = text_pass
	newlabel.font_size = text_size
	get_tree().get_first_node_in_group("Player").add_child(newlabel)
	newlabel.position = position_passed
	print(str(newlabel.position) + "Is the position fo gameprint")
	await get_tree().create_timer(time).timeout
	newlabel.queue_free()
	
	
