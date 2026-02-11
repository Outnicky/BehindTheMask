class_name StateMachine extends RefCounted

var state : State
var entity : Entity
var queue : State
var is_animating = false
var animation_elapsed = 0
func _init(e, s):
	entity = e
	state = s
	if state:
		state.attach(entity)
	

func add_queue(s):
	queue =s 
	
func new_state(s):
	s.attach(entity)
	if state == s:
		state.dir = s.dir
		return
	if !state.can_swap_into():
		add_queue(s)
		return
	if state.is_over():
		set_state(s) 
		return


func set_state(other: State):
	if state:
		state.stop()
	state = other
	is_animating = false
	#print("new state: ", state)
#	state.start()
	#entity.primary_state.on_state_change(self)

func is_blocking_movement():
	if not state: 
		return false
	return state.block_movement

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
	if not state: 
		return
	state.update_physics( delta)

	pass
