extends Node


func _ready():
	#datas.sort_custom(Classes_0.Sorter, "sort_ascending")
	Global.obj.isle = Classes_0.Isle.new()
	Global.obj.animalia = Classes_1.Animalia.new()
	Global.node.timebar.rect_scale = Vector2(Global.num.border.gap/Global.node.timebar.rect_size.x,Global.num.border.gap/Global.node.timebar.rect_size.y)

func _input(event):
	if event is InputEventMouseButton:
		if Global.flag.click:
			if Global.obj.keys().has("animalia"):
				var mouse = get_viewport().get_mouse_position()
			Global.flag.click = !Global.flag.click
		else:
			Global.flag.click = !Global.flag.click
	
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_S:
			pass

func _process(delta):
	if Global.obj.keys().has("animalia"):
		if !Global.obj.animalia.flag.stop:
			Global.obj.animalia.tick(delta)
	print(Global.obj.animalia.arr.mutant.size()," FPS " + String(Engine.get_frames_per_second()))

func _on_Timer_timeout():
	if Global.obj.keys().has("animalia"):
		if !Global.obj.animalia.flag.stop:
			Global.node.timebar.value += 1
			
			if Global.num.primary_key.mutant < Global.obj.animalia.arr.mutant_pool.size():
				#for _i in 100:
				for lair in Global.obj.animalia.arr.lair:
					lair.give_birth_to()
			
			if Global.node.timebar.value >= Global.node.timebar.max_value:
				Global.node.timebar.value -= Global.node.timebar.max_value
				
