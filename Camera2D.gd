extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cameraCenter(pos1,pos2):
	var x=(pos1+pos2)/2
	position.x=x
	
func cameraCentery(pos1,pos2):
	var x=(pos1+pos2)/2
	position.y=x
