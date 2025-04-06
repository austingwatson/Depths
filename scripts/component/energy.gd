class_name Energy
extends Node

signal energy_changed(max_energy: float, energy: float)
signal no_energy
signal charging

@export var infinite_energy := false
@export var max_energy: float
@export var energy: float
@export var passive_refill: float
@onready var refill := $Refill
@onready var power_off := $PowerOff
var stop_refill := false


func use_energy(amount: float) -> void:
	if infinite_energy:
		return
	
	energy -= amount
	if energy <= 0.0:
		energy = 0.0
		refill.stop()
		power_off.start()
		no_energy.emit()
	energy_changed.emit(max_energy, energy)


func _on_refill_timeout() -> void:
	var old_energy := energy
	energy = min(energy + passive_refill, max_energy)
	if energy != old_energy:
		energy_changed.emit(max_energy, energy)


func _on_power_off_timeout() -> void:
	refill.start()
	charging.emit()
