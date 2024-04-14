class_name Enemy
extends Sprite2D

var level : int = 0
var minion_name : String
var atk : int = 1
var hp : int = 1
var tile_position : Vector2i
var is_reserve : bool = false
var lifespan : int = -1
var birth_tick : int
var enter_tick : int
var is_friendly : bool = false

@onready var HealthBar: TextureProgressBar = $HealthBar

var is_hovering : bool = false
var is_holding : bool = false
var holding_offset : Vector2 
var pos_record : Vector2
var pos_offset : Vector2 = Vector2(0,-2)

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = level
	HealthBar.max_value = hp
	HealthBar.value = hp

func _tick():
	tile_position = TileManager.instance.local_to_map(position)
	position = TileManager.instance.map_to_local(tile_position) + pos_offset
	if hp < 1:
		GameManager.instance.spawn_coin_on_position(position,randi_range(0,4))
		death()
	
	elif GameManager.instance.tick - enter_tick > lifespan:
		if lifespan!=-1:
			death()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HealthBar.value = hp

func move(direction: Vector2i) -> bool:
	if !(is_reserve):
		if (tile_position + direction).y > 6:
			return false		
		if !(TileManager.instance.has_entity_on(tile_position + direction)):
			tile_position += direction
			if tile_position.x < 12:
				tile_position.x = 12
			if tile_position.x > 17:
				tile_position.x = 17
			if tile_position.y < 1:
				tile_position.y = 1
			if tile_position.y > 6:
				tile_position.y = 6
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", TileManager.instance.map_to_local(tile_position) + pos_offset, 0.5)
			return true
		else:
			return false
	else:
		return false

func attack(direction: Vector2i) -> bool:
	if tile_position.y == 6:
		GameManager.instance.wall_take_damage(atk)
		return true
	
	if !(is_reserve):
		if TileManager.instance.has_entity_on(tile_position + direction):
			if instance_from_id(TileManager.instance.get_entity_on(tile_position + direction)).is_friendly:
				print(instance_from_id(TileManager.instance.get_entity_on(tile_position + direction)))
				instance_from_id(TileManager.instance.get_entity_on(tile_position + direction)).take_damage(atk)
			return true
		else:
			return false
	else:
		return false

func death():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "rotation", 360, 0.5)
	tween.tween_property(self, "scale", Vector2(0.1,0.1), 0.5)
	tween.set_parallel(false)
	GameManager.instance.elim()
	tween.tween_callback(queue_free)

func take_damage(amount: int):
	$AudioStreamPlayer2D.play()
	hp= hp - amount
