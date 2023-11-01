extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false

func _on_AnimationPlayer_animation_finished(_anim_name:String):
	get_tree().paused = false
	return get_tree().change_scene("res://Menu/MainMenu.tscn")
