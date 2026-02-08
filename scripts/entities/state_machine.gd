class_name StateMachine extends Node

var primary_state : State
var secondary_states : Array[State] = []
var queue: Array[State] = []
var entity : Entity

func _init(e):
	entity = e
	primary_state = Idle.new(entity)
	

func set_new_state(state):
	entity.idle = false
	if primary_state == state:
		primary_state.dir = state.dir
		return false
	if !state.can_swap_into():
		return false
	if primary_state.is_over():
		set_primary_state(state) 
		return false
	if !primary_state.block_movement and !state.only_primary and state is not Idle:
		#add_secondary_state(state)
		state.move(0)
func set_primary_state(other: State):
	primary_state.stop()
	primary_state = other
	primary_state.start()
	
func add_secondary_state(other: State):
	secondary_states.append(other)	


func _process(delta: float) -> void:
	if primary_state.is_over():
		pass
func _physics_process(delta: float) -> void:
	primary_state.update(delta)
	for s in secondary_states:
		s.move(delta)
		secondary_states.erase(s)
