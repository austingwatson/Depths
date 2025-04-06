class_name PermStats
extends Resource

@export var research := 0

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
@export var unlocked_weapns := [true, false, false]
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

var store := {
	"unlock_laser": 1,
}


func add_research(amount: int) -> void:
	research += amount
	

func buy(unlock: String) -> bool:
	if store[unlock] >= research:
		research -= store[unlock]
		store.erase(unlock)
		return true
	
	return false


func upgrade(unlock: String) -> void:
	match unlock:
		"unlock_laser":
			unlocked_weapns[1] = true
