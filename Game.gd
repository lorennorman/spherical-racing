extends Spatial

enum {PAUSED, PLAYING}
var state = PLAYING

func _input(event):
  if event.is_action_pressed("ui_cancel"):
    toggle_paused()


func toggle_paused():
  state = (PAUSED if state == PLAYING else PLAYING)

  for child in $PauseMenu.get_children():
    child.visible = (state == PAUSED)

  get_tree().paused = (state == PAUSED)


func _new_vehicle_selected(vehicle_type):
  $World/Vehicle/VehicleMesh.vehicle = vehicle_type
  toggle_paused()
