class_name StateMachine extends RefCounted

var state : State
var entity : Entity
var queue : State
var default_state
var is_animating = false
var animation_elapsed = 0

func _init(e, s):
	entity = e
	state = s
	state.attach(entity)
	

func add_queue(s):
	queue =s 
	
func new_state(other: State):
	other.attach(entity)
	state.update_from_state(other)
	if state == other:
		return
	var changed = false
	if other.force_state:
		set_state(other)
		changed = true
	elif other.can_swap_into():
		if state.is_over():
			set_state(other)
			changed = true
	if changed == false:
		add_queue(other)
			
func set_state(other: State):
	state.stop()
	state = other
	state.has_started = false
	is_animating = false

func is_blocking_movement():
	return state.block_movement


func stop():
	is_animating= false
	state.stop()

func blend_animation(other: StateMachine):
	if other.state.block_animation:
		other.animate()
	else:
		animate()
#	state.blend(other.state)
	

func animate():
	if is_animating:
		return
	else:
		state.animate()
		is_animating = true
		
func update( delta: float):
	if not state: 
		return
	state.update(delta)
	
	#if state.is_over():
	#	set_state(null)
	#	return

func update_physics(delta: float):
	state.update_physics( delta)

	pass
