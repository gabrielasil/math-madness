extends Spatial
class_name Animatronic
enum QUESTION_DIFICULTY{
	BEGINNER,
	INTERMEDIATE,
	EXPERT
}

var intermediate_qsts = [
	Question.new(98,3,"+",101),
	Question.new(79,6,"+",85),
	Question.new(94,5,"+",99),
	Question.new(38,6,"+",44),
	Question.new(28,2,"+",30),
	Question.new(16,3,"+",19),
	Question.new(96,4,"+",100),
	Question.new(46,7,"+",53)
]

var begginer_qsts = [ 
		Question.new(5,6,"+",11),
		Question.new(7,5,"+",12),
		Question.new(9,7,"+",16),
		Question.new(3,5,"+",8),
		Question.new(6,2,"+",8),
		Question.new(1,6,"+",7),
		Question.new(4,2,"+",6),
		Question.new(8,7,"+",15),
		Question.new(1,5,"+",6),
		Question.new(9,6,"+",15),
		Question.new(7,6,"+",13),
		Question.new(9,5,"+",14),
		Question.new(1,4,"+",5),
		Question.new(9,3,"+",12),
		Question.new(5,2,"+",7),
		Question.new(8,4,"+",12),
		Question.new(1,2,"+",3),
		Question.new(3,6,"+",9),
		Question.new(8,2,"+",10),
		Question.new(8,6,"+",14),
		Question.new(2,7,"+",9),
		Question.new(9,2,"+",11),
		Question.new(8,3,"+",11),
		Question.new(3,7,"+",10),
		Question.new(7,3,"+",10),
		Question.new(2,3,"+",5),
		Question.new(4,7,"+",11),
		Question.new(1,7,"+",8),
		Question.new(3,4,"+",7),
		Question.new(1,3,"+",4),
		Question.new(6,4,"+",10),
		Question.new(9,4,"+",13),
		Question.new(8,5,"+",13),
		Question.new(5,4,"+",9)
	]
	

var operation = "+"
onready var void_area : Area = get_node("/root/Room/RoomObjects/VoidArea")
var voidPos = Vector3(0,0,30)
var time_tolerance = 8
var on_void = true

func get_a_question(difficulty : int):
	if difficulty == QUESTION_DIFICULTY.BEGINNER:
		return begginer_qsts.pop_front()
	elif difficulty == QUESTION_DIFICULTY.INTERMEDIATE:
		return intermediate_qsts.pop_front()
	else:
		return null

func is_not_on_void():
	return on_void
	
func _on_VisibilityNotifier_camera_entered(_camera):
	$Breath.stop()

func _ready():
	self.global_transform.origin = voidPos

func move_to_void():
	self.global_transform.origin = voidPos

func move_to_pos(p3D : Position3D):
	self.rotation_degrees = p3D.rotation_degrees
	self.transform = p3D.transform
	on_void = false


func _on_VoidArea_body_exited(_body:Node):
	self.on_void = false


func _on_VoidArea_body_entered(_body:Node):
	self.on_void = true
