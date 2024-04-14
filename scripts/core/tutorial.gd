extends Node2D


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://scene_files/start_screen.tscn")
