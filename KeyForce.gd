extends RigidBody

onready var police = $"../police"

export var speed = 800

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		add_force(-police.get_global_transform().basis.z*speed*delta, Vector3(0,1,0))

	if Input.is_action_pressed("ui_down"):
		add_force(police.get_global_transform().basis.z*speed*delta, Vector3(0,1,0))
