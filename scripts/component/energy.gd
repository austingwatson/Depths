class_name Energy
extends Node

signal energy_changed(max_energy: float, energy: float)

@export var max_energy: float
@export var energy: float
@export var start_charge_time: float
@export var charge_time: Array[float]
@onready var start_charge := $StartCharge


func _ready() -> void:
	start_charge.wait_time = start_charge_time


func has_energy(_needed: float) -> bool:
	return true
	#return needed <= energy
	

func use_energy(amount: float) -> void:
	energy -= amount
	energy_changed.emit(max_energy, energy)
	start_charge.start()
	

func _on_start_charge_timeout() -> void:
	pass # Replace with function body.
