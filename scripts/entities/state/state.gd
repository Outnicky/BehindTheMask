class_name State extends RefCounted


enum Result { PASS, CONSUMED }
var entity : Entity
var animation_ended = false
var dir: Vector2 = Vector2.ZERO
var block_movement = false
var only_primary = false
var has_started = false
var block_animation = true
var force_state = false
func attach(e):
	self.entity = e
	
func setup(x) -> State:
	return self
func get_name()-> String:
	return "Empty State"
func get_audio_name()-> String:
	return get_name()






func swap(state) -> bool:
	if self == state:
		return false
	if !state.canswap_into():
		return false
	if !self.is_over():
		#new_state =  state
		return false
	else:
		entity.change_state(state)
		return true


func set_dir(direction)-> State:
	dir = direction
	return self
	



func animate():
	entity.animation_player.play(get_name())
	entity.animation_player.animation_finished.connect(_on_animation_finish)

func _on_animation_finish():
	animation_ended = true


func start():
	#animate()
	entity.audio_manager.play(get_audio_name())

func stop():
	animation_ended = true
	entity.animation_player.animation_finished.disconnect(_on_animation_finish)

func can_swap_into():
	return true
	
func is_over() -> bool:
	return animation_ended

func move( delta):
	pass

func update(delta):
	pass
	
func update_from_state(other)-> State:
	return self

func blend(other:State):
	if other.block_animation:
		pass
func update_physics( delta):
	if !has_started:
		start()
		has_started = true
	move(delta)
	pass
	

func _equals(other: Object) -> bool:
	if other == null:
		return false
	if other.get_script() != get_script():
		return false

	return get_name() == other.get_name()
