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
	

func add_queue(s):
	queue =s 
	
func new_state(ctx,other: State):
	if other is Attack:
		pass
	if state == other:
		state.update_from_state(other)
		return
	var changed = false
	if other.force_state:
		set_state(ctx, other)
		changed = true
	elif other.can_swap_into(ctx):
		if state.is_over(ctx):
			set_state(ctx, other)
			changed = true
	if changed == false:
		add_queue(other)
			
func set_state(ctx, other: State):
	print(other.get_script())
	state.stop(ctx)
	state = other
	is_animating = false

func is_blocking_movement():
	return state.block_movement


func stop(ctx):
	is_animating= false
	state.stop(ctx)



func update_process(ctx, out):
	state.update_process(ctx, out)
	
func update_physics(ctx, out):
	state.update_physics( ctx, out)
