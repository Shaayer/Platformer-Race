extends Control
var distance=0
# 2 player platformer, wasd and arrows keys, race
var posPlayer1;
var posPlayer2;
var posPlayer1y;
var posPlayer2y;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var topCameraDistance=1000
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	posPlayer2=$Player2.position.x
	posPlayer1=$Player.position.x
	posPlayer2y=$Player2.position.y
	posPlayer1y=$Player.position.y
	$Camera2D.cameraCenter(posPlayer1,posPlayer2)
	$Camera2D.cameraCentery(posPlayer1y,posPlayer2y)
	distance=findDistance()
	if distance>topCameraDistance:
		$Camera2D.zoom.x=topCameraDistance/distance
		$Camera2D.zoom.y=topCameraDistance/distance
	
func findDistance():
	var x=abs(posPlayer2-posPlayer1)
	return x
	
	

