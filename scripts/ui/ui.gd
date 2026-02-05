class_name PlayerLampUi extends Node2D


func _process(delta: float) -> void:
	$Lantern.position.x =  32
	$Lantern.position.y = DisplayServer.window_get_size().y - 32
	

func set_life(number):
	$Lantern.frame = number -1
