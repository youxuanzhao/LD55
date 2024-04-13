class_name GameManager
extends Node2D

static var instance : GameManager

var current_list = []

@onready var LeftArrow : Sprite2D = $LeftArrow

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = self
	$LeftArrow.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_list.size() == 3:
		LeftArrow.visible = true
	else:
		LeftArrow.visible = false

func add_fire():
	if current_list.size() == 3:
		current_list.pop_front()
		SummonDisplay.instance.remove_top()
	current_list.append("fire")
	SummonDisplay.instance.add_fire()

func add_water():
	if current_list.size() == 3:
		current_list.pop_front()
		SummonDisplay.instance.remove_top()
	current_list.append("water")
	SummonDisplay.instance.add_water()

func add_earth():
	if current_list.size() == 3:
		current_list.pop_front()
		SummonDisplay.instance.remove_top()
	current_list.append("earth")
	SummonDisplay.instance.add_earth()

func get_current_list():
	return current_list
