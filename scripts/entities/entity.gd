class_name Entity extends CharacterBody2D


const SPEED = 250

var max_hp := 5
var current_hp = 0
var immune = false
var animation_player : AnimatedSprite2D
var audio_manager: AudioManager
var attack_controller: AttackController
var direction = 1
var primary_state 
var move_dir: Vector2


func _init() -> void:
	primary_state = PrimaryState.new(self)
func set_direction(new_direction):
	if new_direction == direction:
		return
	if new_direction < 0:
		animation_player.flip_h = true
		attack_controller.flip()
	elif new_direction > 0:
		animation_player.flip_h = false
		attack_controller.flip()
	direction = new_direction
func _ready() -> void:
	set_health(max_hp)
	animation_player = $AnimationController
	audio_manager = $AudioManager
	attack_controller = $Attack
	
	



func take_damage(entity):
	if immune:
		return
	set_health(current_hp-1)
	print(current_hp)

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
