class_name Minion
extends Sprite2D

var minion_name : String
var atk : int = 1
var hp : int = 1
var tile_position : Vector2i
var is_reserve : bool = true
var lifespan : int = -1
var birth_tick : int
var enter_tick : int
var is_friendly : bool = true

@onready var HealthBar: TextureProgressBar = $HealthBar

var is_hovering : bool = false
var is_holding : bool = false
var holding_offset : Vector2 
var pos_record : Vector2
var pos_offset : Vector2 = Vector2(0,-2)

# Called when the node enters the scene tree for the first time.
func _ready():
	HealthBar.visible = true
	HealthBar.max_value = hp
	HealthBar.value = hp

func _tick():
	if hp < 1:
		queue_free()
	
	if GameManager.instance.tick - enter_tick > lifespan:
		if lifespan!=-1:
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HealthBar.value = hp
	if Input.is_action_just_pressed("left_mouse") and is_hovering and is_reserve and !(GameManager.instance.is_paused):
		is_holding = true
		pos_record = position
		holding_offset = get_global_mouse_position() - position
		
		
	if Input.is_action_just_released("left_mouse") and is_holding:
		is_holding = false
		var temp = TileManager.instance.local_to_map(position)
		if (temp.x < 12 or temp.x > 17 or temp.y < 1 or (temp.y > 6 and temp.y != 8)) and !(TileManager.instance.has_entity_on(temp)):
			position = pos_record
		else:
			position = TileManager.instance.map_to_local(temp) + pos_offset
			tile_position = temp
			if temp.y !=8:
				is_reserve = false
				enter_tick = GameManager.instance.tick
			
		
	if is_holding:
		position = get_global_mouse_position() - holding_offset

func move(direction: Vector2i) -> bool:
	if !(is_reserve):
		if !(TileManager.instance.has_entity_on(tile_position + direction)):
			tile_position += direction
			if tile_position.x < 12:
				tile_position.x = 12
			if tile_position.x > 17:
				tile_position.x = 17
			if tile_position.y < 2:
				tile_position.y = 2
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
	if !(is_reserve):
		if TileManager.instance.has_entity_on(tile_position + direction):
			if !(instance_from_id(TileManager.instance.get_entity_on(tile_position + direction)).is_friendly):
				print(instance_from_id(TileManager.instance.get_entity_on(tile_position + direction)))
				instance_from_id(TileManager.instance.get_entity_on(tile_position + direction)).take_damage(atk)
			return true
		else:
			return false
	else:
		return false

func take_damage(amount: int):
	hp= hp - amount




func _on_area_2d_mouse_entered():
	is_hovering = true


func _on_area_2d_mouse_exited():
	is_hovering = false
