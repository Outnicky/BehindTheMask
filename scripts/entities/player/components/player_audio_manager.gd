class_name PlayerAudioManager extends AudioManager



func _ready() -> void:
	self.audios = {
		"Swing" : $Swingsfx,
		"Damage" : $damagesf ,
		"Dash" : $Dashsfx,
		"PerfectDodge" : $perfectdodgesfx
	}
