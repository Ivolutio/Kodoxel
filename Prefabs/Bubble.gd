extends RigidBody

export(Vector2) var MaxLifetime = Vector2(1.2, 1.7)
export(float) var SlowDown = .3
var maxLife
var lifetime

func _ready():
	lifetime = 0
	maxLife = rand_range(MaxLifetime.x, MaxLifetime.y)

func _process(delta):
	lifetime += delta
	if lifetime > maxLife:
		pop()
	
	if linear_velocity.x > 1:
		apply_impulse(get_global_transform().origin, get_global_transform().basis.z * (SlowDown * delta))

func pop():
	queue_free()