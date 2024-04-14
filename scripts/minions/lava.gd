extends Minion

@export var max_hp : int = 1
@export var init_atk : int = 3
@export var movespeed : int = 2
@export var atkspeed : int = 2


func _ready():
	hp = max_hp
	atk = init_atk
	lifespan = 1
	super._ready()

func _tick():
	super._tick()
	attack(Vector2i(1,1))
	attack(Vector2i(1,-1))
	attack(Vector2i(0,1))
	attack(Vector2i(0,-1))
	attack(Vector2i(1,0))
	attack(Vector2i(-1,0))
	attack(Vector2i(-1,1))
	attack(Vector2i(-1,-1))

