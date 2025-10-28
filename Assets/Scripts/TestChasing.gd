extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player = get_node("/root/Node3D/Player")
@onready var _chaseturn = false
@onready var _chasing = true

func _ready() -> void:
	_chaseposition()

func _chaseposition() -> void:
	var player_position := Vector3.ZERO
	player_position.x = player.position.x
	player_position.z = player.position.z
	player_position.y = 0
	navigation_agent_3d.set_target_position(player_position)
	look_at(player_position)
	await get_tree().create_timer(2).timeout
	_chaseturn = true
	print("LocatePlayer", player_position)
	
	
func _physics_process(delta: float) -> void:
	if _chaseturn:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destination = destination - global_position
		var direction = local_destination.normalized()
		velocity = direction * 6
		if _chasing:
			_chaseposition()
			
		print("velocity chase",velocity)
	_chaseturn = false
	move_and_slide()
