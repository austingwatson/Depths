extends CanvasLayer

@export var show_fps := true
@onready var fps := $FPS


func _ready() -> void:
	fps.visible = show_fps
	GlobalSignals.show_depth_tooltip.connect(_on_show_depth_tooltip)


func _process(_delta: float) -> void:
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	

func _on_show_depth_tooltip() -> void:
	var depth_crush_tooltip := $DepthCrushTooltip
	depth_crush_tooltip.visible = true
	depth_crush_tooltip.show_tooltip()
