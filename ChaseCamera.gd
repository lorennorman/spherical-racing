extends Camera

var pivot: Position3D
var target: RigidBody = null setget set_target
func set_target(new_target):
  target = new_target
  pivot = target.get_parent().find_node("ChasePivot")


func _physics_process(_delta):
  if pivot:
    global_transform = global_transform.interpolate_with(pivot.global_transform, 20*_delta)

