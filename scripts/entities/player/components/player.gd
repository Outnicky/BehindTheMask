class_name PlayerEntity extends Entity





@export var lamp : PlayerLampUi


var double_jump = false
var can_dash = true
var spawnpoint = Vector2(404.0, 160.0)


func _init():
	can_attack = true
	controller = PlayerController.new()
	
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
	self.global_position = spawnpoint
	set_health(max_hp)
	
func take_damage(enemy: EnemyEntity):
	print(immune )
	if immune:
		return
	var context = Context.new(self,0.1)
	controller.new_command(Damaged.new(enemy))

func _input(event : InputEvent):
	controller.handle_input(event)

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
