extends Spatial

var speed = 1.6

func _physics_process(delta):
	translation = $"../RigidBody".translation + Vector3(0, -1, 0)


	if Input.is_action_pressed("ui_left"):
		rotation = rotation + Vector3(0, speed, 0)*delta

	if Input.is_action_pressed("ui_right"):
		rotation = rotation + Vector3(0, -speed, 0)*delta
