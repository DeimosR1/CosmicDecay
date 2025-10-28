extends CharacterBody3D


const SPEED = 6.0
const JUMP_VELOCITY = 4.5
var Velocity = SPEED
@onready var _cam = $Camera3D
@onready var sprint = true
@onready var sprint_anim = $Sprint_bar/AnimationPlayer
@onready var sound = $Walk
#@onready var _body = $body


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sound.stop()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, _cam.rotation.y).normalized()
	#_body.rotation.y = _cam.rotation.y
	if direction:
		velocity.x = direction.x * Velocity
		velocity.z = direction.z * Velocity
	else:
		velocity.x = move_toward(velocity.x, 0, Velocity)
		velocity.z = move_toward(velocity.z, 0, Velocity)
		sound.play()
	if Input.is_action_just_pressed("Sprint") and is_on_floor() and sprint:
		sound.pitch_scale = 1.4
		Velocity = SPEED * 1.5
		sprint_anim.play("Down")
		await get_tree().create_timer(3).timeout
		Velocity = SPEED * 1
		sprint_anim.play("Up")
		sprint = false
		await get_tree().create_timer(3).timeout
		#sound.pitch_scale(1.2)
		sprint_anim.play("RESET")
		sprint = true
	elif sprint == false:
		Velocity = SPEED * 1
		sound.pitch_scale = 1.2
	move_and_slide()


	

	
	
