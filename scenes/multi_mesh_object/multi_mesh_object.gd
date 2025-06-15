extends Node

@export var type: MultiMeshRenderer.Type
@export var node_reference: Node2D


func update():
	MultiMeshRenderer.set_mesh_transform_for(
		Transform2D(node_reference.rotation, node_reference.position), type
	)
