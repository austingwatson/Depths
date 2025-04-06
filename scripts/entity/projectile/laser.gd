class_name Laser
extends RayCast2D

@onready var line := $Line2D
var is_casting: 
	get:
		return is_casting
	set(value):
		is_casting = value
		set_physics_process(is_casting)
		
		if is_casting:
			appear()
		else:
			disappear()
		
	
func _ready() -> void:
	set_physics_process(false)
		

func _physics_process(_delta: float) -> void:
	force_raycast_update()
	
	var cast_point := Vector2(1000.0, 0.0)
	if is_colliding():
		print("is_colliding")
		cast_point = to_local(get_collision_point())
		
	line.points[1] = cast_point
	

func appear() -> void:
	var tween := create_tween()
	tween.tween_property(line, "width", 10.0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	

func disappear() -> void:
	var tween := create_tween()
	tween.tween_property(line, "width", 0.0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
