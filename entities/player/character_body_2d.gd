extends CharacterBody2D

# Set the character's movement speed
var speed = 75

# Set the character's horizontal direction (left or right)
var direction = 0.0

# Set the character's jump force
var jump = 300

# Set a temporary speed multiplier for the character
var temp_speed_multiplier = 1.0

# Set a flag to track whether the character is currently jumping
var is_jumping = false

# Set a flag to track whether the character is currently running
var is_running = false

# Set the strength of gravity affecting the character
const gravity = 20

# Set the initial vertical velocity when the character jumps
const JUMP_VELOCITY = -300.0

# Set the character's dash speed
const dashspeed = 300

# Set the length of the character's dash
const dashlenght = 1

# Initialize the character's animated sprite node
@onready var anim = $AnimatedSprite2D

# Initialize the character's sprite node
@onready var sprite = $AnimatedSprite2D

# Add the multiplayer code
func _enter_tree():
	set_multiplayer_authority(name.to_int())

# Called every physics frame to update the character's movement and animation
func _physics_process(_delta):

	# Update the character's horizontal direction based on input
	direction = Input.get_axis("ui_left","ui_right")

	# Set the character's horizontal velocity based on its direction and speed
	velocity.x = direction * speed * temp_speed_multiplier

	# Increase the character's speed temporarily if the up arrow key is pressed
	if Input.is_action_pressed("ui_up"):
		temp_speed_multiplier = 4
	else:
		temp_speed_multiplier = 1.0
		is_running = false

	# Make the character jump if the 'X' key is pressed and the character is on the floor
	if Input.is_action_just_pressed("ui_x") and (is_on_floor() or is_running):
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Update the character's animation based on its current state
	if is_jumping and velocity.y > 0:
		anim.play("Afall")
	elif is_jumping and velocity.y < 0:
		anim.play("Ajump")
	elif direction != 0:
		anim.play("Arun")
	else:
		anim.play("Aidle")

	# Flip the character's sprite horizontally based on its direction
	sprite.flip_h = direction < 0 if direction != 0 else sprite.flip_h

	# Apply gravity to the character's vertical velocity if it is not on the floor
	if!is_on_floor(): 
		velocity.y += gravity

	# Update the character's movement based on its velocity
	move_and_slide()

	# Reset the character's jumping flag if it is on the floor and was previously jumping
	if is_on_floor() and is_jumping:
		is_jumping = false

	# Update the character's movement based on its velocity
	move_and_slide()
