extends Node2D
var hp :int
var boss_name
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
	var diff = difficulty()
	print("This boss is " + diff)
	if diff =="Hard":
		hp += 15
	elif diff == "Medium":
		hp += 10
	elif diff == "EZ":
		hp += 5
	elif diff == "ULTRA":
		hp += 20
	boss_namer()
	

func boss_namer():
	boss_name = boss_first_names[randi() % boss_first_names.size()] + " el " + boss_last_names[randi() % boss_last_names.size()]
	
func difficulty():
	var rng = randi_range(0,10)
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
	var diff: String = diffdict[rng]
	return diff
