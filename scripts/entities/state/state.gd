class_name State extends RefCounted



var ended = false
var dir: Vector2 = Vector2.ZERO
var has_started_process = false
var has_started_physics = false
var force_state = false
var time_elapsed = 0
var animating = false

func get_animation_state(ctx, out: VisualOutput):
	out.animation_normal = VisualOutput.AnimationData.new(self, 0)
func setup(x) -> State:
	return self
func get_name()-> String:
	return "Empty State"
func get_audio_name()-> String:
	return get_name()

func stop(ctx):
	time_elapsed =0
	ended = true

func can_swap_into(ctx):
	return true
	
func is_over(ctx) -> bool:
	return ended


func start_process(ctx, out: VisualOutput):
	get_animation_state(ctx, out)
	out.sfx_name = get_audio_name()
	
func update_process(ctx: Context, out: VisualOutput):
	time_elapsed += ctx.delta
	if !has_started_process:
		start_process(ctx, out)
		has_started_process = true
	pass
	
func update_from_state(other)-> State:
	return self

func blend(other:State): # not working
	if other.block_animation:
		pass
		
func move(ctx, out):
	pass


func start_physics(ctx: Context, out: PhysicsOutput):
	pass
func update_physics(ctx: Context, out: PhysicsOutput):
	if !has_started_physics:
		start_physics(ctx, out)
		has_started_physics = true
	move(ctx, out)
	

func _equals(other: Object) -> bool:
	if other == null:
		return false
	#if other.get_script() != get_script():
	#	return false

	return get_name() == other.get_name()
