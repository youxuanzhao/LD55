class_name TileManager
extends TileMap

static var instance : TileManager

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = self



func _process(delta):
	#This is a debug option to check the tile position of current mouse position
	#print(local_to_map(get_global_mouse_position()))
	pass

func summon(target: Minion) -> bool:
	for i in range(13,18):
		if !(has_entity_on(Vector2i(i,8))):
			target.position = map_to_local(Vector2i(i,8)) + target.pos_offset
			target.tile_position = Vector2i(i,8)
			target.birth_tick = GameManager.instance.tick
			add_child(target)
			return true
	return false

func spawn_enemy_on(target: Enemy, pos: Vector2i):
	if !(has_entity_on(pos)):
		target.position = map_to_local(pos) + target.pos_offset
		target.tile_position = pos
		target.birth_tick = GameManager.instance.tick
		add_child(target)

func has_entity_on(pos:Vector2i) -> bool:
	for n in get_children():
		if n.tile_position == pos:
			return true
	return false
	
func get_entity_on(pos:Vector2i) -> int:
	for n in get_children():
		if n.tile_position == pos:
			return n.get_instance_id()
	return 0

func tick():
	for n in get_children():
		n._tick()

func clear_level():
	for i in get_children():
		if i is Minion:
			if i.tile_position.y != 8:
				GameManager.instance.spawn_coin_on_position(i.position,1)
				i.queue_free()
		if i is Enemy:
			i.queue_free()
