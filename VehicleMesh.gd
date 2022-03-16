tool
extends Spatial

var vehicle setget set_vehicle


func _ready():
  if !vehicle: set_vehicle("police")

func set_vehicle(vehicle_type):
  var vehicle_scene = load("res://models/%s.glb" % vehicle_type)
  if !vehicle_scene:
    print("No vehicle found: %s" % vehicle_type)
    return

  if vehicle:
    remove_child(vehicle)

  vehicle = vehicle_scene.instance()
  add_child(vehicle)


# TODO: none of these special effects actually work...


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
