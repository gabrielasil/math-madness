extends Control

var frame_question = preload("res://Room/FrameQuestion.tscn")
signal question_answered_right(question)
signal question_answered_wrong(question)
onready var vbox_interface = $Panel/MarginContainer/ScrollContainer/VBoxContainer

func _ready():
	self.visible = false

func qst_answered(question : Question, is_right : bool):
	if is_right:
		emit_signal("question_answered_right", question)
	else:
		emit_signal("question_answered_wrong", question)

func _on_question_recived(question: Question):
	var frame_inst = frame_question.instance()
	frame_inst.set_question(question)
	frame_inst.connect("question_answered", self, "qst_answered")
	vbox_interface.add_child(frame_inst)


func _on_Interface_visibility_changed():
	if visible:
		if vbox_interface.get_child_count() > 1:
			vbox_interface.get_child(1).get_child(1).grab_focus()
