extends KinematicBody2D

var speed = 5
var velocity := Vector2(0,0) #
var lastFrameVelocity = Vector2(0,0)
var InputMovement = Vector2(0,0)

func _ready():
	pass

func _unhandled_input(event):
	pass

func _input(event):
	pass

func _physics_process(delta):
	
	lastFrameVelocity = velocity #Tentative #1 du système d'inertie.
#	Definition de InputMovement comme étant le vector2 représentant les inputs du joueur.
	InputMovement = Vector2(0 + int(Input.is_action_pressed("Krigh")) - int(Input.is_action_pressed("Kleft")),0 + int(Input.is_action_pressed("Kdown")) - int(Input.is_action_pressed("Kup")))

#	Normalization du mouvement pour s'assurer que la vitesse ne dépasse pas :
	if(InputMovement.length() >1):
		InputMovement = InputMovement.normalized()
	
#	Application du mouvement :
	velocity = lastFrameVelocity + InputMovement
	self.position += velocity * 0.3
	
	
