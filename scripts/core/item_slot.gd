class_name ItemSlot
extends Node2D


var current_item : int = 0
var current_price : int = 0

var is_hovering : bool = false

static var instance : ItemSlot

const item_list = ["fire_orb","water_orb","earth_orb","summon_orb","heart","fruit"]
const desc_list = ["Reduce Fire Cooldown", "Reduce Water Cooldown", "Reduce Earth Cooldown", "Reduce Summon Cooldown", "Increase Minion Health", "Incerase Minion Attack"]
const price_list = [5,5,5,10,15,15]

func _ready():
	instance = self

func refresh():
	current_item = randi_range(0,5)
	
	if (current_item == 0 and GameManager.instance.fire_level == 3) or (current_item == 1 and GameManager.instance.water_level == 3) or (current_item == 2 and GameManager.instance.earth_level == 3) or (current_item == 3 and GameManager.instance.summon_level == 3):
		return refresh()
	
	visible = true
	$ItemSprite.texture = load(str("res://asset/",item_list[current_item],".png"))
	$Desc.text = desc_list[current_item]
	$Price.text = str(price_list[current_item])
	
func _process(delta):
	if is_hovering and Input.is_action_just_pressed("left_mouse"):
		purchase()

func _on_area_2d_mouse_entered():
	is_hovering = true

func purchase():
	if GameManager.instance.total_coins >= price_list[current_item]:
		visible = false
		if current_item == 0:
			GameManager.instance.upgrade_fire()
			GameManager.instance.total_coins -= price_list[current_item]
		elif current_item == 1:
			GameManager.instance.upgrade_water()
			GameManager.instance.total_coins -= price_list[current_item]
		elif current_item == 2:
			GameManager.instance.upgrade_earth()
			GameManager.instance.total_coins -= price_list[current_item]
		elif current_item == 3:
			GameManager.instance.upgrade_summon()
			GameManager.instance.total_coins -= price_list[current_item]
		elif current_item == 4:
			GameManager.instance.upgrade_health()
			GameManager.instance.total_coins -= price_list[current_item]
		elif current_item == 5:
			GameManager.instance.upgrade_attack()
			GameManager.instance.total_coins -= price_list[current_item]

func _on_area_2d_mouse_exited():
	is_hovering = false


func _on_texture_button_pressed():
	if GameManager.instance.total_coins >= 2:
		GameManager.instance.total_coins -= 2
		refresh()
