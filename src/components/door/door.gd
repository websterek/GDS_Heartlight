extends StaticBody2D

onready var levelInstance = get_node("../")

var is_open = false

func _ready():
	levelInstance.connect("heart_added", self, "close")
	levelInstance.connect("all_hearts_taken", self, "open")

func open():
	is_open = true
	set_visible(false)
	
func close():
	is_open = false
	set_visible(true)

func push(direction = null):
	if is_open:
		return true
	else:
		return false