extends Spatial

onready var mesh = $VehicleMesh
onready var rigid_body = $RigidBody
onready var ground_ray = $VehicleMesh/RayCast

var offset_mesh_from_sphere = Vector3(0, -1, 0)
export var acceleration = 50
export(int, 0, 7) var player_number
var steering = 21
var turn_speed = 7
var body_tilt = 35

var speed_input = 0
var rotate_input = 0

var last_frame_on_ground = false


func _process(_delta):
  if !player_number and player_number != 0:
    printerr('no player number')
    return

  speed_input = 0
  rotate_input = 0
#  var is_on_ground = ground_ray.is_colliding()

  # Can't steer/accelerate when in the air
#  if !is_on_ground: return

  # Get accelerate/brake input
  speed_input += accelerate_strength()
  speed_input -= brake_strength()
  speed_input *= acceleration

  # Get steering input
  rotate_input += steer_left_strength()
  rotate_input -= steer_right_strength()
  rotate_input *= deg2rad(steering)


func accelerate_strength():
  return Input.get_action_strength("p%s_accelerate" % player_number)


func brake_strength():
  return Input.get_action_strength("p%s_brake" % player_number)


func steer_left_strength():
  return Input.get_action_strength("p%s_steer_left" % player_number)


func steer_right_strength():
  return Input.get_action_strength("p%s_steer_right" % player_number)


func _physics_process(delta):
  # Move the mesh to wherever the RigidBody is
  mesh.transform.origin = rigid_body.transform.origin + offset_mesh_from_sphere

  # Turn the mesh
  var new_basis = mesh.global_transform.basis.rotated(mesh.global_transform.basis.y, rotate_input)
  mesh.global_transform.basis = mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
  mesh.global_transform = mesh.global_transform.orthonormalized()

  # Rotate the wheels (wheels just vanish)
  # mesh.rotate_wheels(rotate_input)
  
  # Tilt body for effect (gets stuck)
#  var t = -rotate_input * rigid_body.linear_velocity.length() / body_tilt
#  mesh.rotation.z = lerp(mesh.rotation.z, t, 10 * delta)
#  mesh.global_transform = mesh.global_transform.orthonormalized()

  # Apply acceleration to the RigidBody
  rigid_body.add_central_force(-mesh.global_transform.basis.z * speed_input)
