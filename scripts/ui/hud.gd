extends CanvasLayer

@export var show_fps := true
@onready var fps := $FPS


func _ready() -> void:
	fps.visible = show_fps


func _process(_delta: float) -> void:
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
