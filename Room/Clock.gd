extends Control


var hour = 0
var minutes = 0
var has_dots = true


# Called when the node enters the scene tree for the first time.




func _on_Blinker_timeout():
	var hour_end
	if self.has_dots:
		hour_end = ":00"
	else:
		hour_end = " 00"
	$ClockText.text = str(hour) + hour_end
	self.has_dots = not self.has_dots


func _on_RealTimeToGameTime_timeout():
	if minutes + 1 == 6:
		hour += 1
		minutes = 0
	else:
		minutes += 1
