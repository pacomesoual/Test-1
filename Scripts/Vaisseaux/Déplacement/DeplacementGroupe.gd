extends KinematicBody2D

var speed = 5
var velocity := Vector2(0,0) #vitesse appliqué a l'objet chaque frame
var lastFrameVelocity = Vector2(0,0) #Vitesse qui a été appliqué a l'objet a la derniere frame
var InputMovement = Vector2(0,0) #vecteur représentant l'input.

func _ready():
	pass

func _unhandled_input(event):
	pass

func _input(event):
	pass

func _physics_process(delta):
#	Definition de InputMovement comme étant le vector2 représentant les inputs du joueur.
	InputMovement = Vector2(0 + int(Input.is_action_pressed("Kright")) - int(Input.is_action_pressed("Kleft")),0 + int(Input.is_action_pressed("Kdown")) - int(Input.is_action_pressed("Kup")))

#	Normalization du mouvement pour s'assurer que la vitesse ne dépasse pas :
	if(InputMovement.length() >1):
		InputMovement = InputMovement.normalized()
		
#	Le freinage has arrived :
	if(Input.is_action_pressed("Kbrake")):
		if (-1 <lastFrameVelocity.length() and lastFrameVelocity.length() < 1): #check si la velocity est suffisament basse pour que quoi que ce soit a 1 créer un effet yoyo.
			InputMovement = Vector2(-lastFrameVelocity.x,-lastFrameVelocity.y)
		else:
			var absolute = abs(lastFrameVelocity.x) + abs(lastFrameVelocity.y)
			var ratioX = lastFrameVelocity.x/absolute
			var ratioY = lastFrameVelocity.y/absolute
			InputMovement.x = -ratioX
			InputMovement.y = -ratioY

#	Application du mouvement :
	velocity = lastFrameVelocity + InputMovement
	
	lastFrameVelocity = velocity #Tentative #1 du système d'inertie.
	
	self.position += velocity * 0.3
