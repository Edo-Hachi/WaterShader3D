extends Node3D

@export var k = 0.015
@export var d = 0.03
#@export var spread = 0.0002
@export var spread = 0.0004	#Wave Trance Param

#spring allay
var springs = []
#var passes = 8
var passes = 16	#振幅計算数 多いほど遠くに派生する


#distance in mater each spring
@export var distance_between_springs = 3	#波の頂点間隔
@export var spring_number = 16	#波の頂点数

@onready var water_spring = preload("res://water_spring.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in get_children():
		#springs.append(i)
		#i.initialize()
	
	for i in range(spring_number):
		var x_pos = distance_between_springs * i
		var ws = water_spring.instantiate()
		
		add_child(ws)
		springs.append(ws)
		ws.initialize(x_pos)
	
#	splash(2, 1.5)
	splash(spring_number / 2, 0.8) #波の発生位置（配列番号）、発生ベクトル　　

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for i in springs:
		i.water_update(k, d)
		
	var left_deltas = []
	var right_deltas = []
	
	for i in range(springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		
	#-------------
	for j in range(passes):
		
		for i in range(springs.size()):
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			
			if i < springs.size()-1:
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
			
func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
		
		
