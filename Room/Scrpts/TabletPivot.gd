extends Spatial

signal tablet_on
signal tablet_off

var tablet_rotations = {
	"On": Vector3(90,0,0),
	"Off": Vector3(-30,0,0)
}

export (float) var LOOK_AT_TABLET = 0.6
onready var tablet_tween = $TabletTween
onready var UI = get_parent().get_parent().get_node("UI/Interface")
onready var camera = get_parent().get_parent().get_node("UI/Camera")
onready var sound_on = $TabletSounds/TabletOn
onready var sound_off = $TabletSounds/TabletOff
# Called when the node enters the scene tree for the first time.
func _ready():
	self.rotation_degrees = tablet_rotations["Off"]


func toggleTablet():
	if self.rotation_degrees == tablet_rotations["Off"]:
		tablet_tween.interpolate_property(self,"rotation_degrees",
			self.rotation_degrees,tablet_rotations["On"], LOOK_AT_TABLET, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		emit_signal("tablet_on")
		sound_on.play()
		tablet_tween.start()
		
	elif self.rotation_degrees == tablet_rotations["On"]:
		tablet_tween.interpolate_property(self,"rotation_degrees",
			self.rotation_degrees,tablet_rotations["Off"], LOOK_AT_TABLET, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		emit_signal("tablet_off")
		sound_off.play()
		tablet_tween.start()
			
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_select") and camera.rotation_degrees == Vector3.ZERO:
		toggleTablet()



func _on_TabletTween_tween_completed(object, _key):
	if object.rotation_degrees == tablet_rotations["On"]:
		UI.visible = true
		UI.set_process_input(true)


func _on_TabletTween_tween_started(object, _key):
	if object.rotation_degrees == tablet_rotations["On"]:
		get_parent().get_parent().get_node("UI/Interface").visible = false
		UI.set_process_input(false)

