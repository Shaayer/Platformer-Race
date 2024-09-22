extends Control
var distance=0
var boxScene= preload("res://box.tscn")
# 2 player platformer, wasd and arrows keys, race
var posPlayer1;
var posPlayer2;
var posPlayer1y;
var posPlayer2y;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player2.disable()

var topCameraDistancex=1000
var xZoom=0
var yZoom=0
var topCameraDistancey=550
var xdistance=0
var ydistance=0
var dropDistance=1000
var singlePlayer=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("2"):
		singlePlayer=false
		$Player2.enable()
		$Player.death()
		$Player2.death()
		$Label.time=0.0
	if Input.is_action_pressed("1"):
		singlePlayer=true
		$Player2.disable()
		$Player.death()
		$Label.time=0.0
	if Input.is_action_pressed("r"):
		$Player.death()
		$Player2.death()
		$Label.time=0.0
		var oldBox=$Box
		oldBox.name="Delete"
		oldBox.queue_free()
		var box = boxScene.instantiate()
		add_child(box)
		
		
		
	
	if singlePlayer==false:
		
		
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
	else:
		$Camera2D.position=$Player.position
		
	
func findDistance():
	var x=abs(posPlayer2-posPlayer1)
	return x
	
	
