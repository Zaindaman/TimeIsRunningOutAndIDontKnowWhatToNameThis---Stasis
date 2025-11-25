extends Control


func _on_button_pressed() -> void:
	var current_lvl = LevelManager.get_lvl()
	LevelManager.change_level(current_lvl + 1)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
