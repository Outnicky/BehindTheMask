class_name VisualOutput extends RefCounted


var animation_normal :AnimationData
var animation_overlay : AnimationData
var sfx_name : String
var end_state_with_animation_end = false

class AnimationData:
	var state: State
	var priority : int
	var on_finish
	var started = false
	
	func _init(state, priority, on_finish = null):
		self.state = state 
		self.priority = priority
		self.on_finish = on_finish
