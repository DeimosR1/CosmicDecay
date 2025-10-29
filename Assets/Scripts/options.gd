extends Control

@onready var full = false

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))

func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_volume_db(0,toggled_on)


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	full = !full
	if full:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")
