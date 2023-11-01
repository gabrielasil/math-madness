extends Control


func _on_GameOverAnimation_animation_finished(_anim_name):
	get_tree().paused = false
	return get_tree().change_scene("res://Menu/MainMenu.tscn")
