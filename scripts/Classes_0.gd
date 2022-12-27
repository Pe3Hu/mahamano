extends Node


class Isle:
	var arr = {}
	var vec = {}

	func _init():
		init_habitats()

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

	func check_grid_on_borderland(grid_):
			return grid_.x == 0 || grid_.x == Global.num.isle.cols-1 || grid_.y == 0 || grid_.y == Global.num.isle.rows-1

	func check_grid_on_board(grid_):
			return grid_.x >= 0 && grid_.x < Global.num.isle.cols && grid_.y >= 0 && grid_.y < Global.num.isle.rows

	func check_position_on_board(position_):
			return position_.x >= 0 && position_.x < vec.size.x && position_.y >= 0 && position_.y < vec.size.y

class Habitat:
	var word = {}
	var vec = {}
	var obj = {}

	func _init(input_):
		vec.grid = input_.grid
		#vec.position = vec.grid*Global.num.habitat.a+Global.vec.isle.offset
		obj.isle = input_.isle

	func set_biom(biom_):
		word.biom = biom_
		var tile = null
		
		match word.biom:
			"forest":
				tile = 0
			"sand":
				tile = 1
		
		Global.node.isle.set_cell(vec.grid.x,vec.grid.y,tile)

class Sorter:
	static func sort_ascending(a, b):
		if a.value < b.value:
			return true
		return false

	static func sort_descending(a, b):
		if a.value > b.value:
			return true
		return false
