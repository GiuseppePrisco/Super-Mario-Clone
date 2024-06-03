extends Node2D

#var master_bus
#var music_bus
#var sfx_bus


func _ready():
	
#	master_bus = AudioServer.get_bus_index("Master")
#	music_bus = AudioServer.get_bus_index("Music")
#	sfx_bus = AudioServer.get_bus_index("SFX")
	set_bus_volume("Master", Options.master_bus_volume)
	set_bus_volume("Music", Options.music_bus_volume)
	set_bus_volume("SFX", Options.sfx_bus_volume)
	
	# define a polyphonic audio stream
	$ItemCollected.stream = AudioStreamPolyphonic.new()
	$ItemCollected.stream.polyphony = 10
#	$ItemCollected.play()
	
	
func set_bus_volume(channel: String, value):
	var bus = AudioServer.get_bus_index(channel)
	AudioServer.set_bus_volume_db(bus, value)
	
	
func play_item_collected_sound_effect(effect):
	
	if !$ItemCollected.playing:
		$ItemCollected.play()
	
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = $ItemCollected.get_stream_playback()
	polyphonic_stream_playback.play_stream(effect, 0, 0)
	
#	$ItemCollected.stream = effect
#	$ItemCollected.play()


func play_music():
	if get_tree().paused:
		$Music.volume_db = -10
		$Music.play()
	else:
		$Music.play()
		
