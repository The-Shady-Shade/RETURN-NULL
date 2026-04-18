extends Control

@export var letters: Dictionary[String, Label]

func _ready() -> void:
	GameManager.new_letter.connect(update_letters)

func update_letters() -> void:
	for letter: String in GameManager.letters:
		if letters.has(letter):
			letters[letter].text = letter
	
	if GameManager.letters.size() >= 6:
		pass
