extends Enemy

func _ready():
	level = 1
	hp = 4
	atk = 2
	super._ready()

func _tick():
	super._tick()
	if (GameManager.instance.tick - birth_tick) % 3 == 0:
		attack(Vector2i(0,1))
	if (GameManager.instance.tick - birth_tick) % 3 == 0:
		move(Vector2i(0,1))
