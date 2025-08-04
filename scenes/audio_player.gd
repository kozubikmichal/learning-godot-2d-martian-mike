extends Node

var sfxs = {
	"hurt": preload("res://assets/audio/hurt.wav"),
	"jump": preload("res://assets/audio/jump.wav")
}

func play_sfx(name: String) -> void:	
	var stream = sfxs[name]
	if !stream:
		print("Invalid sfx name " + name)
		return
		
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()
