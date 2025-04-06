extends Node


func _ready() -> void:
	var player := preload("res://scenes/entity/actor/player.tscn").instantiate()
	EntityManager.add_entity(player, false)
	
	var urchin := preload("res://scenes/entity/actor/urchin.tscn").instantiate()
	urchin.global_position = Vector2(50, 50)
	EntityManager.add_entity(urchin, true)
	
	var research_pickup := preload("res://scenes/entity/drops/resource_pickup.tscn").instantiate()
	research_pickup.global_position = Vector2(-50, -50)
	EntityManager.add_entity(research_pickup, true)
