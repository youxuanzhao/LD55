extends Minion

func _ready():
	hp = 2
	atk = 6
	super._ready()

func _tick():
	super._tick()
	move(Vector2i(0,-1))
