class_name Player1

extends CharacterBody2D
@onready var right = $Right
@onready var left = $Left
@onready var wall: RayCast2D = $Wall

const SPEED = 7000
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canJump=false
var onWall="none"
var acceleration=0
func _ready():
	$Area2D.player=self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		left.enabled=true
		right.enabled=true
		canJump=false
		onWall="none"
		acceleration=0
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED
	if direction==-1:
		$Image.flip_h=false
	if direction==1:
		$Image.flip_h=true
	
	velocity.x = lerpf(velocity.x, 0,0.95)
	print(velocity.x)
	#if is_on_wall_only() and velocity.y>0:
		
	if left.is_colliding():
			left.enabled=false
			right.enabled=true
			canJump=true
			onWall="left"
	if right.is_colliding():
			left.enabled=true
			right.enabled=false
			canJump=true
			onWall="right"
	if wall.is_colliding():
		pass
	else:
		canJump=false
	if canJump and velocity.y>0:
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = JUMP_VELOCITY
				canJump=false
				if onWall=="right":
						acceleration=-600
				elif onWall=="left":
						acceleration=600
			else:
				velocity.y=3000*delta
			
	velocity.x+=acceleration
	acceleration=lerpf(acceleration, 0,0.093)
	move_and_slide()
	
func death():
	position=Vector2(63,9)
	
func victory():
	$Label.global_position=Vector2(6368,291)
	$Label.show()
	Engine.time_scale=0
