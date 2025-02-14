extends Control

@onready var music_player: AudioStreamPlayer = $ElCaidoDeVaeltharIntro

func _ready() -> void:
	if music_player and not music_player.playing:
		music_player.play()  # Inicia la música automáticamente

func _on_volume_buttom_pressed() -> void:
	if music_player:
		music_player.stream_paused = not music_player.stream_paused  # Pausa y reanuda la música

func _on_resolution_buttom_pressed() -> void:
	pass

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
