extends Enemy

func _ready():
	hp = 4
	atk = 0
	super._ready()

func _tick():
	super._tick()
	if (GameManager.instance.tick - birth_tick) % 2 == 0:
		if !(move(Vector2i(0,1))):
			attack(Vector2i(0,1))
