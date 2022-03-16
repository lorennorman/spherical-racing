extends CanvasLayer

signal new_vehicle_selected

onready var vehicle_container = $CenterContainer/VBoxContainer/VehicleContainer
onready var vehicle_cursor = $Label

var selected_index = 0
var selected_vehicle


func _ready():
  select_vehicle(0)
  

func _input(event):
  if event.is_action_pressed("ui_left"): select_previous_vehicle()
  if event.is_action_pressed("ui_right"): select_next_vehicle()
  if event.is_action_pressed("ui_accept"): accept_current_vehicle_selection()
  
  
func select_vehicle(index):
  selected_index = clamp(index, 0, vehicle_container.get_child_count()-1)
  selected_vehicle = vehicle_container.get_child(selected_index)
  vehicle_cursor.rect_position = selected_vehicle.get_global_transform().get_origin() + Vector2(45, 160)


func select_next_vehicle():
  select_vehicle(selected_index + 1)


func select_previous_vehicle():
  select_vehicle(selected_index - 1)


func accept_current_vehicle_selection():
  var selected_type = vehicle_container.get_child(selected_index).vehicle_type
  emit_signal("new_vehicle_selected", selected_type)
  
