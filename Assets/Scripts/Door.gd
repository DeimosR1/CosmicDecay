extends Node3D

@onready var is_opened = false
@onready var inside = false
@onready var appear = get_node("/root/Node3D/Collect")
@onready var anim = $Door_Pivot/AnimationPlayer

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("Select") and inside:
		#sound.play()
		is_opened = !is_opened
		_open_door()


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

func _open_door():
	if is_opened:
		anim.play("Take 001")
		await  get_tree().create_timer(1).timeout
		anim.play("Opened")
	else:
		anim.play("Take 002")
		await  get_tree().create_timer(1).timeout
		anim.play('RESET')
