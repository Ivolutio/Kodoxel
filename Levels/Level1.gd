extends Spatial

func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	restart()

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		quit()

func quit():
	get_tree().quit()

func restart():
	get_tree().reload_current_scene()