class_name PermStats
extends Resource

@export var research := 0
@export var max_depth := 0

@export_category("Movement")
@export var max_speed := 0.0
@export var acceleration := 0.0
@export var deceleration := 0.0
@export var rotation_speed := 0.0
@export var thrust_energy := 0.0

@export_category("Energy")
@export var max_energy := 0.0
@export var passive_refill := 0.0

@export_category("Health")
@export var max_health := 0.0

@export_category("Sonar")
@export var max_radius := 0.0
@export var duration := 0.0
@export var sonar_cooldown := 0.0

@export_category("Weapons")
@export var unlocked_weapons := [true, false, false]
@export var damage := 0
@export var range := 0.0
@export var weapon_cooldown := 0.0

@export_category("Torpedo")
@export var torpedo_damage := 0
@export var torpedo_energy := 0.0
@export var torpedo_cooldown := 0.0
@export var torpedo_homing := 0.0

@export_category("Laser")
@export var laser_damage := 0
@export var laser_energy := 0.0
@export var laser_cooldown := 0.0
@export var laser_tick_speed := 0.0

@export_category("Shock")
@export var shock_damage := 0
@export var shock_energy := 0.0
@export var shock_cooldown := 0.0
@export var shock_range := 0.0

@export_category("Depth")
@export var depth := false

@export_category("Light")
@export var light := false

var store := {
	"energy1": 2,
	"energy2": 4,
	"energy3": 6,
	
	"health1": 4,
	"health2": 4,
	"health3": 6,
	
	"cooldown1": 2,
	"cooldown2": 2,
	"cooldown3": 2,
	
	"damage1": 3,
	"damage2": 4,
	"damage3": 5,
	
	"homing": 8,
	
	"laser": 10,
	"laser_cost": 6,
	
	"shock": 8,
	"shock_range": 6,
	
	"depth": 20,
	
	"light": 5,
}
var upgrades := {
	"energy1": 125.0,
	"energy2": 150.0,
	"energy3": 200.0,
	
	"health1": 15,
	"health2": 20,
	"health3": 25,
	
	"cooldown1": 10.0,
	"cooldown2": 8.0,
	"cooldown3": 6.0,
	
	"damage1": 2,
	"damage2": 3,
	"damage3": 4,
	
	"homing": 5.0,
	
	"laser": true,
	"laser_cost": 0.5,
	
	"shock": true,
	"shock_range": 200.0,
	
	"depth": true,
	
	"light": true,
}


func add_research(amount: int) -> void:
	research += amount
	

func have_enough(unlock: String) -> bool:
	return store[unlock] <= research
	

func buy(unlock: String) -> bool:
	if store[unlock] <= research:
		research -= store[unlock]
		store.erase(unlock)
		upgrade(unlock)
		return true
	
	return false


func upgrade(unlock: String) -> void:
	match unlock:
		"energy1":
			max_energy = upgrades[unlock]
		"energy2":
			max_energy = upgrades[unlock]
		"energy3":
			max_energy = upgrades[unlock]
			
		"health1":
			max_health = upgrades[unlock]
		"health2":
			max_health = upgrades[unlock]
		"health3":
			max_health = upgrades[unlock]
			
		"cooldown1":
			sonar_cooldown = upgrades[unlock]
		"cooldown2":
			sonar_cooldown = upgrades[unlock]
		"cooldown3":
			sonar_cooldown = upgrades[unlock]
			
		"damage1":
			damage = upgrades[unlock]
		"damage2":
			damage = upgrades[unlock]
		"damage3":
			damage = upgrades[unlock]
			
		"homing":
			torpedo_homing = upgrades[unlock]
		
		"laser":
			unlocked_weapons[1] = upgrades[unlock]
		"laser_cost":
			laser_energy = upgrades[unlock]
			
		"shock":
			unlocked_weapons[2] = upgrades[unlock]
		"shock_range":
			shock_range = upgrades[unlock]
			
		"depth":
			depth = upgrades[unlock]
			
		"light":
			light = upgrades[unlock]
