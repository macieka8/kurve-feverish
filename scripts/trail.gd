extends StaticBody2D

@onready var collider: CollisionPolygon2D = get_child(0)
@onready var mesh_instance: MeshInstance2D = get_child(1)

var positions: Array
var color

func _ready():
	mesh_instance.mesh = create_mesh(positions[0], positions[1], positions[2], positions[3])
	collider.polygon = PackedVector2Array(positions)

func set_color(trail_color: Color):
	color = trail_color
	return self

func set_collider(a: Vector2, b: Vector2, c: Vector2, d: Vector2):
	positions = [a, b, c, d]
	return self

func create_mesh(a: Vector2, b: Vector2, c: Vector2, d: Vector2):
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	st.set_color(color)
	st.set_uv(Vector2(0, 0))
	st.add_vertex(Vector3(a.x, a.y, 0))
	
	st.set_uv(Vector2(1, 0))
	st.add_vertex(Vector3(b.x, b.y, 0))
	
	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(c.x, c.y, 0))
	
	st.set_uv(Vector2(1, 1))
	st.add_vertex(Vector3(d.x, d.y, 0))
	
	st.add_index(0)
	st.add_index(1)
	st.add_index(2)
	
	st.add_index(2)
	st.add_index(1)
	st.add_index(3)
	
	return st.commit()
