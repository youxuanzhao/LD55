extends Node2D


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene_files/main.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://scene_files/tutorial.tscn")
