extends Control

@onready var music_player: AudioStreamPlayer = $ElCaidoDeVaeltharIntro  # Asegúrate de que este nodo exista en la escena

func _ready() -> void:
	if music_player and not music_player.playing:
		music_player.play()  # Inicia la música automáticamente

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/prologo_scene.tscn")

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
