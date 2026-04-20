extends Control

@export var letters: Dictionary[String, Label]
@export var new_letter_sound: AudioStreamPlayer
@export_file("*.tscn") var ending_path: String

func _ready() -> void:
	GameManager.new_letter.connect(update_letters)

func update_letters(letter: String) -> void:
	letters[letter].text = letter
	GameManager.spaceship.camera.add_trauma(0.35)
	new_letter_sound.play()
	GameManager.letters.append(letter)
	if GameManager.letters.size() >= 6:
		await get_tree().create_timer(2.0).timeout
		SceneTransition.change_scene(ending_path)
