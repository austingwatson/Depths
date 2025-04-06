class_name pickup_magnet extends Area2D


#var pickups : Array[resource_pickup] = []
var speeds : Array[float] = []

@export var magnet_strength : float = 1.0

func _ready() -> void:
	#area_entered.connect( _on_area_enter )
	pass

#func _on_area_enter( _a : Area2d ) -> void:
	#if _a.get_parent()

#this shit ain't done. Was meant to serve as the player's radius for vacuuming "repair" and "data" pickups
