extends Node2D

@onready var icon = $Icon
@onready var frame = $Frame
@onready var timer = $Timer
@onready var cooldown = $Cooldown

var quality : int = 1
@export var default_cooldown : float = 3.0
@export var cooldown_reduce : float = 0.2
var is_in_cooldown : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame.frame = GameManager.instance.summon_level
	
	if is_in_cooldown:
		cooldown.scale.y = timer.time_left / (default_cooldown-GameManager.instance.summon_level*cooldown_reduce)
	
	if Input.is_action_just_pressed("summon") and !(is_in_cooldown) and !(GameManager.instance.is_paused):
		$AudioStreamPlayer2D.play()
		if GameManager.instance.summon():
			start_cooldown()
		

func start_cooldown():
	is_in_cooldown = true
	timer.start(default_cooldown-GameManager.instance.summon_level*cooldown_reduce)
	cooldown.visible = true


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($Icon.get_material(), "shader_parameter/flash", 1.0, 0.1)
	tween.tween_property($Icon.get_material(), "shader_parameter/flash", 0.0, 0.1)
	is_in_cooldown = false
	cooldown.visible = false

