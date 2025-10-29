extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")
