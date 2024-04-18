extends AudioStreamPlayer

var rng = RandomNumberGenerator.new()
var lastSongNumber
var numberOfSongs = 4

func _ready():
	rng.randomize()

func _process(delta):
	if !playing:
		setToRandomSong()
		play()

func setToRandomSong():
	var songNumber = rng.randi_range(1, numberOfSongs)
	if songNumber == lastSongNumber:
		while songNumber == lastSongNumber:
			songNumber = rng.randi_range(1, numberOfSongs)
	lastSongNumber = songNumber
	resetChanges()
	match songNumber:
		1:
			stream = load("res://Assets/Sounds/CombatMusic/heilir.mp3")
			volume_db = -10
		2:
			stream = load("res://Assets/Sounds/CombatMusic/vikings.mp3")
			volume_db = -15
		3:
			stream = load("res://Assets/Sounds/CombatMusic/viking_saga.mp3")
			volume_db = -15
		4:
			stream = load("res://Assets/Sounds/CombatMusic/where_the_brave_may_live_forever.mp3")
			volume_db = -5

func resetChanges():
	volume_db = 0
	pitch_scale = 1