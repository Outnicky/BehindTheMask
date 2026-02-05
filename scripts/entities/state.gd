class_name State extends RefCounted

var entity : Entity
var animation_ended = false
var new_state :State


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

func _swap(classname, state):
	if get_script() == classname:
		return
	if !state.can_swap_into():
		return
	if !self.is_over():
		new_state =  state
	else:
		entity.change_state(state)
func move():
	pass
func idle():
	pass
func take_damage(enemy):
	pass
	
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
