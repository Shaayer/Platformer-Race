extends Label

var time=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time+=delta
	text=str(watch(time))

func watch(time):
	time=time*10
	time=floor(time)
	time=time/10
	return time
