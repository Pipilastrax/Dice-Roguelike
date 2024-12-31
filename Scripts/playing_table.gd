extends Node2D
@onready var roll_button = $HUD/Panel/Roll_button
@onready var score_tag = $HUD/Panel2/Score_label
@onready var reroll_button = $HUD/Panel/Reroll_button
@onready var attacks_label = $HUD/Panel/Attacks_label
@onready var rerolls_label = $HUD/Panel/Rerolls_label
@onready var attack_panel = $HUD/Attack_panel
@onready var attack_button = $HUD/Attack_panel/Attack_buttton
var dice = preload("res://Scenes/dice.tscn") 
var boss = preload("res://Scenes/boss.tscn")
var total_score = 0
var stake = 1
var reroll_button_check :bool = false

func _ready() -> void:
	reroll_button.hide()
	attack_button.disabled = true
	spawn_dice()

func _physics_process(delta: float) -> void:
	#update the score into the score tag
	score_tag.text = str(total_score)
	attacks_label.text = "You have\n" + str($Player.attacks) + " attacks"
	rerolls_label.text = "You have\n" + str($Player.rerolls) + " rerolls"
	if $Player.attacks < 1:
		roll_button.disabled =true
	
#clicking of roll buton rolls the dice and adds the total of each dice 
func _on_roll_button_button_down() -> void:
	roll_button.disabled = true
	total_score = 0
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			print("Rolling dice")
			node.roll()
			await get_tree().create_timer(0.5).timeout
	#Hide roll button and await for rerolls
	roll_button.hide()
	attack_button.disabled = false
	while $Player.rerolls > 0:
		await reroll()
		for node in $Player.get_children():
			if node.is_in_group("Dice"):
				node.get_node("Area2D").hide()
		$Player.rerolls -= 1
		
		
		
	await scoring()
	#cleanup
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			node.get_node("Area2D").hide()
	await damage()
	update_dice_position()
	roll_button.disabled = false

func reroll():
	
	reroll_button.show()
	print("Rerolling")
	#allow the dice to be clicked
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			node.get_node("Area2D").show()
	
	await reroll_button.button_down
	reroll_button.disabled = true
	#roll the clicked dice	
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			if node.reroll:
				node.roll()
	
	
	if $Player.rerolls > 0:
		reroll_button.disabled = false
	else:
		reroll_button.hide()
	
func scoring():
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			total_score += node.value
	roll_button.show()
	
func damage():
	$Player.attacks -= 1
	
	
	
func spawn_dice():
	var i = 0
	for n in get_node("Player").dice:
		var new_dice = dice.instantiate()
		get_node("Player").add_child(new_dice)
		new_dice.position.x = 200 + (80*i)
		new_dice.position.y = 600
		i+=1
		print("added dice")
		

func update_dice_position():
	var i = 0
	var player = get_node("Player")
	for node in player.get_children():
		if node.is_in_group("Dice"):
			node.position.x = 200 + (80*i)
			node.position.y = 600
			i+=1

func _on_attack_button_button_down():
	pass
