class_name Player extends Entity


var double_jump = true
var can_dash = true
var crouching = false

@onready var area : Area2D = $AreaSword
@onready var dash_sfx = $Dashsfx as AudioStreamPlayer
@onready var swing = $Swingsfx as AudioStreamPlayer
@onready var damagesfx = $damagesfx as AudioStreamPlayer
@onready var perfectdodgesfx = $perfectdodgesfx as AudioStreamPlayer
@export var lamp : PlayerLampUi


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
	state_machine.set_new_state(Damaged.new(self).setup({"other": enemy}))

	
		

func _process(delta: float) -> void:
	crouching =false
	get_inputs()
	if idle:
		state_machine.set_new_state(Idle.new(self))




#func _input(event : InputEvent):
#	if state.handle_input(event) == state.Result.CONSUMED:
#		return
	
	
func get_inputs():
	if Input.is_action_pressed("left"):
		set_direction(-1)
		state_machine.set_new_state(PlayerMove.new(self).setup({"dir": Vector2(-1,0)}))
	elif Input.is_action_pressed("right"):
		set_direction(1)
		state_machine.set_new_state( PlayerMove.new(self).setup({"dir": Vector2(1,0)}))
	if Input.is_action_just_pressed("jump"):
		state_machine.set_new_state(PlayerJump.new(self))

	if Input.is_action_just_pressed("dash") and can_dash:
		state_machine.set_new_state(Dash.new(self))		
	if Input.is_action_pressed("crouch"):
		crouching = true
	elif ($RayCast2D.is_colliding() == false and $RayCast2D2.is_colliding() == false and is_on_floor()):
		pass
	if Input.is_action_pressed("attack"):
		#if state.handle_input(Input) == state.Result.PASS:
		state_machine.set_new_state(Attack.new(self))
			

			


func apply_gravity(delta):
	if is_on_floor():
		double_jump = true
	if not is_on_floor():
		velocity += get_gravity()  * delta


func _physics_process(delta: float) -> void:
	set_hitbox()
	move_and_slide()
	if is_on_floor():
		double_jump = true
	idle = true
	
func is_crouching()-> bool:
	return crouching

func set_hitbox():
	if crouching:
		$CrouchingShape.disabled = false
		$PlayerHitbox.disabled = true
	else:
		$CrouchingShape.disabled = true
		$PlayerHitbox.disabled = false
		pass
