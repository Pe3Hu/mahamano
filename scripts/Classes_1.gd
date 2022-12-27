extends Node


class Animalia:
	var arr = {}
	var obj = {}
	var flag = {}

	func _init():
		arr.mutant = []
		flag.stop = false
		init_lairs()

	func init_lairs():
		arr.lair = []
		var n = 1
		
		for _i in n:
			var input = {}
			input.animalia = self
			input.position = get_random_position()
			var lair = Classes_1.Lair.new(input)
			arr.lair.append(lair)

	func get_random_position():
		Global.rng.randomize()
		var x = Global.rng.randi_range(Global.num.lair.r, Global.obj.isle.vec.size.x-Global.num.lair.r)
		Global.rng.randomize()
		var y = Global.rng.randi_range(Global.num.lair.r,Global.obj.isle.vec.size.y-Global.num.lair.r)
		return Vector2(x,y)

	func tick(delta_):
		for mutant in arr.mutant:
			mutant.move(delta_)

class Lair:
	var obj = {}
	var vec = {}
	var scene = {}

	func _init(input_):
		obj.animalia = input_.animalia
		vec.position = input_.position
		init_scenes()

	func init_scenes():
		scene.lair = Global.scene.lair.instance()
		Global.node.animalia.add_child(scene.lair)
		scene.lair.position = vec.position
		scene.lair.scale = Vector2(Global.num.lair.d/Global.vec.lair.size.x,Global.num.lair.d/Global.vec.lair.size.y)

	func give_birth_to():
		var input = {}
		input.lair = self
		input.animalia = obj.animalia
		var angle = get_angle_for_birth()
		var r = Global.num.lair.r+Global.num.mutant.r
		input.angle = angle
		input.position = vec.position+Vector2(sin(angle),cos(angle))*r
		var mutant = Classes_1.Mutant.new(input)
		obj.animalia.arr.mutant.append(mutant)

	func get_angle_for_birth():
		var flag_ = false
		var r = Global.num.lair.r+Global.num.mutant.r
		var position = null
		var angle = null
		
		while !flag_:
			Global.rng.randomize()
			angle = Global.rng.randi_range(0, 360)
			position = vec.position+Vector2(sin(angle),cos(angle))*r
			flag_ = Global.obj.isle.check_position_on_board(position)
		
		return angle

class Mutant:
	var num = {}
	var obj = {}
	var vec = {}
	var scene = {}

	func _init(input_):
		obj.animalia = input_.animalia
		init_scenes(input_)
		init_stat(input_)

	func init_scenes(input_):
		scene.mutant = Global.scene.mutant.instance()
		Global.node.animalia.add_child(scene.mutant)
		scene.mutant.position = input_.position
		scene.mutant.scale = Vector2(Global.num.mutant.d/Global.vec.mutant.size.x,Global.num.mutant.d/Global.vec.mutant.size.y)

	func init_stat(input_):
		num.stat = {}
		num.stat.cargo = {}
		num.stat.cargo.current = 0
		num.stat.cargo.max = 100
		num.stat.step = {}
		num.stat.step.max = 10
		num.stat.step.current = num.stat.step.max
		
		num.angle = {}
		num.angle.eye = {}
		num.angle.eye.current = input_.angle
		num.angle.squint = {}
		num.angle.squint.current = 0
		num.angle.squint.max = 360/3
		num.angle.squint.step = 360/36
		print("@",num.angle.eye.current)
		
		vec.eye = Vector2(sin(num.angle.eye.current),cos(num.angle.eye.current))

	func shift_gaze():
		Global.rng.randomize()
		var squint = Global.rng.randi_range(-num.angle.squint.step, num.angle.squint.step)
		print("#",squint)
		num.angle.squint.current += squint
		
		if abs(num.angle.squint.current) > num.angle.squint.max:
			num.angle.squint.current = num.angle.squint.max*sign(num.angle.squint.current)
		
		num.angle.eye.current += num.angle.squint.current
		print("@",num.angle.eye.current)
		vec.eye = Vector2(sin(num.angle.eye.current),cos(num.angle.eye.current))

	func move(delta_):
		shift_gaze()
		var step = vec.eye*num.stat.step.current*delta_
		scene.mutant.position += step
