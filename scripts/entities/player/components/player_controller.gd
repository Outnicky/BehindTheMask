class_name Player extends Entity



@onready var area : Area2D = $AreaSword
@export var lamp : PlayerLampUi


var double_jump = false
var can_dash = true


func _init():
	can_attack = true
	primary_state = PlayerNormal.new()
func _ready() -> void:
	max_hp = 5
	super._ready()
	audio_manager = $AudioManager
	animation_player = $AnimationController
	attack_controller = $Attack
	
func set_health(hp):
	super.set_health(hp)
	lamp.set_life(current_hp)
		

	
func on_die():
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
	
func take_damage(enemy: EnemyClass):
	print(immune )
	if immune:
		return
	primary_state.new_state(Damaged.new(enemy))
	#state_machine.set_new_state(Damaged.new(self).setup({"other": enemy}))



func _input(event : InputEvent):
	primary_state.handle_input(event)


func apply_gravity(delta):
	velocity += get_gravity()  * delta

func _process(delta: float) -> void:
	super._process(delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if is_on_floor():
		double_jump = true
	super._physics_process(delta)
	move_and_slide()
	

func set_hitbox(crouching):
	if crouching:
		$CrouchingShape.disabled = false
		$PlayerHitbox.disabled = true
	else:
		$CrouchingShape.disabled = true
		$PlayerHitbox.disabled = false
		pass
