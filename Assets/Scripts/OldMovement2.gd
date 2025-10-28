extends CharacterBody3D


@onready var player = get_tree().get_nodes_in_group("Player")
@onready var _pursuit: bool
@onready var _hunting: bool
@onready var _looking: bool
@onready var _instinct: int = 0
var _is_indetector: bool
@export var _called: bool

@onready var _locator: NavigationAgent3D = $NavigationAgent3D
#This next variable is for the limits of the Map.
#Might be hard for random Generation but Try and find a way.
@onready var _randpos = Vector3(randf_range(5,10), position.y, randf_range(5,20))
@onready var _detector = $Eyesight
var _lastseen

@onready var animation = $"C-524_DAE/AnimationPlayer"

@onready var _walkspeed = 3.0
@onready var _huntspeed = 7.0
@onready var _velocity = _huntspeed
@onready var _consume = false
@onready var jumpscare

@onready var _timer = 60.0

func _ready() -> void:
	_wandering()
	
func _physics_process(delta: float) -> void:
	
	if _hunting:
		_chasing()
		_velocity = _huntspeed
	else:
		_velocity = _walkspeed
		_wandering()
	move_and_slide()
	
func _chasing():
	look_at(player.position)
	_locator.set_target_position(player.global_position)
	var destination = _locator.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()

func _wandering():
	look_at(global_transform.origin + velocity)
	_locator.set_target_position(_randpos)
	if (abs(_randpos.x - global_position.x) <= 5 and abs(_randpos.z - global_position.z) <= 5) or _timer <= 0:
		_randpos = Vector3(randf_range(player.global_position.x-40, player.global_position.x+40), position.y, randf_range(player.global_position.z-40, player.global_position.z+40))
		clamp(_randpos.x, 5, 10)
		clamp(_randpos.z, 5, 10)
		var destination = _locator.get_next_path_position()
		var local_destination = destination - global_position
		var direction = local_destination.normalized()
		_timer = 60.0


func _on_eyesight_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		_hunting = true


func _on_eyesight_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		_lastseen = body.global_position
		_randpos = _lastseen
		_hunting = false
