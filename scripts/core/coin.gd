class_name Coin
extends Sprite2D

var collector : Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_coin():
	GameManager.instance.total_coins += 1

func _on_area_2d_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", collector.position, 0.5)
	tween.tween_callback(self.add_coin)
	tween.tween_callback(self.queue_free)

