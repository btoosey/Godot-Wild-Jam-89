class_name GridMover
extends Node

@export var player: Player
@export var speed: float

@onready var ground: TileMapLayer = $"../../Tilemaps/Ground"
@onready var walls: TileMapLayer = $"../../Tilemaps/Walls"

var is_moving := false
var can_move := true


func _process(_delta: float) -> void:
	player.player_sprite.global_position = player.player_sprite.global_position.move_toward(player.global_position, speed)

	if player.global_position == player.player_sprite.global_position:
		is_moving = false
		can_move = true

	if !can_move:
		return

	if Input.is_action_just_pressed("Up"):
		try_move(Vector2i.UP)
	if Input.is_action_just_pressed("Down"):
		try_move(Vector2i.DOWN)
	if Input.is_action_just_pressed("Left"):
		try_move(Vector2i.LEFT)
	if Input.is_action_just_pressed("Right"):
		try_move(Vector2i.RIGHT)


func try_move(direction: Vector2i) -> void:
	var current_tile: Vector2i = ground.local_to_map(player.global_position)
	var target_tile: Vector2i = current_tile + direction
	var target_tile_data: TileData = walls.get_cell_tile_data(target_tile)

	if target_tile_data != null and target_tile_data.get_custom_data("Wall"):
		return

	is_moving = true
	can_move = false
	player.global_position = ground.map_to_local(target_tile)
	player.player_sprite.global_position = ground.map_to_local(current_tile)
	current_tile = ground.local_to_map(player.global_position)
