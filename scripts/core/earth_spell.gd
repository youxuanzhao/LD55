extends Node2D

@onready var icon = $Icon
@onready var frame = $Frame
@onready var timer = $Timer
@onready var cooldown = $Cooldown

var quality : int = 1
@export var default_cooldown : float = 2.0 
@export var cooldown_reduce : float = 0.2 #Cooldown reduction each level
var is_in_cooldown : bool = false


func _process(delta):
	frame.frame = GameManager.instance.earth_level
	
	if is_in_cooldown:
		cooldown.scale.y = timer.time_left / (default_cooldown-GameManager.instance.earth_level*cooldown_reduce)
	
	if Input.is_action_just_pressed("earth_spell") and !(is_in_cooldown) and !(GameManager.instance.is_paused):
		$AudioStreamPlayer2D.play()
		GameManager.instance.add_earth()
		start_cooldown()
		

func start_cooldown():
	is_in_cooldown = true
	timer.start(default_cooldown-GameManager.instance.earth_level*cooldown_reduce)
	cooldown.visible = true


func _on_timer_timeout():
	is_in_cooldown = false
	cooldown.visible = false
