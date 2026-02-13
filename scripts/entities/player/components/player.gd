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
	
func take_damage(enemy: EnemyEntity):
	print(immune )
	if immune:
		return
	var context = Context.new(self,0.1)
	primary_state.new_state(context, Damaged.new(enemy))

func _input(event : InputEvent):
	primary_state.handle_input(event)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		double_jump = true
	super._physics_process(delta)

func set_hitbox(crouching):
	if crouching:
		$CrouchingShape.disabled = false
		$PlayerHitbox.disabled = true
	else:
		$CrouchingShape.disabled = true
		$PlayerHitbox.disabled = false
		pass
