extends Area3D

var velocity = 0

var force = 0

#var height = position.y
var height = 0

#var target_height = position.y + 80
var target_height = position.y + 5

#var k = 0.015

#var d = 0.03

func water_update(spring_constang, dampening):
	height = position.y
	
	var x = height - target_height
	
	var loss = -dampening * velocity
	
	force  = - spring_constang * x + loss
	
	velocity += force
	
	position.y += velocity
	
#func _physics_process(delta):
#	water_update(k, d)
	
	
func initialize(x_pos):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_pos
	
