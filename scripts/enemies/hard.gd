extends Enemy

func _ready():
	level = 2
	hp = 10
	atk = 4
	super._ready()

func _tick():
	super._tick()
	if (GameManager.instance.tick - birth_tick) % 5 == 0:
		if !(move(Vector2i(0,1))):
			attack(Vector2i(0,1))