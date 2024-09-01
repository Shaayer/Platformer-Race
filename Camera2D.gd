extends Camera2D

func cameraCenter(pos1,pos2):
	var x=(pos1+pos2)/2
	position.x=x
	
func cameraCentery(pos1,pos2):
	var x=(pos1+pos2)/2
	position.y=x
	if position.y>900:
		position.y=900
