class_name GameManager
extends Node2D

static var instance : GameManager

var current_list = []
var tick : int = 0
var minion_template : Minion = preload("res://scene_files/minion.tscn").instantiate()




const inferno = ["fire","fire","fire"]
const lava1 = ["fire","fire","earth"]
const lava2 = ["fire","earth","fire"]
const lava3 = ["earth","fire","fire"]
const vapor1 = ["fire","fire","water"]
const vapor2 = ["fire","water","fire"]
const vapor3 = ["water","fire","fire"]
const dirt1 = ["fire","earth","earth"]
const dirt2 = ["earth","fire","earth"]
const dirt3 = ["earth","earth","fire"]
const ice1 = ["fire","water","water"]
const ice2 = ["water","fire","water"]
const ice3 = ["water","water","fire"]
const aqua = ["water","water","water"]
const mountain = ["earth","earth","earth"]
const sand1 = ["earth","earth","water"]
const sand2 = ["earth","water","earth"]
const sand3 = ["water","earth","earth"]
const swamp1 = ["earth","water","water"]
const swamp2 = ["water","earth","water"]
const swamp3 = ["water","water","earth"]
const life1 = ["fire","water","earth"]
const life2 = ["fire","earth","water"]
const life3 = ["water","fire","earth"]
const life4 = ["water","earth","fire"]
const life5 = ["earth","fire","water"]
const life6 = ["earth","water","fire"]




@onready var LeftArrow : Sprite2D = $LeftArrow
@onready var ShowResult : Sprite2D = $LeftArrow/ShowResult

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = self
	$LeftArrow.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_list.size() == 3:
		if current_list == inferno:
			ShowResult.texture = preload("res://asset/inferno.png")
		elif current_list == lava1 or current_list == lava2 or current_list == lava3:
			ShowResult.texture = preload("res://asset/lava.png")
		elif current_list == vapor1 or current_list == vapor2 or current_list == vapor3:
			ShowResult.texture = preload("res://asset/wind.png")
		elif current_list == dirt1 or current_list == dirt2 or current_list == dirt3:
			ShowResult.texture = preload("res://asset/dirt.png")
		elif current_list == ice1 or current_list == ice2 or current_list == ice3:
			ShowResult.texture = preload("res://asset/ice.png")
		elif current_list == aqua:
			ShowResult.texture = preload("res://asset/aqua.png")
		elif current_list == mountain:
			ShowResult.texture = preload("res://asset/mountain.png")
		elif current_list == sand1 or current_list == sand2 or current_list == sand3:
			ShowResult.texture = preload("res://asset/sand.png")
		elif current_list == swamp1 or current_list == swamp2 or current_list == swamp3:
			ShowResult.texture = preload("res://asset/swamp.png")
		else:
			ShowResult.texture = preload("res://asset/life.png")
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
		if current_list == inferno:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == lava1 or current_list == lava2 or current_list == lava3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == vapor1 or current_list == vapor2 or current_list == vapor3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == dirt1 or current_list == dirt2 or current_list == dirt3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == ice1 or current_list == ice1 or current_list == ice1:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == aqua:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == mountain:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == sand1 or current_list == sand2 or current_list == sand3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == swamp1 or current_list == swamp2 or current_list == swamp3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		else:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/inferno.gd"))
			temp.texture = preload("res://asset/inferno.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()

func _on_tick_manager_timeout():
	tick=tick+1
	$Label.text = str("Tick: "+str(tick))
	TileManager.instance.tick()
