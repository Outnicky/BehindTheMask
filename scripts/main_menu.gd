extends Node2D

@onready var buton= $Button
@onready var buton2= $Button2

func go_to_stage():
	
	get_tree().change_scene_to_file("res://scenes/ninjask/scenadoNinjask.tscn")
	pass
func _ready() -> void:
	buton.pressed.connect(func():
		
		go_to_stage()
	)
	buton2.pressed.connect(func():
		get_tree().quit()
	)
	
