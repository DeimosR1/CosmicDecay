extends Node3D

@onready var call = false
@onready var pos = global_position
@onready var anim = $AnimationPlayer
@onready var growl = $growl


func _on_death_zone_area_entered(area: Area3D) -> void:
	if area.name == "Flash":
		await get_tree().create_timer(3).timeout
		anim.play("Dying")
		call = true
		Ceiling.call = call
		await get_tree().create_timer(1).timeout
		queue_free()


func _on_kill_zone_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		anim.play("CeilingAttack")
		await get_tree().create_timer(0.8).timeout
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


func _on_sound_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		growl.play()
