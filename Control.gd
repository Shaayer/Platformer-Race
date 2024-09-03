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

var topCameraDistancex=1000
var xZoom=0
var yZoom=0
var topCameraDistancey=550
var xdistance=0
var ydistance=0
var dropDistance=1000
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	posPlayer2=$Player2.position.x
	posPlayer1=$Player.position.x
	posPlayer2y=$Player2.position.y
	posPlayer1y=$Player.position.y
	if posPlayer1y>dropDistance:
		posPlayer1y=dropDistance
	if posPlayer2y>dropDistance:
		posPlayer2y=dropDistance
	$Camera2D.cameraCenter(posPlayer1,posPlayer2)
	$Camera2D.cameraCentery(posPlayer1y,posPlayer2y)
	xdistance=abs(posPlayer2-posPlayer1)
	ydistance=abs(posPlayer2y-posPlayer1y)
	if xdistance>topCameraDistancex:
		xZoom=topCameraDistancex/xdistance
	else:
		xZoom=1
		
	if ydistance>topCameraDistancey:
		yZoom=topCameraDistancey/ydistance
	else:
		yZoom=1
	
	if yZoom<xZoom:
		$Camera2D.zoom.x=yZoom
		$Camera2D.zoom.y=yZoom
	elif xZoom<yZoom:
		$Camera2D.zoom.x=xZoom
		$Camera2D.zoom.y=xZoom
	elif xZoom==yZoom:
		$Camera2D.zoom.x=xZoom
		$Camera2D.zoom.y=xZoom
	
func findDistance():
	var x=abs(posPlayer2-posPlayer1)
	return x
	
	

