class_name GameManager
extends Node2D

static var instance : GameManager

var current_list = []
var tick : int = 0
var minion_template : Minion = preload("res://scene_files/minion.tscn").instantiate()




const test1 = ["fire","fire","fire"]
const test2 = ["fire","fire","earth"]
const test3 = ["fire","earth","fire"]
const test4 = ["earth","fire","fire"]
const test5 = ["fire","fire","water"]
const test6 = ["fire","water","fire"]
const test7 = ["water","fire","fire"]
const test8 = ["fire","earth","earth"]
const test9 = ["earth","fire","earth"]
const test10 = ["earth","earth","fire"]
const test11 = ["fire","water","water"]
const test12 = ["water","fire","water"]
const test13 = ["water","water","fire"]
const test14 = ["water","water","water"]
const test15 = ["earth","earth","earth"]
const test16 = ["earth","earth","water"]
const test17 = ["earth","water","earth"]
const test18 = ["water","earth","earth"]
const test19 = ["earth","water","water"]
const test20 = ["water","earth","water"]
const test21 = ["water","water","earth"]
const test22 = ["fire","water","earth"]
const test23 = ["fire","earth","water"]
const test24 = ["water","fire","earth"]
const test25 = ["water","earth","fire"]
const test26 = ["earth","fire","water"]
const test27 = ["earth","water","fire"]




@onready var LeftArrow : Sprite2D = $LeftArrow
@onready var ShowResult : Sprite2D = $LeftArrow/ShowResult

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = self
	$LeftArrow.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_list.size() == 3:
		if current_list == test1:
			ShowResult.texture = preload("res://asset/minion_test.png")
		elif current_list == test2:
			ShowResult.texture = preload("res://asset/enemy_test.png") 
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

func summon():
	if current_list.size() == 3:
		if current_list == test1:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/fire_boy.gd"))
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()


func _on_tick_manager_timeout():
	tick=tick+1
	$Label.text = str("Tick: "+str(tick))
	TileManager.instance.tick()
