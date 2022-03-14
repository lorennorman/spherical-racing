extends Spatial

onready var ground_ray = $RayCast
onready var mesh = $PoliceCar
onready var right_wheel = $PoliceCar/tmpParent/police/wheel_frontRight
onready var left_wheel = $PoliceCar/tmpParent/police/wheel_frontLeft
var is_on_ground = false


# TODO: none of these special effects actually work...

func _process(delta):
  is_on_ground = ground_ray.is_colliding()
#  var n = ground_ray.get_collision_normal()
#  var xform = align_with_y(mesh.global_transform, n.normalized())
#  mesh.global_transform = mesh.global_transform.interpolate_with(xform, 10 * delta)

#
#func align_with_y(xform, new_y):
#  xform.basis.y = new_y
#  xform.basis.x = -xform.basis.z.cross(new_y)
#  xform.basis = xform.basis.orthonormalized()
#  return xform


# rotate wheels for effect
#func rotate_wheels(radians):
#  right_wheel.rotation.y = radians
#  left_wheel.rotation.y = radians
