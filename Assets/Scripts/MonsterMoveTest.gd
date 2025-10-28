extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var _turn = false

func _ready() -> void:
	_position()
func _position() -> void:
	var random_position := Vector3.ZERO
	random_position.x = randf_range(-10.0,10.0)
	random_position.z = randf_range(-10.0,10.0)
	random_position.y = 0
	navigation_agent_3d.set_target_position(random_position)
	look_at(global_transform.origin + velocity)
	await get_tree().create_timer(5).timeout
	_turn = true
	
func _physics_process(delta: float) -> void:
	if _turn:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destination = destination - global_position
		var direction = local_destination.normalized()
		velocity = direction * 3
		_turn = false
		_position()
	move_and_slide()
