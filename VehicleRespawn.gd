extends RigidBody

export(Vector3) var spawn_point = Vector3(91, 1, 360)

func _integrate_forces(state):
  if state.transform.origin.y < -10:
    state.transform.origin = spawn_point
    state.linear_velocity = Vector3.ZERO
    state.angular_velocity = Vector3.ZERO
