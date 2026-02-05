class_name AudioManager extends Node

var audios: Dictionary[String, AudioStreamPlayer] 
var playing := false
var current := ""



func play(name: String):
	var audio = audios.get(name)
	if audio == null:
		return
	audio.play()
	playing = true
	

func stop(name):
	audios[name].stop()
