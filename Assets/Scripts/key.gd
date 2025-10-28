extends MeshInstance3D

@onready var inside = false
@onready var key = false
@onready var appear = $Collect
@onready var sound = $Collect/Collectsound

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		appear.show()
		inside = true
		print (inside)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("Select") and inside:
		sound.play()
		Key.key = true
		queue_free()
		print ("Collect")


func _on_area_3d_body_exited(body: Node3D) -> void:
	appear.hide()
	inside = false
