tool
extends GridMap

export(Vector3) var offset = Vector3(0,0,0)

func _ready():
  var transform = self.mesh_library.get_item_mesh_transform(0)
  transform.origin = offset
  for item_id in self.mesh_library.get_item_list():
    self.mesh_library.set_item_mesh_transform(item_id, transform)
