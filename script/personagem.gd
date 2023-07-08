extends CharacterBody2D


@export var speed = 2000
@export var rotation_speed = 1.5
@export var acceleration = 0

var rotation_dir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("res://cenas/acelerador.tscn").acelerar_signal.conect(_on_acelerador_acelerar_signal)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	input()
	move(delta)
	
func input():
	if velocity.x < 0:
		velocity +=  (Vector2(speed, 0).rotated(rotation))/100
	if velocity.x > 0:
		velocity = Vector2.ZERO
		
	if rotation_dir > 10:
		rotation_dir = 0
		
	rotation_dir = 0
	
	if Input.is_action_pressed("left"):
		rotation_dir += 1
		
	if Input.is_action_pressed("right"):
		rotation_dir -= 1

func move(delta):
	if acceleration <= 0:
		acceleration = 0
	rotation += rotation_dir * rotation_speed * delta
	velocity.normalized()
	move_and_slide()

func deceleration():
	if acceleration > 0:
		$Timer.start()


func _on_timer_timeout():
	acceleration -= 0.5




	


func _on_acelerador_acelerar_signal():
	deceleration()
	if acceleration < 4:
		acceleration += 0.3
	velocity =  -(Vector2(speed, 0).rotated(rotation) * acceleration)
	velocity.normalized()
	move_and_slide()
