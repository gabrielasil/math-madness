extends Resource
class_name Question

var val1 : int
var val2 : int
var op : String
var answer : int

func get_string_of_question() -> String:
	return str(self.val1) + self.op + str(self.val2) + "=?"

func get_answer() -> int:
	return self.answer


func _init(v1 : int, v2 : int, o : String, ans: int):
	self.val1 = v1
	self.val2 = v2
	self.op = o
	self.answer = ans
