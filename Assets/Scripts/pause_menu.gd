extends CanvasLayer

@onready var pausemenu = $Menu
var pause = false
# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		PauseMenu()
		
		
func PauseMenu():
	
	if pause:
		pausemenu.hide()
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#Engine.time_scale = 1
		
	else:
		pausemenu.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		#Engine.time_scale = 0
	
	pause = !pause


func _on_quit_pressed() -> void:
	pause = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")


func _on_resume_pressed() -> void:
	PauseMenu()
