extends Node2D

const MAX_POLYPHONY = 10

@onready var item_collected_player = $ItemCollected
@onready var projectile_player = $Projectile
@onready var menu_player = $Menu

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
	
	# define a polyphonic audio stream for the players
	item_collected_player.stream = AudioStreamPolyphonic.new()
	item_collected_player.stream.polyphony = MAX_POLYPHONY
	
	projectile_player.stream = AudioStreamPolyphonic.new()
	projectile_player.stream.polyphony = MAX_POLYPHONY
	
	menu_player.stream = AudioStreamPolyphonic.new()
	menu_player.stream.polyphony = MAX_POLYPHONY
	
func set_bus_volume(channel: String, value: float):
	var bus = AudioServer.get_bus_index(channel)
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	
	# mute the bus if sound is below the minimum
	AudioServer.set_bus_mute(bus, value <= Options.master_bus_min_volume)
	
	
func play_item_collected_sound_effect(effect, volume: float):
	if !item_collected_player.playing:
		item_collected_player.play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = item_collected_player.get_stream_playback()
	polyphonic_stream_playback.play_stream(effect, 0, linear_to_db(volume))

func play_projectile_sound_effect(effect, volume: float):
	if !projectile_player.playing:
		projectile_player.play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = projectile_player.get_stream_playback()
	polyphonic_stream_playback.play_stream(effect, 0, linear_to_db(volume))

func play_menu_sound_effect(effect, volume: float):
	if !menu_player.playing:
		menu_player.play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = menu_player.get_stream_playback()
	polyphonic_stream_playback.play_stream(effect, 0, linear_to_db(volume))


func play_music(music, volume):
	$Music.stream = music
	$Music.volume_db = linear_to_db(volume)
	$Music.play()
	
