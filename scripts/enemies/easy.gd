extends Enemy

func _ready():
	level = 0
	hp = 3
	atk = 1
	super._ready()

func _tick():
	super._tick()
	if (GameManager.instance.tick - birth_tick) % 3 == 0:
		attack(Vector2i(0,1))
	if (GameManager.instance.tick - birth_tick) % 5 == 0:
		move(Vector2i(0,1))

			
