class_name A extends RefCounted

var state : State
var queue : State


func _init(s):
	state = s
	

func add_queue(s):
	queue =s 

			
func set_state(ctx, other: State):
	state.stop(ctx)
	state = other

func is_blocking_movement():
	return state.block_movement


func stop(ctx):
	state.stop(ctx)

	


func update_process(ctx, out):
	state.update_process(ctx, out)
	
func update_physics(ctx, out):
	state.update_physics( ctx, out)
