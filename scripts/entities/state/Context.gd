class_name Context extends RefCounted

var owner : Entity
var delta 
var direction_x
var move_direction = Vector2(0,0)

func _init(owner, delta):
	self.owner = owner
	self.delta = delta
