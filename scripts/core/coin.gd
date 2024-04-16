class_name Coin
extends Sprite2D

var collector : Sprite2D

func add_coin():
	GameManager.instance.total_coins += 1


func _on_area_2d_mouse_entered():
	$AudioStreamPlayer2D.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", collector.position, 0.5)
	tween.tween_callback(self.add_coin)
	tween.tween_callback(self.queue_free)

