extends Control

@onready var Transition = $Transition
@onready var anim = $Transition/AnimationPlayer

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/floor_1_demo.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/credits.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/options.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
