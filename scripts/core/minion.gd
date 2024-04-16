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
	hp+=GameManager.instance.extra_health
	atk+=GameManager.instance.extra_attack
	HealthBar.visible = true
	HealthBar.max_value = hp
	HealthBar.value = hp

func _tick():
	if hp < 1:
		death()
	elif GameManager.instance.tick - enter_tick > lifespan and !(is_reserve):
		if lifespan!=-1:
			death()

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
		if (temp.x < 13 or temp.x > 17 or temp.y < 2 or (temp.y > 6 and temp.y != 8)) or TileManager.instance.has_entity_on(temp):
			print(TileManager.instance.has_entity_on(temp))
			print(temp)
			position = pos_record
		else:
			print(TileManager.instance.has_entity_on(temp))
			print(temp)
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
	$AudioStreamPlayer2D.play()
	hp= hp - amount


func death():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "rotation", 360, 0.5)
	tween.tween_property(self, "scale", Vector2(0.1,0.1), 0.5)
	tween.set_parallel(false)
	tween.tween_callback(queue_free)

func _on_area_2d_mouse_entered():
	is_hovering = true


func _on_area_2d_mouse_exited():
	is_hovering = false
