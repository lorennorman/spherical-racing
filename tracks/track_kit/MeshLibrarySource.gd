tool
extends Spatial

export var mesh_library: MeshLibrary

var preview_viewport: Viewport
var preview_camera: Camera

export var show_all_meshes = false setget do_show_all_meshes
func do_show_all_meshes(__ = null):
  for child in get_children():
    if child.is_class("Viewport"): continue
    child.visible = true


export var hide_all_meshes = false setget do_hide_all_meshes
func do_hide_all_meshes(__ = null):
  for child in get_children():
    if child.is_class("Viewport"): continue
    child.visible = false


export var bake_mesh_library = false setget do_bake_mesh_library
func do_bake_mesh_library(__ = null):
  preview_viewport = $Viewport
  preview_camera = $Viewport/PreviewCamera

  if !mesh_library:
    print("No MeshLibrary selected")
    return

  print("Baking MeshLibrary...")
  mesh_library.clear()
  
  do_hide_all_meshes()

  yield(get_tree(), "idle_frame")

  for child in get_children():
    if child.is_class("Viewport"): continue

    yield(add_to_mesh_library(mesh_library, child), "completed")
  
  if ResourceSaver.save(mesh_library.resource_path, mesh_library) != OK:
    printerr("Error saving to %s" % mesh_library.resource_path)
  else:
    print("Baked %s meshes and saved resource to: %s" % [mesh_library.get_item_list().size(), mesh_library.resource_path])
  
  
func add_to_mesh_library(library: MeshLibrary, instance: MeshInstance):
  var id = library.get_last_unused_item_id()
  library.create_item(id)
  library.set_item_name(id, instance.name)
  
  # Mesh selection and offset
  library.set_item_mesh(id, instance.mesh)
  var mesh_transform = instance.mesh_transform if (instance.get("mesh_transform") != null) else Transform.IDENTITY
  library.set_item_mesh_transform(id, mesh_transform)
  
  # Collisions shape generation
  var collision_shape = instance.mesh.create_trimesh_shape()
  library.set_item_shapes(id, [collision_shape, mesh_transform])

  # Preview image generation
  instance.visible = true
  # TODO: zoom/center camera to instance extents (camera.look_at(instance))

  yield(get_tree(), "idle_frame")

  var preview_image := preview_viewport.get_texture().get_data()
  var preview_texture := ImageTexture.new()
  preview_texture.create_from_image(preview_image)
  library.set_item_preview(id, preview_texture)

  instance.visible = false

