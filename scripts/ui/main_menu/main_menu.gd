extends Control


var main_scene: PackedScene = preload("uid://gamq8ijstha3")

@onready var play_button: Button = $HBoxContainer/PlayButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
