extends Spatial

export(Vector2) var rotateSpeed = Vector2(1, 8)
export(NodePath) var targetPath
var lookTarget = Vector3()

func _ready():
	var x = get_node(targetPath)
	lookTarget = x.get_transform().origin

func _physics_process(delta):
	var rotX = 0
	var rotY = 0
	if Input.is_action_pressed("ui_up"):
		rotY = rotateSpeed.y * delta
	elif Input.is_action_pressed("ui_down"):
		rotY = -rotateSpeed.y * delta
	
	if Input.is_action_pressed("ui_right"):
		rotX = rotateSpeed.x * delta
	elif Input.is_action_pressed("ui_left"):
		rotX = -rotateSpeed.x * delta
	
	rotate_y(rotX)
	$Camera.translate(Vector3(0, rotY, 0))
	$Camera.look_at(lookTarget, Vector3(0, 1, 0))