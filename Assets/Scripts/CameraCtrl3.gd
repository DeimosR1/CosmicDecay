extends Camera3D


@export var mouse_sensitivity := 0.5
@onready var fl_light = $Light
@onready var _on = false
@onready var flash = $Light/Flash/CollisionShape3D
@onready var sound = $Light/Click
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -30.0, 30.0)
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Left_click"):
		sound.play()
		_on = !_on
	
	if _on:
		fl_light.show()
		flash.disabled = false
	else:
		fl_light.hide()
		flash.disabled = true
	
		
