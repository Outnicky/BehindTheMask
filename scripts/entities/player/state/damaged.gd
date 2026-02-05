class_name  PlayerDamaged extends PlayerState

var enemy :EnemyClass

var vector :Vector2
var dir = -1
var immunity_time=0.4
var elapsed = 0
var knockback_force = 900
var knockback_decelartion = 12
var current_knockback = 1
func update(delta):
	super.update(delta)
	elapsed += delta
	move()
func move():
	player.velocity.x = -500 * dir
	
func is_over() -> bool:
	return elapsed >= immunity_time
func setup(_player,  opts: Dictionary = {}) -> PlayerState:
	super.setup(_player)
	enemy = opts["enemy"]
	#assert(enemy != null, "Set the enemy at the dictionary {\"enemy\": enemy}")
	vector = enemy.position -  player.position
	if vector.x > 0:
		dir = 1
	#current_knockback = player.velocity.x
	return self

func get_name() -> String:
	return "Hurt"

func get_audio_name():
	return "Damage"
func start():
	super.start()
	var hp  = player.health - enemy.attack_dmg 
	player.set_health( player.health - 1)
	if player.health == 0:
		return
	player.immune = true
	player.get_tree().create_timer(immunity_time).timeout.connect(func():
		player.immune  = false
	)
	
