extends AudioStreamPlayer

var rng = RandomNumberGenerator.new()
var lastSongNumber
var lastSongNumberCombat
# Set the number of regular songs
var numberOfSongs = 4
# Set the number of combat songs
var numberOfCombatSongs = 4
var stopSpeed = 0.002
var fadeOut = false
var stopped = false
var songType = "default"

func _ready():
	rng.randomize()

func _process(delta):
	if !playing:
		match songType:
			"default":
				setToRandomSong()
			"combat":
				setToRandomCombatSong()
		play()
	if fadeOut:
		volume_db = lerp(volume_db, -80, stopSpeed)
		if volume_db <= -80:
			stopped = true
		

func resetChanges():
	volume_db = 0
	pitch_scale = 1

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

func setToRandomCombatSong():
	var songNumber = rng.randi_range(1, numberOfCombatSongs)
	if songNumber == lastSongNumberCombat:
		while songNumber == lastSongNumberCombat:
			songNumber = rng.randi_range(1, numberOfCombatSongs)
	lastSongNumberCombat = songNumber
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

func changeSongType(type):
	match type:
		"combat":
			fadeOut = true
			songType = type
		"default":
			fadeOut = true
			songType = type
