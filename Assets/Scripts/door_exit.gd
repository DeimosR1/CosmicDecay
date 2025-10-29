extends Node3D

@onready var inside = false
@onready var appear = $Collect
@onready var nokeys = $NoKeys

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("Select") and inside and Key.key:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://Assets/Scenes/end_scene.tscn")
	elif Input.is_action_just_released("Select") and inside:
		nokeys.show()
		appear.hide()

func _on_open_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		appear.show()
		inside = true
		print ("inside")


func _on_open_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		appear.hide()
		inside = false
		print ("inside")
		nokeys.hide()
