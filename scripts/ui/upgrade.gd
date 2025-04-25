extends TextureButton

@export var store_names: Array[String] = [""]
@export var tool_tip_strings: Array[String] = [""]
@export var icon_texture: Texture2D
@onready var cost := $HBoxContainer/Cost
@onready var tool_tip := $ToolTip
@onready var tool_tip_label := $ToolTip/Label
var current_upgrade := 0
var player_stats := EntityManager.player_stats


func _ready() -> void:
	reinit()
	$HBoxContainer/Icon.texture = icon_texture


func _physics_process(_delta: float) -> void:
	if current_upgrade < store_names.size():
		disabled = not player_stats.have_enough(store_names[current_upgrade])


func reinit() -> void:
	while not player_stats.store.has(store_names[current_upgrade]):
		current_upgrade += 1
		if current_upgrade >= store_names.size():
			queue_free()
			return
	
	cost.text = str(player_stats.store[store_names[current_upgrade]])
	tool_tip_label.text = tool_tip_strings[current_upgrade]


func _on_mouse_entered() -> void:
	$ButtonHover.play()
	tool_tip.visible = true



func _on_mouse_exited() -> void:
	tool_tip.visible = false



func _on_pressed() -> void:
	$ButtonClick.play()
	var success := player_stats.buy(store_names[current_upgrade])
	if success:
		tool_tip.visible = false
		current_upgrade += 1
		if current_upgrade >= store_names.size():
			queue_free()
		else:
			reinit()
