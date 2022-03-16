tool

extends ViewportContainer

export(String, "police", "ambulance", "garbageTruck", "firetruck", "suv", "race", "tractor", "taxi") var vehicle_type = "police"


func _ready():
  $Viewport/VehicleMesh.set_vehicle(vehicle_type)


func _physics_process(delta):
  if $Viewport/VehicleMesh:
    $Viewport/VehicleMesh.rotate(Vector3.UP, 2.5*delta)
