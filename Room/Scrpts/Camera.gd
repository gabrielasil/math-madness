extends Camera

onready var camera_tween = $CameraTween
var looking_at_tablet = false

export (float) var LOOK_SPEED = 0.8

var camera_rotations = {
	"Normal": Vector3(0,0,0),
	"Up": Vector3(45,0,0),
	"Left": Vector3(0,45,0),
	"Right": Vector3(0,-45,0)
}

func _ready():
	self.rotation_degrees = camera_rotations["Normal"]

func look(camera_rotation):
	camera_tween.interpolate_property(self,"rotation_degrees",self.rotation_degrees, camera_rotation, LOOK_SPEED, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	camera_tween.start()


func _process(_delta):
	if not looking_at_tablet:
		if Input.is_action_just_pressed("ui_up"):
			look(camera_rotations["Up"])

		if Input.is_action_just_pressed("ui_left"):
			look(camera_rotations["Left"])

		if Input.is_action_just_pressed("ui_right"):
			look(camera_rotations["Right"])

		if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
			look(camera_rotations["Normal"])


func _on_TabletPivot_tablet_off():
	looking_at_tablet = false

func _on_TabletPivot_tablet_on():
	looking_at_tablet = true
