class_name Entity extends CharacterBody2D


const SPEED = 250

var can_attack = true
var max_hp := 5
var current_hp = 0
var immune = false
var animation_player : AnimatedSprite2D
var audio_manager: AudioManager
var attack_controller: AttackController
var facing_direction = 1 
var controller : StateMachine
var move_dir: Vector2


func _init() -> void:
	controller = PlayerController.new()
func set_direction(new_direction):
	if new_direction == 0:
		return
	if new_direction == facing_direction:
		return
	if new_direction < 0:
		animation_player.flip_h = true
		attack_controller.flip()
	elif new_direction > 0:
		animation_player.flip_h = false
		attack_controller.flip()
	facing_direction = new_direction
func _ready() -> void:
	set_health(max_hp)
	animation_player = $AnimationController
	audio_manager = $AudioManager
	attack_controller = $Attack
	

func _process(delta: float) -> void:
	var ctx = controller.generate_context(self,delta)
	var out = VisualOutput.new()
	controller.update_process(ctx, out)
	controller.resolve_animation(ctx,out)
	
func _physics_process(delta: float) -> void:
	var ctx = controller.generate_context(self, delta)
	var out = PhysicsOutput.new()
	out.facing_direction = facing_direction
	controller.update_physics(ctx, out)
	var v =velocity * out.velocity_multiplier +\
	(out.direction* out.speed_multiplayer *out.speed + out.gravity)
	velocity= v
	set_direction(out.facing_direction)
	move_and_slide()

func take_damage(entity):
	if immune:
		return
	set_health(current_hp-1)
	print(current_hp)
	immune = true
	get_tree().create_timer(1).timeout.connect(func():
		immune = false)

func set_health(hp):
	current_hp = hp
	current_hp = 0 if current_hp <0 else current_hp
	if current_hp == 0:
		on_die()
		
func on_die():
	self.queue_free()
	return
func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity()  * delta
