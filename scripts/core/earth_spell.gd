extends Node2D

@onready var icon = $Icon
@onready var frame = $Frame
@onready var timer = $Timer
@onready var cooldown = $Cooldown

var quality : int = 1
var default_cooldown : float = 2.0
var is_in_cooldown : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if is_in_cooldown:
		cooldown.scale.y = timer.time_left / default_cooldown
	
	if Input.is_action_just_pressed("earth_spell") and !(is_in_cooldown) and !(GameManager.instance.is_paused):
		GameManager.instance.add_earth()
		start_cooldown()
		

func start_cooldown():
	is_in_cooldown = true
	timer.start(default_cooldown)
	cooldown.visible = true


func _on_timer_timeout():
	is_in_cooldown = false
	cooldown.visible = false
