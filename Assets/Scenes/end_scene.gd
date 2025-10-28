extends Control

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
