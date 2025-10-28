extends CharacterBody3D

@onready var goal = Vector3.ZERO
@onready var player = get_node("/root/Node3D/Player")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var target = null
@onready var p_goal = Vector3(0,10,0)
@onready var screech = $Chase
@onready var step = $Walk
@onready var anim = $AnimationPlayer

func _ready() -> void:
	goal = get_random_goal()

	navigation_agent_3d.set_target_position(goal)
	navigation_agent_3d.navigation_finished.connect(self.goalReached)
	
func goalReached():
	print ("Goal reached")
	if target == null:
		#print ("Random is in", goal)
		goal = get_random_goal()
		navigation_agent_3d.set_target_position(goal)
	else:
		#print ("Target is in", target.position)
		#print ("Player is in...", player.position)
		#print ("C-524 is in", global_position)
		goal = target.position * 4
		navigation_agent_3d.set_target_position(goal)
		
func get_random_goal()->Vector3:
	var random_position := Vector3.ZERO
	random_position.x = randf_range(-50.0,50.0)
	random_position.z = randf_range(-50.0,50.0)
	random_position.y = 0
	return random_position

func _on_eyesight_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		step.pitch_scale = 0.46
		print ("Player in sight")
		target = body
		screech.play()
	
func _on_eyesight_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		step.pitch_scale = 0.36
		screech.stop()
		print ("Player out of sight")
		target = null
	
#func _process(delta: float) -> void:
	#if target != null:
		#goal = target.position
		#navigation_agent_3d.set_target_position(target.position)
		
func _physics_process(delta: float) -> void:
	var pos = navigation_agent_3d.get_next_path_position()
	var local_destination = pos - global_position
	var direction = local_destination.normalized()
	
	if Ceiling.call:
		step.pitch_scale = 0.46
		print("Called")
		target = player
		Ceiling.call = false
		
	if target != null:
		velocity = direction * 2
		look_at(global_transform.origin + velocity)
		#print (velocity)
	else:
		velocity = direction
		anim.play("C-524Monster/C-524Walk")
		look_at(global_transform.origin + velocity)
	move_and_slide()


func _on_deathzone_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		anim.play("C-524Monster/C-524Kill")
		velocity = velocity * 0
		await get_tree().create_timer(3).timeout
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
