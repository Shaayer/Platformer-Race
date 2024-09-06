class_name Player2

extends CharacterBody2D
@onready var right = $Right2
@onready var left = $Left2
@onready var wall: RayCast2D = $Wall2

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canJump=false
func _ready():
	$Area2D.player=self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		left.enabled=true
		right.enabled=true

	# Handle jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#if is_on_wall_only() and velocity.y>0:
		
	if left.is_colliding():
			left.enabled=false
			right.enabled=true
			canJump=true
			print("left")
	if right.is_colliding():
			left.enabled=true
			right.enabled=false
			canJump=true
			print("right")
	if wall.is_colliding():
		print("wall")
	else:
		canJump=false
	if canJump and velocity.y>0:
			if Input.is_action_just_pressed("w"):
				velocity.y = JUMP_VELOCITY
				canJump=false
			else:
				velocity.y=3000*delta
			
	move_and_slide()
	
func death():
	position=Vector2(82,9)

func victory():
	$Label2.show()
	$Label2.global_position=Vector2(3342+108,389+9)
	Engine.time_scale=0
	
func disable():
	hide()
	set_collision_layer_value(1,false)

func enable():
	show()
	set_collision_layer_value(1,true)
	
