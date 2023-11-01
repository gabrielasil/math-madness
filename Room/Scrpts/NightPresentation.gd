extends Control

func _ready():
	$AnimationPlayer.play("Show Night")



func _on_AnimationPlayer_animation_finished(_anim_name):
	get_tree().paused = false
	self.queue_free()
