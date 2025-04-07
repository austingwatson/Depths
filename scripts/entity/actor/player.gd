class_name Player
extends Node2D

enum Weapon {
	TORPEDO,
	LASER,
	SHOCK,
}

const rotation_threshold := 0.1
@export var forward_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D
@onready var movement := $Movement
@onready var energy := $Energy
@onready var sprite := $Sprite2D
@onready var energy_amount := $EnergyAmount
@onready var radius_light := $RadiusLight
@onready var forward_light := $ForwardLight
@onready var emergency_light := $EmergencyLight
@onready var thrusting := $Thrusting
@onready var flicker := $Flicker
@onready var camera := $Camera2D
@onready var hurt_box := $HurtBox
@onready var sonar := $Sonar
@onready var sonar_cooldown := $SkillCooldowns/SonarCooldown
@onready var torpedo_cooldown := $SkillCooldowns/TorpedoCooldown
@onready var shock_cooldown := $SkillCooldowns/ShockCooldown
@onready var laser := $Laser
var player_stats: PermStats = EntityManager.player_stats
var no_power := false
var initial_drop := true
var weapon := Weapon.TORPEDO


func _ready() -> void:
	thrusting.paused = true
	
	var hurt_box := $HurtBox
	GlobalSignals.on_player_health_changed(hurt_box.max_health, hurt_box.health)
	GlobalSignals.heal_player.connect(_on_heal_player)
	
	movement.max_speed = player_stats.max_speed
	movement.acceleration = player_stats.acceleration
	movement.deceleration = player_stats.deceleration
	movement.rotation_speed = player_stats.rotation_speed
	
	energy.max_energy = player_stats.max_energy
	energy.energy = player_stats.max_energy
	energy.passive_refill = player_stats.passive_refill
	
	hurt_box.max_health = player_stats.max_health
	hurt_box.health = player_stats.max_health
	
	sonar.max_radius = player_stats.max_radius
	sonar.duration = player_stats.duration
	
	sonar_cooldown.cooldown = player_stats.sonar_cooldown
	sonar_cooldown.timer.wait_time = player_stats.sonar_cooldown
	
	torpedo_cooldown.cooldown = player_stats.weapon_cooldown + player_stats.torpedo_cooldown
	torpedo_cooldown.timer.wait_time = player_stats.weapon_cooldown + player_stats.torpedo_cooldown
	
	shock_cooldown.cooldown = player_stats.weapon_cooldown + player_stats.shock_cooldown
	shock_cooldown.timer.wait_time = player_stats.weapon_cooldown + player_stats.shock_cooldown
	

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("change_weapon_up"):
		match weapon:
			Weapon.TORPEDO:
				if player_stats.unlocked_weapons[1]:
					weapon = Weapon.LASER
				elif player_stats.unlocked_weapons[2]:
					weapon = Weapon.SHOCK
			Weapon.LASER:
				if player_stats.unlocked_weapons[2]:
					weapon = Weapon.SHOCK
				else:
					weapon = Weapon.TORPEDO
			Weapon.SHOCK:
				weapon = Weapon.TORPEDO
	elif Input.is_action_just_released("change_weapon_down"):
		match weapon:
			Weapon.TORPEDO:
				if player_stats.unlocked_weapons[2]:
					weapon = Weapon.SHOCK
				elif player_stats.unlocked_weapons[1]:
					weapon = Weapon.LASER
			Weapon.LASER:
				weapon = Weapon.TORPEDO
			Weapon.SHOCK:
				if player_stats.unlocked_weapons[1]:
					weapon = Weapon.LASER
				else:
					weapon = Weapon.TORPEDO


func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	
	if no_power or initial_drop:
		movement.stop(direction, delta)
		return
	elif laser.is_casting:
		energy.use_energy(player_stats.laser_energy)
	
	if Input.is_action_pressed("rotate"):
		var dir: float = movement.turn(get_global_mouse_position(), delta)
		if dir < -1.0 || dir > 1.0:
			dir *= -1
		if dir < -rotation_threshold:
			sprite.texture = right_texture
			energy_amount.position = Vector2(0.0, 1.0)
		elif dir > rotation_threshold:
			sprite.texture = left_texture
			energy_amount.position = Vector2(0.0, -1.0)
		else:
			sprite.texture = forward_texture
			energy_amount.position = Vector2(0.0, 0.0)
	else:
		sprite.texture = forward_texture
		energy_amount.position = Vector2(0.0, 0.0)
	
	if Input.is_action_pressed("thrust"):
		movement.move(direction, delta)
		thrusting.paused = false
		GlobalSignals.on_player_moved(global_position)
	else:
		movement.stop(direction, delta)
		thrusting.paused = true
	
	if global_position.y <= 20:
		global_position.y = 20
		
	if Input.is_action_just_pressed("shoot"):
		match weapon:
			Weapon.TORPEDO:
				if not torpedo_cooldown.on_cooldown:
					torpedo_cooldown.use()
					ProjectileManager.add_friendly_torpedo(global_position, direction, rotation, player_stats.torpedo_damage + player_stats.damage)
					energy.use_energy(player_stats.torpedo_energy)
			Weapon.LASER:
				laser.is_casting = not laser.is_casting
			Weapon.SHOCK:
				if not shock_cooldown.on_cooldown:
					shock_cooldown.use()
					# use shock here
					energy.use_energy(player_stats.shock_energy)
	if Input.is_action_pressed("sonar") and not sonar_cooldown.on_cooldown:
		sonar_cooldown.use()
		sonar.start_sonar()
		GlobalSignals.on_use_sonar()


func _on_hurt_box_hurt(max_health: int, health: int) -> void:
	GlobalSignals.on_player_health_changed(max_health, health)
	camera.apply_shake()


func _on_energy_energy_changed(max_energy: float, energy: float) -> void:
	var new_length := 10.0 * (energy / max_energy) - 8.0
	energy_amount.points[1] = Vector2(new_length, 0.0)


func _on_energy_no_energy() -> void:
	no_power = true
	radius_light.visible = false
	forward_light.visible = false
	#emergency_light.visible = true
	thrusting.paused = true
	flicker.start()
	laser.is_casting = false


func _on_energy_charging() -> void:
	no_power = false
	radius_light.visible = true
	forward_light.visible = true
	emergency_light.visible = false
	thrusting.paused = false
	flicker.stop()


func _on_thrusting_timeout() -> void:
	energy.use_energy(player_stats.thrust_energy)


func _on_flicker_timeout() -> void:
	emergency_light.visible = not emergency_light.visible
	

func _on_heal_player(heal: int) -> void:
	hurt_box.heal(heal)


func _on_hurt_box_healed(max_health: int, health: int) -> void:
	GlobalSignals.on_player_health_changed(max_health, health)


func _on_hurt_box_dead() -> void:
	EntityManager.clear()
	get_tree().change_scene_to_file("res://scenes/basecamp.tscn")
