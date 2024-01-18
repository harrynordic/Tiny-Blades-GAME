extends Node2D

@onready var grass_tilemap = $grass as TileMap
@onready var water_tilemap = $water as TileMap

var grass_used_cells: Array

#func _ready():
#	var used_grass_rect: Rect2 = grass_tilemap.get_used_rect()
#	grass_used_cells = grass_tilemap.get_used_cells(0)
#	generate_water_tiles(used_grass_rect)


#func generate_water_tiles(used_rect: Rect2) -> void:
#	for x in range(used_rect.position.x - 10, used_rect.size.x + 10):
#		for y in range(used_rect.position.y - 10, used_rect.size.y + 10):
#			if grass_used_cells.has(Vector2(x, y)):
#				continue
#			water_tilemap.set_cell(
#				0,
#				Vector2i(x, y), 
#				0,
#				Vector2i(0, 0)
#			)
