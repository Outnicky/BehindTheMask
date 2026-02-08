class_name Entity extends CharacterBody2D

var max_hp := 5
var current_hp = 0
var immune = false
var idle = true
var can_attack = true
var animation_player : AnimatedSprite2D
var audio_manager: AudioManager
var attack_controller: AttackController

var direction = 1
var state_machine = StateMachine.new(self)
var move_dir: Vector2
func set_direction(new_direction):
	if new_direction == direction:
		return
	if new_direction < 0:
		animation_player.flip_h = true
		print("turning l ")
		attack_controller.flip()
	elif new_direction > 0:
		animation_player.flip_h = false
		print("turning r")
		attack_controller.flip()
	direction = new_direction
func _ready() -> void:
	set_health(max_hp)
	animation_player = $AnimationController
	audio_manager = $AudioManager
	attack_controller = $Attack
	add_child(state_machine)
	



func take_damage(entity):
	if immune:
		return
	#Globals.todo("implement take_damage")
	pass

func set_health(hp):
	current_hp = hp
	current_hp = 0 if current_hp <0 else current_hp
	if current_hp == 0:
		on_die()
		
func on_die():
	return
func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity()  * delta
