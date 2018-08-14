extends Spatial

onready var CoinCounter = get_node("UIOverlay/CoinCounter")

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		quit()

func win():
	print("win level!")

func _falldeath(body_id, body, body_shape, area_shape):
	print(body.name)
	restart()

func quit():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().quit()

func restart():
	get_tree().reload_current_scene()