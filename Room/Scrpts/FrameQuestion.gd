extends VBoxContainer
class_name FrameQuestion
var acceptable_characters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

var question_for_the_frame : Question
signal question_answered(question, is_right)

func set_question(question : Question):
	self.question_for_the_frame = question
	$Title.text = self.question_for_the_frame.get_string_of_question()

func _on_UserAnswer_text_entered(new_text:String):
	if int(new_text) == question_for_the_frame.get_answer():
		emit_signal("question_answered", question_for_the_frame, true)
	else:
		emit_signal("question_answered", question_for_the_frame, false)
	self.queue_free()

func _on_UserAnswer_text_changed(new_text : String):
	for letter in new_text:
		if not letter in acceptable_characters:
			$UserAnswer.text = new_text.replace(letter, "")


