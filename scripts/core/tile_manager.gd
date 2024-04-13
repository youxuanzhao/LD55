class_name TileManager
extends TileMap

static var instance : TileManager

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(local_to_map(get_global_mouse_position()))

func summon():
	pass
