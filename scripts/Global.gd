extends Node


var rng = RandomNumberGenerator.new()
var dict = {}
var num = {}
var arr = {}
var obj = {}
var node = {}
var flag = {}
var vec = {}
var color = {}
var scene = {}
var current = {}

func init_num():
	init_primary_key()
	
	num.isle = {}
	num.isle.n = 32
	num.isle.rows = num.isle.n
	num.isle.cols = num.isle.n*2
	num.isle.l = min(dict.window_size.width,dict.window_size.height)*0.9
	
	num.habitat = {}
	num.habitat.a = num.isle.l/num.isle.n
	
	num.lair = {}
	num.lair.r = num.habitat.a
	num.lair.d = num.lair.r*2
	
	num.mutant = {}
	num.mutant.r = num.lair.r/4
	num.mutant.d = num.mutant.r*2
	
	num.border = {}
	num.border.gap = min(dict.window_size.width,dict.window_size.height)*0.05

func init_primary_key():
	num.primary_key = {}
	num.primary_key.mutant = 0

func init_dict():
	init_window_size()

func init_window_size():
	dict.window_size = {}
	dict.window_size.width = ProjectSettings.get_setting("display/window/size/width")
	dict.window_size.height = ProjectSettings.get_setting("display/window/size/height")
	dict.window_size.center = Vector2(dict.window_size.width/2, dict.window_size.height/2)
	
	OS.set_current_screen(1)

func init_arr():
	arr.square = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]

func init_scene():
	scene.lair = preload("res://scenes/Lair.tscn")
	scene.mutant = preload("res://scenes/Mutant.tscn")

func init_node():
	node.isle = get_node("/root/Game/Isle") 
	node.timebar = get_node("/root/Game/TimeBar") 
	node.animalia = get_node("/root/Game/Animalia") 

func init_flag():
	flag.click = false

func init_vec():
	vec.isle = {}
	vec.isle.offset = Vector2(num.border.gap, num.border.gap)
	
	vec.habitat = {}
	vec.habitat.size = Vector2(60,60)
	
	vec.mutant = {}
	vec.mutant.size = Vector2(64,64)
	
	vec.lair = {}
	vec.lair.size = Vector2(64,64)

func init_color():
	color.cord = {
		"fast": Color.from_hsv(120.0/360.0,0.5,1),
		"standart": Color.from_hsv(240.0/360,0.5,1),
		"slow": Color.from_hsv(360.0/360.0,0.5,1)
	}

func init_font():
	var names = ["ALBA____","ELEPHNT","Marlboro","Sabandija"]
	dict.font = {}
	
	for name in names:
		dict.font[name] = DynamicFont.new()
		var path = "res://assets/fonts/"+name+".TTF"
		dict.font[name].font_data = load(path)
		dict.font[name].size = 10

func _ready():
	init_dict()
	init_arr()
	init_num()
	init_node()
	init_scene()
	init_flag()
	init_vec()
	init_color()
	init_font()

func get_random_element(arr_):
	rng.randomize()
	var index_r = rng.randi_range(0, arr_.size()-1)
	return arr_[index_r]
