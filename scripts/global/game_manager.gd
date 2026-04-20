extends Node
@warning_ignore("unused_signal")
signal new_letter(letter: String)

var letters: Array[String] = []
var spaceship: SpaceShip
var camera_shake: bool = true
var inverse_x_axis: bool = false
var inverse_y_axis: bool = false
