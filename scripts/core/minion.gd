class_name Minion
extends Sprite2D

var minion_name : String
var atk : int = 1
var hp : int = 1
var tile_position : Vector2i
var is_reserve : bool
var lifespan : int
var birth_tick : int

@onready var HealthBar: TextureProgressBar = $HealthBar

var is_hover : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	HealthBar.max_value = hp
	HealthBar.value = hp

func _tick():
	if hp < 1:
		queue_free()
	
	if GameManager.instance.tick - birth_tick > lifespan:
		if lifespan!=-1:
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move(direction: Vector2i):
	tile_position += direction
	if tile_position.x < 12:
		tile_position.x = 12
	if tile_position.x > 17:
		tile_position.x = 17
	if tile_position.y < 1:
		tile_position.y = 1
	if tile_position.y > 6:
		tile_position.y = 6
	position = TileManager.instance.map_to_local(tile_position)
	


func _on_area_2d_mouse_entered():
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	pass # Replace with function body.
