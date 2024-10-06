extends Node


func play(sound_id: String) -> void:
	var audio_stream_player: AudioStreamPlayer = get_node(sound_id) as AudioStreamPlayer
	if is_instance_valid(audio_stream_player) and not audio_stream_player.playing:
		audio_stream_player.play()
