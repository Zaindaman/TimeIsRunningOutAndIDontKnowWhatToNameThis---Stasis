extends Node
var level_filepath
var current_lvl
func change_level(lvl : String):
	level_filepath = "res://Levels/" + lvl + ".tscn"
	current_lvl = lvl
	get_tree().change_scene_to_file(level_filepath)
	

func get_lvl():
	return current_lvl
