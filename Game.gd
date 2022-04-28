extends Spatial

enum {PAUSED, PLAYING}
var state = PLAYING


func add_player_action(player_number, action_name, events):
  var player_action = "p%s_%s" % [player_number, action_name]
  InputMap.add_action(player_action)
  
  for event in events:
    if !event: continue # allow sparse event lists, prettier dsl

    var input_event
    if event.has("device"):
      if event.has("axis"):
        input_event = InputEventJoypadMotion.new()
        input_event.axis = event["axis"]
      else:
        printerr("Bad input: %s %s %s" % [player_number, action_name, event])
      input_event.device = event["device"]
    
    elif event.has("scancode"):
      input_event = InputEventKey.new()
      input_event.scancode = event["scancode"]
    else:
      printerr("Bad input: %s %s %s" % [player_number, action_name, event])

    if input_event:
      InputMap.action_add_event(player_action, input_event)

func _ready():
  for i in range(0,7):
    var p1 = i == 0
    var p2 = i == 1

    add_player_action(i, "accelerate", [
      { "device": i, "axis": -JOY_AXIS_0 },
      { "scancode": KEY_W } if p1 else null,
      { "scancode": KEY_UP } if p2 else null, 
    ])

    add_player_action(i, "brake", [
      { "device": i, "axis": JOY_AXIS_0 },
      { "scancode": KEY_S } if p1 else null,
      { "scancode": KEY_DOWN } if p2 else null,
     ])

    add_player_action(i, "steer_left", [
      { "device": i, "axis": JOY_AXIS_1 },
      { "scancode": KEY_A } if p1 else null,
      { "scancode": KEY_LEFT } if p2 else null,
     ])

    add_player_action(i, "steer_right", [
      { "device": i, "axis": -JOY_AXIS_1 },
      { "scancode": KEY_D } if p1 else null,
      { "scancode": KEY_RIGHT } if p2 else null,
     ])

    add_player_action(i, "offensive", [
#      { "device": i, "axis": -JOY_AXIS_1 },
      { "scancode": KEY_E } if p1 else null,
      { "scancode": KEY_PERIOD } if p2 else null,
     ])

    add_player_action(i, "defensive", [
#      { "device": i, "axis": -JOY_AXIS_1 },
      { "scancode": KEY_Q } if p1 else null,
      { "scancode": KEY_SLASH } if p2 else null,
     ])  

    add_player_action(i, "boost", [
#      { "device": i, "axis": -JOY_AXIS_1 },
      { "scancode": KEY_F } if p1 else null,
      { "scancode": KEY_COMMA } if p2 else null,
     ])

    add_player_action(i, "distract", [
#      { "device": i, "axis": -JOY_AXIS_1 },
      { "scancode": KEY_R } if p1 else null,
      { "scancode": KEY_M } if p2 else null,
     ])


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
