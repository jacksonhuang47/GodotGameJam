extends Node2D

var next_scene = preload("res://World.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(next_scene)
