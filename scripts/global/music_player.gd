extends Node

enum Song {
	MENU,
	GAME,
}

@onready var menu_music := $MenuMusic
@onready var game_music := $GameMusic

func play_song(song: Song) -> void:
	match song:
		Song.MENU:
			if game_music.playing:
				game_music.stop()
			if !menu_music.playing:
				menu_music.play()
		Song.GAME:
			if menu_music.playing:
				menu_music.stop()
			if !game_music.playing:
				game_music.play()
