extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

const SPEED = 300.0
const PUSH_SPEED = 150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()

func _physics_process(delta):
	var motion = Vector2.ZERO
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
#	if Input.is_action_pressed("ui_left"):
#		motion.x = -1
#	elif Input.is_action_pressed("ui_right"):
#		motion.x = 1
#	elif Input.is_action_pressed("ui_up"):
#		motion.y = -1
#	elif Input.is_action_pressed("ui_down"):
#		motion.y = 1
#	position += motion.normalized() * SPEED * delta
#	velocity = motion.normalized() * SPEED
	position += motion.normalized() * SPEED * delta

	update_animation(motion)
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		check_box_collision(motion)


func update_animation(motion: Vector2) -> void:
	var animation = ""
	if motion.x < 0:
		animation = "left"
	if motion.x > 0:
		animation = "right"
	if motion.y < 0:
		animation = "up"
	if motion.y > 0:
		animation = "down"
	if motion.x == 0 and motion.y == 0 and not animated_sprite_2d.animation.ends_with("idle"):
		animation = animated_sprite_2d.animation + "_idle"
	if animation != "" and animated_sprite_2d.animation != animation:
		animated_sprite_2d.animation = animation
		animated_sprite_2d.play()

func check_box_collision(motion: Vector2) -> void:
	if abs(motion.x) + abs(motion.y) > 1:
		return
	var box := get_slide_collision(0).get_collider() as Box
	if box:
		box.push(motion.normalized() * SPEED)
	pass
