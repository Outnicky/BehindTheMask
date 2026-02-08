class_name State extends RefCounted


enum Result { PASS, CONSUMED }
var entity : Entity
var animation_ended = false
var new_state :State
var dir: Vector2 = Vector2.ZERO
var block_movement = false
var only_primary = false

func _init(e):
	self.entity = e 
	
func setup(opts: Dictionary = {}) -> State:
	return self
func get_name()-> String:
	return "Empty State"
func get_audio_name()-> String:
	return get_name()

func get_next_state()-> State:
	if is_over():
		if new_state:
			return new_state
	return self




func swap(state) -> bool:
	if self == state:
		return false
	if !state.canswap_into():
		return false
	if !self.is_over():
		new_state =  state
		return false
	else:
		entity.change_state(state)
		return true


		
	
func handle_input(event)-> Result:
	return Result.PASS

func change_if_over():
	if is_over() :
		if new_state:
			entity.change_state(new_state)


func animate():
	entity.animation_player.play(get_name())
	entity.animation_player.animation_finished.connect(_on_animation_finish)

func _on_animation_finish():
	animation_ended = true

func start():
	animate()
	entity.audio_manager.play(get_audio_name())

func stop():
	entity.animation_player.animation_finished.disconnect(_on_animation_finish)

func can_swap_into():
	return true
	
func is_over() -> bool:
	return animation_ended

func move(delta):
	entity.velocity.x = 0

func update(delta):
	entity.apply_gravity(delta)
	move(delta)
	
	

func _equals(other: Object) -> bool:
	if other == null:
		return false
	if other.get_script() != get_script():
		return false

	return get_name() == other.get_name()
