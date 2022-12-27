extends Node


class Isle:
	var arr = {}
	var vec = {}
	var polygon = {}

	func _init():
		init_polygons()
		init_habitats()

	func init_polygons():
		polygon.grid = []
		var size = Vector2(Global.num.isle.cols,Global.num.isle.rows)
		
		for square in Global.arr.square:
			var vertex = square*size
			polygon.grid.append(vertex)
		
		polygon.position = []
		size = Vector2(Global.num.isle.cols,Global.num.isle.rows)*Global.num.habitat.a
		
		for square in Global.arr.square:
			var vertex = Global.vec.isle.offset+square*size
			polygon.position.append(vertex)

	func init_habitats():
		Global.node.isle.scale = Vector2(Global.num.habitat.a/Global.vec.habitat.size.x,Global.num.habitat.a/Global.vec.habitat.size.y)
		Global.node.isle.position = Global.vec.isle.offset 
		arr.habitat = []
		
		for _i in Global.num.isle.rows:
			arr.habitat.append([])
			
			for _j in Global.num.isle.cols:
				var input = {}
				input.grid = Vector2(_j,_i)
				input.isle = self
				var habitat = Classes_0.Habitat.new(input)
				arr.habitat[_i].append(habitat)
		
		set_habitat_bioms()
		vec.size = Vector2(Global.num.isle.cols,Global.num.isle.rows)
		vec.size *= Global.num.habitat.a

	func set_habitat_bioms():
		for habitats in arr.habitat:
			for habitat in habitats:
				var biom = "forest"
				
				if check_grid_on_borderland(habitat.vec.grid):
					biom = "sand"
				
				habitat.set_biom(biom)

	func get_habitat(position_):
		for habitats in arr.habitat:
			for habitat in habitats:
				if habitat.check_on_habitat(position_):
					return habitat
		
		return null

	func check_grid_on_borderland(grid_):
			return grid_.x == 0 || grid_.x == Global.num.isle.cols-1 || grid_.y == 0 || grid_.y == Global.num.isle.rows-1

	func check_grid_on_board(grid_):
		return Geometry.is_point_in_polygon(grid_, polygon.grid)
		#return grid_.x >= 0 && grid_.x < Global.num.isle.cols && grid_.y >= 0 && grid_.y < Global.num.isle.rows

	func check_position_on_board(position_):
		return Geometry.is_point_in_polygon(position_, polygon.position)
		#return position_.x >= 0 && position_.x < vec.size.x && position_.y >= 0 && position_.y < vec.size.y

class Habitat:
	var word = {}
	var arr = {}
	var vec = {}
	var obj = {}

	func _init(input_):
		vec.grid = input_.grid
		obj.isle = input_.isle
		init_vertexs()

	func init_vertexs():
		var position = vec.grid*Global.num.habitat.a+Global.vec.isle.offset
		arr.vertex = []
		var vertex = position
		arr.vertex.append(vertex)
		vertex = position+Vector2(Global.num.habitat.a,Global.num.habitat.a)
		arr.vertex.append(vertex)

	func set_biom(biom_):
		word.biom = biom_
		var tile = null
		
		match word.biom:
			"forest":
				tile = 0
			"sand":
				tile = 1
		
		Global.node.isle.set_cellv(vec.grid,tile)

	func check_on_habitat(position_):
			return position_.x > arr.vertex.front().x && position_.x < arr.vertex.back().x && position_.y > arr.vertex.front().y && position_.y < arr.vertex.back().y

class Sorter:
	static func sort_ascending(a, b):
		if a.value < b.value:
			return true
		return false

	static func sort_descending(a, b):
		if a.value > b.value:
			return true
		return false
