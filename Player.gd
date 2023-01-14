extends KinematicBody2D

# Movement speed in pixels per second.
export var speed := 100
# A factor that controls the character's inertia.
export var friction = 0.02

# We map a direction to a frame index of our AnimatedSprite node's sprite frames.
# See how we use it below to update the character's look direction in the game.
var _sprites := {Vector2.RIGHT: 0, Vector2.LEFT: 2, Vector2.UP: 1, Vector2.DOWN: 3}
var _velocity := Vector2.ZERO
var acceleration := 0

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

func _physics_process(delta):
	var direction := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left"):
		acceleration += 1
	if Input.is_action_pressed("ui_accept") and not acceleration == 0:
		acceleration -= 1
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	# Using the follow steering behavior.
	var target_velocity = direction * speed * (1 + acceleration)
	_velocity += (target_velocity - _velocity) * friction
	_velocity = move_and_slide(_velocity)
	
	


# The code below updates the character's sprite to look in a specific direction.
func _unhandled_input(event):
	if event.is_action_pressed("ui_right"):
		_update_sprite(Vector2.RIGHT)
	elif event.is_action_pressed("ui_left"):
		_update_sprite(Vector2.LEFT)
	elif event.is_action_pressed("ui_down"):
		_update_sprite(Vector2.DOWN)
	elif event.is_action_pressed("ui_up"):
		_update_sprite(Vector2.UP)


func _update_sprite(direction: Vector2) -> void:
	animated_sprite.frame = _sprites[direction]
