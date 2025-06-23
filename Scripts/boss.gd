extends Node2D
var hp :int
var boss_name
var boss_first_names = ["
Pipi",
 "Gavo",
 "Maxi", 
"Turco",
 "Cipri",
 "Lombro",
 "Yago",
 "Soto",
 "Martorskull"]
var boss_last_names =[
"Asesino",
 "Follador",
 "Matapipis",
 "hombre sexo",
 "Anashei",
 "Troll",
 "XD",
 "Risas"]
func _ready() -> void:
	hp = 25 * Global.stage
	boss_namer()
	
	
	
func _process(delta: float) -> void:
	pass


func boss_namer():
	boss_name = boss_first_names[randi() % boss_first_names.size()] + " el " + boss_last_names[randi() % boss_last_names.size()]
	
