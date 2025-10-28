extends CharacterBody3D


@onready var player = get_tree().get_nodes_in_group("Player")
@onready var _pursuit: bool
@onready var _hunting: bool
@onready var _looking: bool
@onready var _instinct: int = 0
var _is_indetector: bool
@export var _called: bool

@onready var _locator = $NavigationAgent3D
#This next variable is for the limits of the Map.
#Might be hard for random Generation but Try and find a way.
@onready var _randpos = Vector3(randf_range(5,10), position.y, randf_range(5,10))
@onready var _detector = $Eyesight
var _lastseen

@onready var animation = $"C-524_DAE/AnimationPlayer"

@onready var _walkspeed = 3.0
@onready var _huntspeed = 7.0
@onready var _velocity = _huntspeed
@onready var _consume = false
@onready var jumpscare

@onready var _timer = 60.0

func _physics_process(delta: float) -> void:
	
	if _hunting:
		_chasing()
		_velocity = _huntspeed
	else:
		_velocity = _walkspeed
		_wandering(delta)
	move_and_slide()
	
func _chasing():
	look_at(player.position)
	_locator.target_position = player.global_position

func _wandering(delta):
	look_at(global_transform.origin + velocity)
	_locator.target_position = _randpos
	if (abs(_randpos.x - global_position.x) <= 5 and abs(_randpos.z - global_position.z) <= 5) or _timer <= 0:
		_randpos = Vector3(randf_range(player.global_position.x-40, player.global_position.x+40), position.y, randf_range(player.global_position.z-40, player.global_position.z+40))
		clamp(_randpos.x, 5, 10)
		clamp(_randpos.z, 5, 10)
		_timer = 60.0
	_timer-= delta


func _on_eyesight_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		_hunting = true


func _on_eyesight_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		_lastseen = body.global_position
		_randpos = _lastseen
		_hunting = false
