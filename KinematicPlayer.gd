extends KinematicBody

func _ready():
	cam = get_node(CameraPath).get_child(0)

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) and shootCooldown <= 0:
		shoot_bubble()
		shootCooldown = ShootCooldown
	elif shootCooldown > 0:
		shootCooldown -= delta

func _physics_process(delta):
	movement(delta)


### Shooting Bubbles
onready var BUBBLE = preload("res://Prefabs/Bubble.tscn")
export(Vector3) var ShootOffset = Vector2(.5, 1.7)
export(float) var ShootCooldown = 1
export(Vector2) var ShootForce = Vector2(.05, .12)
var shootCooldown = 0

func shoot_bubble():
	var newBubble = BUBBLE.instance()
	newBubble.transform.origin = get_global_transform().origin + Vector3(0, ShootOffset.y, 0) + (get_global_transform().basis.z * ShootOffset.x)
	newBubble.apply_impulse(newBubble.transform.origin, get_global_transform().basis.z * rand_range(ShootForce.x, ShootForce.y))
	get_parent().add_child(newBubble)

### Movement
export(float) var moveSpeed = 200
export(NodePath) var CameraPath

var cam
const GRAVITY = -9.8 * 3
var onGround = false

const MAX_SLOPE_ANGLE = 35

const MAX_STAIR_SLOPE = 20
const STAIR_JUMP_HEIGHT = 6

var velocity = Vector3()
var direction = Vector3()

func movement(delta):
	direction = Vector3()
	var aim = cam.get_global_transform().basis
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	direction.y = 0
	direction = direction.normalized() * moveSpeed * delta

	velocity.x = direction.x
	velocity.z = direction.z

	if (is_on_floor()):
		onGround = true
		var n = $RayCast.get_collision_normal()
		var floor_angle = rad2deg(acos(n.dot(Vector3(0, 1, 0))))
		if floor_angle > MAX_SLOPE_ANGLE:
			velocity.y += GRAVITY * delta
		
	else:
		if !$RayCast.is_colliding():
			onGround = false
		velocity.y += GRAVITY * delta

	if (onGround and !is_on_floor()):
		move_and_collide(Vector3(0, -1, 0))
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if direction.normalized() != Vector3(0, 0, 0):
		look_at(direction.normalized() * -50, Vector3(0, 1, 0))


func _on_PickupArea_body_shape_entered(body_id, body, body_shape, area_shape):
	body.get_parent().queue_free()
	var level = get_node("/root/").get_child(0)
	level.CoinCounter.modify(1) 
