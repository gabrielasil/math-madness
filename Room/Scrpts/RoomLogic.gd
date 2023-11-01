extends Node

var hour = 0
var minute = 0


enum QUESTION_DIFICULTY	{ 
	BEGINNER,
	INTERMEDIATE,
	EXPERT
}
var night1_gameplay = {
	0 : QUESTION_DIFICULTY.BEGINNER,
	1 : QUESTION_DIFICULTY.BEGINNER, 
	2 : QUESTION_DIFICULTY.BEGINNER, 
	3 : QUESTION_DIFICULTY.BEGINNER, 
	4 : QUESTION_DIFICULTY.INTERMEDIATE,
	5 : QUESTION_DIFICULTY.INTERMEDIATE,
	6 : QUESTION_DIFICULTY.INTERMEDIATE 
}
export(float) var weak_range = 9.0
var rng = RandomNumberGenerator.new()
onready var doors = [ $PosLeftDoor, $PosRightDoor]
onready var doors_v = [ $LeftDoorVisibility, $RightDoorVisibility]

onready var addy = $Addy
onready var posvoid = $PosVoid
var addy_questions = 0 
var addy_difficulty = QUESTION_DIFICULTY.BEGINNER
export(int) var addy_prob = 20

var minus_questions = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	rng.randomize()


func add_to_the_queue(question : Question):
	if question.op == "+":
		addy_questions += 1

func take_a_question(animatronic : Animatronic, difficulty : int):
	var question : Question = animatronic.get_a_question(difficulty)
	if question == null:
		return
	get_parent().get_node("UI/Interface")._on_question_recived(question)
	add_to_the_queue(question)
	
func spawn_animatronic(animatronic : Animatronic, pos : Position3D, visibility_obj : VisibilityNotifier):
	if animatronic.transform != pos.transform:
		if visibility_obj.is_on_screen():
			$OmniLight.omni_range = weak_range
			animatronic.move_to_pos(pos)
			$OmniLight/LightTimer.start()
		else:
			animatronic.move_to_pos(pos)
			$Addy/Breath.play()
	if $Addy/A_TimeToCountdown.is_stopped():
		$Addy/A_TimeToCountdown.start()
		

func _on_RealTimeToGameTime_timeout():
	minute += 1
	if minute == 6:
		minute = 0
		hour += 1
		addy_difficulty = night1_gameplay[hour]
	if rng.randi_range(1,10) > 6:
		var selected_door = rng.randi_range(0,1)
		var door = doors[selected_door]
		var door_v = doors_v[selected_door]
		$Addy/VisibilityTimer.start()
		spawn_animatronic($Addy, door, door_v)
		addy_prob -= 1


func _process(_delta):
	if hour == 6:
		var win_node = get_parent().get_node("UI/WinScreen")
		win_node.visible = true
		win_node.get_node("AnimationPlayer").play("win_screen")
		get_tree().paused = true



func _on_Interface_question_answered_right(question : Question):
	if question.op == "+":
		addy_questions -= 1
		if addy_questions == 0:
			if $Addy/AddyAnimation.current_animation == "certain_death":
				$Addy/AddyAnimation.stop()
			$Addy/Breath.stop()
			$Addy/A_TimeToCountdown.stop()
			$Addy.move_to_void()

func _on_LightTimer_timeout():
	$OmniLight.omni_range = 15.5


func _on_Interface_question_answered_wrong(question : Question):
	if question.op == "+":
		get_parent().get_node("UI/Camera").rotation_degrees = Vector3.ZERO
		$TabletPivot.visible = false
		get_parent().get_node("UI/Interface").visible = false
		AudioServer.set_bus_mute(2, true)
		get_parent().get_node("Sounds/Jumpscare").play()
		$Addy/Breath.stop()
		$Addy/AddyAnimation.play("jumpscare")
		yield($Addy/AddyAnimation, "animation_finished")
		get_parent().get_node("UI/Game Over Screen").visible = true
		get_parent().get_node("UI/Game Over Screen/GameOverAnimation").play("TextAppear")
		get_tree().paused = true
	
func _on_A_TimeToCountdown_timeout():
	$Addy/AddyAnimation.play("certain_death")

func _on_Addy_visible(_camera:Camera):
	if not $Addy/VisibilityTimer.is_stopped():
		$Addy/VisibilityTimer.stop()
		if $Addy/AddyAnimation.current_animation == "time_running_out":
			$Addy/AddyAnimation.play("RESET_JMP")
		take_a_question($Addy, addy_difficulty)

func _on_VisibilityTimer_timeout():
	$Addy/AddyAnimation.play("time_running_out")

func _on_Addy_animation_finished(anim_name:String):
	if anim_name == "time_running_out":
		_on_Interface_question_answered_wrong(Question.new(0,0,"+",0))
	elif anim_name == "certain_death":
		_on_Interface_question_answered_wrong(Question.new(0,0,"+",0))

