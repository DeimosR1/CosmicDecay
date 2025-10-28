extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player = get_node("/root/Node3D/Player")
@onready var _wanderturn = false
@onready var _chaseturn = false
@onready var _chasing = false
@onready var _wander = true

func _ready() -> void:
	_check_state()
		
func _wanderposition() -> void:
	_chaseturn = false
	var random_position := Vector3.ZERO
	random_position.x = randf_range(-10.0,10.0)
	random_position.z = randf_range(-10.0,10.0)
	random_position.y = 0
	navigation_agent_3d.set_target_position(random_position)
	look_at(global_transform.origin + velocity)
	await get_tree().create_timer(2).timeout
	_wanderturn = true
	print("RandomPoint",random_position)

func _chaseposition() -> void:
	_wanderturn = false
	var player_position := Vector3.ZERO
	player_position.x = player.position.x
	player_position.z = player.position.z
	player_position.y = 0
	navigation_agent_3d.set_target_position(player_position)
	look_at(global_transform.origin + velocity)
	await get_tree().create_timer(2).timeout
	_chaseturn = true
	print("LocatePlayer", player_position)
	
	
func _physics_process(delta: float) -> void:
	if _wanderturn:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destination = destination - global_position
		var direction = local_destination.normalized()
		velocity = direction * 3
		if _wander:
			_wanderposition()
		else:
			_check_state()
		print("velocity wander",velocity)
		
	elif _chaseturn:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destination = destination - global_position
		var direction = local_destination.normalized()
		velocity = direction * 6
		if _chasing:
			_chaseposition()
		else:
			_check_state()
		print("velocity chase",velocity)
	move_and_slide()

func _check_state():
	
	if _chasing:
		_chaseposition()
	else:
		_wanderposition()


func _on_eyesight_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		_wander = false
		_chasing = true
		print(_chasing)


func _on_eyesight_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(5).timeout
		_wander = true
		_chasing = false
		print(_chasing)
