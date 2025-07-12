class_name Boss extends Node2D
var hp :int
var boss_name: String
var diff: String
@onready var player_node = get_tree().get_first_node_in_group("Player")
var diffdict = [
	"EZ",
	"EZ",
	"EZ",
	"Medium",
	"Medium",
	"Medium",
	"Medium",
	"Hard",
	"Hard",
	"Hard",
	"ULTRA"
	
]
var boss_first_names = [
"Pipi",
"Gavo",
"Maxi", 
"Turco",
"Cipri",
"Lombro",
"Yago",
"Soto",
"Martorskull"
]
var boss_last_names =[
"Asesino",
"Follador",
"Matapipis",
"hombre sexo",
"Anashei",
"Troll",
"XD",
"Risas",
"Malcriado",
"OSU Player",
"Comediante",
"Gordo compu",
"Peronista"
]
func _ready() -> void:
	hp = 20 * Global.stage
	diff = difficulty()
	if Global.stage == 1:
		diff = "Medium"
	elif Global.stage > 1:
		print("This boss is " + diff)
		if diff =="Hard":
			hp += 10
		elif diff == "Medium":
			hp += 5
		elif diff == "EZ":
			hp += 0
		elif diff == "ULTRA":
			hp += 15
	boss_namer()
	

func boss_namer():
	boss_name = boss_first_names[randi() % boss_first_names.size()] + " el " + boss_last_names[randi() % boss_last_names.size()]
	
func difficulty():
	var rng = randi_range(0,diffdict.size() - 1)
	var diffans: String = diffdict[rng]
	return diffans
