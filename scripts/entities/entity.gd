class_name Entity extends CharacterBody2D

var max_hp := 5
var current_hp = 0
var immune = false
var animation_player : AnimatedSprite2D
var audio_manager: AudioManager
func _ready() -> void:
	set_health(max_hp)

func take_damage(entity):
	if immune:
		return
	#Globals.todo("implement take_damage")
	pass
func change_state(state):
	Globals.todo("implement change_state")
	pass
func set_health(hp):
	current_hp = hp
	current_hp = 0 if current_hp <0 else current_hp
	
