class_name Player extends Entity


var double_jump = true
var can_dash = true
var crouching = false
var idle = true
var direction = 0
@onready var area : Area2D = $AreaSword
@onready var dash_sfx = $Dashsfx as AudioStreamPlayer
@onready var swing = $Swingsfx as AudioStreamPlayer
@onready var damagesfx = $damagesfx as AudioStreamPlayer
@onready var perfectdodgesfx = $perfectdodgesfx as AudioStreamPlayer
@export var lamp : PlayerLampUi

var state : PlayerState = PlayerIdle.new(self)
func _ready() -> void:
	audio_manager = $AudioManager
	animation_player = $PlayerSprite
	max_hp = 5
	set_health(max_hp)
	
func set_health(hp):
	super.set_health(hp)
	lamp.set_life(current_hp)
		
func change_state(other:PlayerState):
	state.stop()
	state = other
	state.start()
	
func on_die():
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
	
func take_damage(enemy: EnemyClass):
	if immune:
		return
	state.take_damage(enemy)
	
		

func _process(delta: float) -> void:
	crouching =false
	get_inputs()
	state.update(delta)


func set_direction(num):
	var col = $AreaSword/AttackHitbox
	if direction < 0:
		animation_player.flip_h = true
		if col.position.x >=0:
			col.position.x *=-1
	if direction > 0:
		animation_player.flip_h = false
		if col.position.x <=0:
			col.position.x *=-1
	direction = num
func get_inputs():
	idle = true
	var result :Global.Result = Global.Result.NOTHING
	if Input.is_action_pressed("left"):
		set_direction(-1)
		state.move()
		idle = false
	#	result = change_state(PlayerMove.new().setup(self))
	elif Input.is_action_pressed("right"):
		set_direction(1)
		
		state.move()
		idle = false
	#	result = change_state(PlayerMove.new().setup(self))
		
	if Input.is_action_just_pressed("jump"):
		state.jump()
		idle = false
	#	result = change_state(PlayerJump.new().setup(self))
		
	if Input.is_action_just_pressed("dash") and can_dash:
		state.dash()
		idle = false
	#	result = change_state(PlayerDash.new().setup(self))
		
	if Input.is_action_pressed("crouch") :
		crouching = true
		
	elif ($RayCast2D.is_colliding() == false and $RayCast2D2.is_colliding() == false and is_on_floor()):
	#	crouching = true
		pass
		
	
	if Input.is_action_pressed("attack"):
		state.attack()
		
		#change_state(PlayerAttack.new().setup(self))
	
	if idle:
		state.idle()
			


func apply_gravity(delta):
	if is_on_floor():
		double_jump = true
	if not is_on_floor():
		velocity += get_gravity()  * delta

func move():
	if is_crouching():
		if !is_on_floor():
			velocity.y = -PlayerMove.CROUCH_DOWNARDS_VELOCITY
		velocity.x = PlayerMove.CROUCH_SPEED * direction 
	else:
		velocity.x = PlayerMove.SPEED *direction 

func _physics_process(delta: float) -> void:
	state.change_if_over()
	state.update(delta)
	set_hitbox()
	#state.new_state = null
	move_and_slide()

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

func _on_sword_hit_area_entered(area: Area2D) -> void:
	pass
#	if area is EnemyClass:
		
	##	area.take_damage()
