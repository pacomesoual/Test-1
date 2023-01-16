extends KinematicBody2D


# ------------------------------------------------------ #
# ------------------ Déplacement ----------------------- #
# ------------------------------------------------------ #


var velocity := Vector2() 
var lastFrameVelocity = Vector2()
var InputMovement = Vector2()
var _sprites := {Vector2.RIGHT: 0, Vector2.LEFT: 2, Vector2.UP: 1, Vector2.DOWN: 3}

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

func _physics_process(delta):

#    Definition de InputMovement comme étant le vector2 représentant les inputs du joueur.
	InputMovement = Vector2(0 + int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")), 0 + int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	
#    Normalization du mouvement pour s'assurer que la vitesse ne dépasse pas :
	if(InputMovement.length() >1):
		 InputMovement = InputMovement.normalized()
		
	if  Input.is_action_pressed("ui_accept") :
		if velocity.x <= 0 :
			velocity.x += 1
		if velocity.x >= 0 :
			velocity.x -= 1
		if velocity.y >= 0 :
			velocity.y -= 1
		if velocity.y <= 0 :
			velocity.y += 1
		
		if velocity.x < 1 and velocity.x > -1 :
			velocity.x = 0
		if velocity.y < 1 and velocity.y > -1 :
			velocity.y = 0
			
#    Application du mouvement :
	velocity += InputMovement
	print(velocity)
	self.position += velocity * 0.05
	
	

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
	
# ------------------------------------------------------ #
# ------------------ Déplacement ----------------------- #
# ------------------------------------------------------ #
