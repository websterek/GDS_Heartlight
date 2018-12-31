extends Node2D

signal heart_added
signal all_hearts_taken

var tile_size = globals.tile_size
var remainingHearts = []
var level_filename = null

func register_heart(name):
	remainingHearts.append(name)
	emit_signal("heart_added")

func remove_heart(name):
	remainingHearts.erase(name)
	if (remainingHearts.size() <= 0):
		emit_signal("all_hearts_taken")


func _ready():
	pass

func calculate_bounds():
	var used_cells = get_node("tile_front").get_used_cells()
	var min_x = 0
	var min_y = 0
	var max_x = 1
	var max_y = 1

	for pos in used_cells:
		if pos.x < min_x:
			min_x = int(pos.x)
		elif pos.x > max_x:
			max_x = int(pos.x)
		if pos.y < min_y:
			min_y = int(pos.y)
		elif pos.y > max_y:
			max_y = int(pos.y)

	return {
		"min": Vector2(
			min_x * tile_size.x + self.position.x, 
			min_y * tile_size.y + self.position.y
		),
		"max": Vector2(
			(max_x + 1) * tile_size.x + self.position.x,
			(max_y + 1) * tile_size.y + self.position.y
		),
		"height": (max_y + 1 - min_y) * tile_size.y,
		"width": (max_x + 1 - min_x) * tile_size.x
	}

func calculate_zoom(bounds = null):
	var screen_height = ProjectSettings.get_setting("display/window/size/height")
	var screen_width = ProjectSettings.get_setting("display/window/size/width")
	
	var tilemap_bounds = bounds
	if tilemap_bounds:
		tilemap_bounds = calculate_bounds()
	
	var zoom_x = tilemap_bounds.width / screen_width
	var zoom_y = tilemap_bounds.height / screen_height
	return zoom_x if zoom_x > zoom_y else zoom_y

