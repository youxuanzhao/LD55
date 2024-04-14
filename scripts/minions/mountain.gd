extends Minion

@export var max_hp : int = 7
@export var init_atk : int = 2
@export var movespeed : int = 6
@export var atkspeed : int = 1


func _ready():
	hp = max_hp
	atk = init_atk
	super._ready()

func _tick():
	super._tick()
	if (GameManager.instance.tick - birth_tick) % atkspeed == 0: 
		attack(Vector2i(0,-1))
	if (GameManager.instance.tick - birth_tick) % movespeed == 0:
		if !(move(Vector2i(1,0))):
			move(Vector2i(-1,0))