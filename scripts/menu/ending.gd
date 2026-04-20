extends Control
signal finished

@export var ending_lines: Array[String] = [
	"[FINAL SIGNAL RECONSTRUCTION COMPLETE]",
	"NEBULA",
	"[CLASSIFICATION RESULT: FAILURE]",
	"[RETURN PROTOCOL INITIATED]",
	"[ERROR]",
	"[NO DESTINATION FOUND]",
	"[WARNING: GRAVITIATIONAL ANOMALY]",
	"[NAVIGATION UPDATE: BLACK HOLE]",
	"[SIGNAL SOURCE UPDATED]",
	"[STATUS: RETURN//NULL]"
]
@export var outro_lines: Array[String] = [
	"You're not the last.",
	"Made for Ludum Dare 59 by ShadyShade.",
	"Thanks for playing! <3"
]
@export var label: RichTextLabel
@export var animation: AnimationPlayer
@export var text_sound: AudioStreamPlayer
@export_file("*.tscn") var main_menu_path: String

var current_lines: Array[String] = []
var lines_count: int = 0

var text: String = ""
var letter_idx: int = 0
var current_line_idx: int = 0
var can_advance_line: bool = false

var symbol_timer: float = 0.0
var letter_timer: float = 0.03
var space_timer: float = 0.06
var punctuation_timer = 0.2

func _ready() -> void:
	current_lines = ending_lines
	display_text(ending_lines[current_line_idx])
	finished.connect(on_text_finished)
	animation.animation_finished.connect(on_animation_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey && can_advance_line:
		current_line_idx += 1
		if current_line_idx >= current_lines.size():
			lines_count += 1
			finished.emit()
		else:
			display_text(current_lines[current_line_idx])

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

func on_text_finished() -> void:
	can_advance_line = false
	current_line_idx = 0
	match lines_count:
		1:
			animation.play("Outro")
		_:
			SceneTransition.change_scene(main_menu_path)

func on_animation_finished(_name: StringName) -> void:
	current_lines = outro_lines
	display_text(outro_lines[current_line_idx])
