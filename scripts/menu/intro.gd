extends Control

@export var lines: Array[String] = [
	"[BOOT SEQUENCE INITIATED]",
	"[NAVIGATION SYSTEM: ONLINE]",
	"[SIGNAL ARRAY: CALIBRATING]",
	"[ASTRACAT CORPORATION MESSAGE RECEIVED]",
	"Pilot, you are assigned to recover and classify anomalous deep-space signals beyond charted sectors. Previous missions failed to return complete data.",
	"[SIGNAL LOCK ACQUIRED]",
]
@export var label: RichTextLabel
@export var text_sound: AudioStreamPlayer
@export_file("*.tscn") var world_path: String

var text: String = ""
var letter_idx: int = 0
var current_line_idx: int = 0
var can_advance_line: bool = false

var symbol_timer: float = 0.0
var letter_timer: float = 0.03
var space_timer: float = 0.06
var punctuation_timer = 0.2

func _ready() -> void:
	display_text(lines[current_line_idx])

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey && can_advance_line:
		current_line_idx += 1
		if current_line_idx >= lines.size():
			SceneTransition.change_scene(world_path)
		else:
			display_text(lines[current_line_idx])

func display_letter() -> void:
	label.text += text[letter_idx]
	letter_idx += 1
	
	text_sound.pitch_scale = randf_range(0.8, 1.2)
	text_sound.play()
	
	if letter_idx >= text.length():
		can_advance_line = true
		return
	
	match text[letter_idx]:
		"!", "?", ".", ",":
			symbol_timer = punctuation_timer
		" ":
			symbol_timer = space_timer
		_:
			symbol_timer = letter_timer
	
	await get_tree().create_timer(symbol_timer).timeout
	display_letter()

func display_text(text_to_display: String) -> void:
	letter_idx = 0
	can_advance_line = false
	text = text_to_display
	label.text = text_to_display
	label.text = ""
	display_letter()
