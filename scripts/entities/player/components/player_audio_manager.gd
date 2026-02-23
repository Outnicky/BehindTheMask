class_name PlayerAudioManager extends AudioManager



func _ready() -> void:
	self.audios = {
		"Swing" : $Swingsfx,
		"Damage" : $damagesfx ,
		"Dash" : $Dashsfx,
		"PerfectDodge" : $perfectdodgesfx
	}
