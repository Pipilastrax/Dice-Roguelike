extends Node2D
@onready var roll_button = $HUD/Panel/Roll_button
@onready var score_tag = $HUD/Panel2/Score_label
@onready var reroll_button = $HUD/Panel/Reroll_button
@onready var attacks_label = $HUD/Panel/Attacks_label
@onready var rerolls_label = $HUD/Panel/Rerolls_label
@onready var attack_panel = $HUD/Attack_panel
@onready var attack_button = $HUD/Attack_panel/Attack_buttton
@onready var boss_name = $HUD/Boss_stats/Boss_name
@onready var boss_hp_tag = $HUD/Boss_stats/Boss_hp
@onready var battle_win = preload("res://Scenes/battle_win.tscn")
@onready var boss = preload("res://Scenes/boss.tscn")
@onready var BossNode:Node2D 
signal boss_defeated_signal
signal boss_not_defeated_signal
var is_there_boss :bool = false
var dice = preload("res://Scenes/dice.tscn") 
var boss_hp : float
var total_score = 0
var stake = 1
var reroll_button_check :bool = false

func _ready() -> void:
	reroll_button.hide()
	attack_button.disabled = true
	spawn_dice()
	spawn_boss()
	BossNode = self.get_tree().get_first_node_in_group("Boss")
	

func _process(_delta: float) -> void:
	#update the score and stats into the score tag
	if is_there_boss:
		$HUD/Boss_stats/Boss_name.text = $Boss.boss_name
		boss_hp_tag.text = str($Boss.hp) + " HP"
		score_tag.text = str(total_score)
	attacks_label.text = "You have\n" + str($Player.attacks) + " attacks"
	rerolls_label.text = "You have\n" + str($Player.rerolls) + " rerolls"
	if $Player.attacks < 1:
		attack_button.disabled = true
		roll_button.disabled = true

##This function sets the player rerolls and attatcks back to his maximum and
## also spawns a new boss
func	prepare_next_stage():
	$Player.rerolls = $Player.o_rerolls
	$Player.attacks = $Player.o_attacks
	spawn_boss()
	BossNode = self.get_tree().get_first_node_in_group("Boss")
	$HUD/Panel/Roll_button.disabled = false
	
#clicking of roll buton rolls the dice and adds the total of each dice 
func _on_roll_button_button_down() -> void:
	roll_button.disabled = true
	roll_button.hide()
	total_score = 0
	$Roll_sound.play()
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			node.roll()
			await get_tree().create_timer(0.3).timeout
	#Hide roll button and await for rerolls
	roll_button.hide()
	attack_button.disabled = false
	scoring()
	reroll_button.show()
		
		
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			node.get_node("Area2D").show()	
	roll_button.disabled = false

func reroll():
	print("Rerolling")
	$Roll_sound.play()
	reroll_button.disabled = true
	$Player.rerolls -= 1
		#roll the clicked dice	
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			if node.reroll:
				node.roll()
	scoring()	
	if $Player.rerolls > 0:
		reroll_button.disabled = false
	else:
		reroll_button.hide()
	
func scoring():
	total_score = 0
	for node in $Player.get_children():
		if node.is_in_group("Dice"):
			total_score += node.value
	
func damage():
	$Player.attacks -= 1
	
	if $Player.has_method("dice_move_for_attack"):
		$Player.dice_move_for_attack()
	$Boss.hp = $Boss.hp - total_score
	

func spawn_dice():
	var i = 0
	for n in get_node("Player").STARTING_DICE:
		var new_dice = dice.instantiate()
		get_node("Player").add_child(new_dice)
		new_dice.position.x = 200 + (80*i)
		new_dice.position.y = 600
		new_dice.mindice = 1
		new_dice.maxdice = 6
		new_dice.originalpos = new_dice.position
		i+=1

func spawn_boss():
	var boss_spawn = boss.instantiate()
	$".".add_child(boss_spawn)
	boss_spawn.name="Boss"
	is_there_boss = true
	
##Updates the position of dice back to the starting one,
## Right now its not used for anything xd
##
##@experimental:
func update_dice_position():
	var i = 0
	var player = get_node("Player")
	for node in player.get_children():
		if node.is_in_group("Dice"):
			node.position.x = 200 + (80*i)
			node.position.y = 600
			i+=1
			if node.has_method("reset"):
				node.reset()

func _on_attack_buttton_button_down() -> void:
	attack_button.disabled = true
	damage()
	roll_button.show()
	reroll_button.hide()
	if $Boss.hp <= 0:
		boss_defeated()
	if $Player.attacks < 1 && $Boss.hp > 0:
		boss_not_defeated()

func _on_reroll_button_button_down() -> void:
	reroll()
	
func boss_defeated():
	is_there_boss = false	
	$Player.chips += 5* $Player.attacks
	boss_defeated_signal.emit()
	$Player.chips += 25
	match BossNode.diff:
		"EZ":
			pass
		"Medium":
			$Player.chips += 5
		"Hard":
			$Player.chips +=10
		"ULTRA":
			$Player.chips +=20
	##This used to spawn an extra screen before the shop but it proved tricky
	##to implement so will not use it anymore
	##
	## xd
	##@deprecated:
	#var battle_win_instance = battle_win.instantiate()
	#battle_win_instance.name = "battle_win_instance"
	#$".".add_child(battle_win_instance)
	print("Boss defeated")
	$Boss.queue_free()
	
	
##TODO Boss not defeated funcion right now doesnt do anything
##hehe
##@experimental:
func boss_not_defeated():
	print("Boss not defeated")
	boss_not_defeated_signal.emit()
	
func you_lose():
	pass
	
