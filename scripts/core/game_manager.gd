class_name GameManager
extends Node2D

static var instance : GameManager

var current_list = []
var current_wave = 0
var current_enemy = 0
var tick : int = 0
var total_coins : int = 9999
var minion_template : Minion = preload("res://scene_files/minion.tscn").instantiate()
var remaining_enemies : int
var has_spawned_all : bool = false
var is_paused: bool = false
var fire_level : int = 0
var water_level : int = 0
var earth_level : int = 0
var summon_level : int = 0
var extra_health : int = 0
var extra_attack : int = 0



@export var waves : Array
@export var wave_config : Array
@export var wall_hp : int = 30

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
	$RefreshButton.visible = false
	$ItemSlot.visible = false
	$Label2.visible = true
	$StartWaveButton.visible = false
	$LeftArrow.visible = false
	$WallHp.max_value = wall_hp
	$WallHp.value = wall_hp
	current_wave = 0
	$WaveCount.text = str("Wave "+str(current_wave+1))
	current_enemy = 0
	remaining_enemies = waves[0].size()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if remaining_enemies == 0 and !is_paused:
		end_wave()
	
	$WallHp.value = wall_hp
	if wall_hp < 20:
		$Wall.frame = 1
		if wall_hp < 10:
			$Wall.frame = 2
			if wall_hp <= 0:
				$Wall.frame = 3
	
	$RemainCount.text = str(remaining_enemies)
	
	$CoinCount.text = str(total_coins)
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

func upgrade_fire():
	fire_level+=1

func upgrade_water():
	water_level+=1

func upgrade_earth():
	earth_level+=1
	
func upgrade_summon():
	summon_level+=1

func upgrade_health():
	extra_health+=1

func upgrade_attack():
	extra_attack+=1









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
			temp.set_script(preload("res://scripts/minions/lava.gd"))
			temp.texture = preload("res://asset/lava.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == vapor1 or current_list == vapor2 or current_list == vapor3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/wind.gd"))
			temp.texture = preload("res://asset/wind.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == dirt1 or current_list == dirt2 or current_list == dirt3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/dirt.gd"))
			temp.texture = preload("res://asset/dirt.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == ice1 or current_list == ice2 or current_list == ice3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/ice.gd"))
			temp.texture = preload("res://asset/ice.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == aqua:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/aqua.gd"))
			temp.texture = preload("res://asset/aqua.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == mountain:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/mountain.gd"))
			temp.texture = preload("res://asset/mountain.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == sand1 or current_list == sand2 or current_list == sand3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/sand.gd"))
			temp.texture = preload("res://asset/sand.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		elif current_list == swamp1 or current_list == swamp2 or current_list == swamp3:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/swamp.gd"))
			temp.texture = preload("res://asset/swamp.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()
		else:
			var temp = preload("res://scene_files/minion.tscn").instantiate()
			temp.set_script(preload("res://scripts/minions/life.gd"))
			temp.texture = preload("res://asset/life.png")
			TileManager.instance.summon(temp)
			current_list = []
			SummonDisplay.instance.remove_all()

func _on_tick_manager_timeout():
	tick=tick+1
	TileManager.instance.tick()
	if !has_spawned_all:
		if tick >= waves[current_wave][current_enemy]:
			var spawned : bool = false
			var temp = preload("res://scene_files/enemy.tscn").instantiate()
			if wave_config[current_wave][current_enemy] == 0:
				temp.set_script(preload("res://scripts/enemies/easy.gd"))
			elif wave_config[current_wave][current_enemy] == 1:
				temp.set_script(preload("res://scripts/enemies/medium.gd"))
			while !spawned:
				var i = randi_range(13,17)
				if !(TileManager.instance.has_entity_on(Vector2i(i,1))):
					spawned = true
					current_enemy += 1
					if current_enemy >= waves[current_wave].size():
						has_spawned_all = true
					TileManager.instance.spawn_enemy_on(temp,Vector2i(i,1))
	$Label.text = str("Tick: "+str(tick))



func spawn_coin_on_position(pos: Vector2, amount: int):
	for i in amount:
		var temp = preload("res://scene_files/coin.tscn").instantiate()
		temp.collector = $CoinCollector
		temp.position = pos + Vector2(randf_range(-12,12),randf_range(-12,+12))
		add_child(temp)

func elim():
	remaining_enemies -= 1

func wall_take_damage(amount: int):
	wall_hp -= amount

func start_wave():
	$RefreshButton.visible = false
	$Label2.visible = true
	$ItemSlot.visible = false
	current_wave += 1
	current_enemy = 0
	tick = 0
	for i in get_children():
		if i is Minion:
			i.birth_tick = 0
	$StartWaveButton.visible = false
	has_spawned_all = false
	remaining_enemies = waves[current_wave].size()
	is_paused = false

func end_wave():
	is_paused = true
	$RefreshButton.visible = true
	$Label2.visible = false
	ItemSlot.instance.refresh()
	$StartWaveButton.visible = true
	for i in get_children():
		TileManager.instance.clear_level()
		if i is Coin:
			i._on_area_2d_mouse_entered()

func queue_enemy():
	for i in range(13,18):
			if !(TileManager.instance.has_entity_on(Vector2i(i,1))):
				var temp = preload("res://scene_files/enemy.tscn").instantiate()
				if wave_config[current_wave][current_enemy] == 0:
					temp.set_script(preload("res://scripts/enemies/easy.gd"))
				elif wave_config[current_wave][current_enemy] == 1:
					temp.set_script(preload("res://scripts/enemies/medium.gd"))
				TileManager.instance.spawn_enemy_on(temp,Vector2i(i,1))
				return 0
	return queue_enemy()


func _on_start_wave_button_pressed():
	start_wave()
