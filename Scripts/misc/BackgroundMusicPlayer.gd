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
			stream = load("res://Assets/Sounds/BackgroundMusic/dark_fantacy.mp3")
			volume_db = -20
		2:
			stream = load("res://Assets/Sounds/BackgroundMusic/dark_pagan_norse.mp3")
			volume_db = -20
		3:
			stream = load("res://Assets/Sounds/BackgroundMusic/langhus_burning.mp3")
			volume_db = -20
		4:
			stream = load("res://Assets/Sounds/BackgroundMusic/æðra.mp3")
			volume_db = -10

func resetChanges():
	volume_db = 0
	pitch_scale = 1
