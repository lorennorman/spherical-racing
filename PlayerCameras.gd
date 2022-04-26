extends Control

export(Array) var vehicles
var cameras = []

func _ready():
  get_tree().get_root().connect("size_changed", self, "resize_splits")

  if !vehicles:
    print('init default game')

    var game_scene: Node = load("res://Game.tscn").instance()
    
    $HSplitContainer/PlayerOneViewport/Viewport.add_child(game_scene)
    $HSplitContainer/PlayerTwoViewport/Viewport2.world = $HSplitContainer/PlayerOneViewport/Viewport.world
    $HSplitContainer/PlayerOneViewport/Viewport/ChaseCamera.target = game_scene.find_node("Vehicle").find_node("RigidBody")
    $HSplitContainer/PlayerTwoViewport/Viewport2/ChaseCamera2.target = game_scene.find_node("Vehicle2").find_node("RigidBody")

func resize_splits():
  var width = get_viewport_rect().size.x
  $HSplitContainer.split_offset = width/2
