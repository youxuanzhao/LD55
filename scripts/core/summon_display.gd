class_name SummonDisplay
extends HBoxContainer

static var instance : SummonDisplay

var fire_texture : CompressedTexture2D = preload("res://asset/fire.png")
var water_texture : CompressedTexture2D = preload("res://asset/water.png")
var earth_texture : CompressedTexture2D = preload("res://asset/earth.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = self

func add_fire():
	var temp : TextureRect = TextureRect.new()
	temp.texture = fire_texture
	add_child(temp)

func add_water():
	var temp : TextureRect = TextureRect.new()
	temp.texture = water_texture
	add_child(temp)

func add_earth():
	var temp : TextureRect = TextureRect.new()
	temp.texture = earth_texture
	add_child(temp)

func remove_top():
	var temp = get_children()
	temp[0].queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
