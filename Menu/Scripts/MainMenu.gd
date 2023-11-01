extends Control

onready var fadetween = $FadeTween

onready var hover = $Sounds/Hover
onready var select = $Sounds/Select
onready var start = $Sounds/StartGame

enum {HOVER, SELECT, START_GAME}

func _ready():
	pass


func play_sound(act):
	if act == HOVER:
		hover.play()
	elif act == SELECT:
		select.play()
	else:
		start.play()

func start_game():
	return get_tree().change_scene("res://Room/Room.tscn")

func _on_Options_mouse_entered():
	play_sound(HOVER)

func _on_StartGame_mouse_entered():
	play_sound(HOVER)

func _on_Exit_mouse_entered():
	play_sound(HOVER)
	
func _on_StartGame_pressed():
	start_game()

func _on_Options_pressed():
	play_sound(SELECT)

func _on_Exit_pressed():
	play_sound(SELECT)
	get_tree().quit()
