class_name Player2

extends CharacterBody2D
@onready var right = $Right2
@onready var left = $Left2
@onready var wall: RayCast2D = $Wall2

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
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x += direction * SPEED
	if direction==-1:
		$Image.flip_h=false
	if direction==1:
		$Image.flip_h=true
	velocity.x = lerpf(velocity.x, 0,0.95)
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
			if Input.is_action_just_pressed("w"):
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
	position=Vector2(108,10)
	
func disable():
	hide()
	set_collision_layer_value(1,false)

func enable():
	show()
	set_collision_layer_value(1,true)
	
	
func victory():
	$Label2.global_position=Vector2(7182,248)
	$Label2.show()
	Engine.time_scale=0
	
func _on_push_hit_box_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		body.apply_impulse(velocity)
