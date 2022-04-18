tool
extends Spatial

func _ready():
  print("generating collisions shapes")
  var scene = get_tree().get_edited_scene_root()
  
  for child in get_children():
#    var child: Node = $roadBump
    
    if child.get_child_count() > 0: continue

    var staticBody = StaticBody.new()
    child.add_child(staticBody)
    staticBody.owner = scene

    var collisionShape = CollisionShape.new()
    staticBody.add_child(collisionShape)
    collisionShape.owner = scene

    var mesh: Mesh = child.mesh
    collisionShape.shape = mesh.create_trimesh_shape()
    
    
