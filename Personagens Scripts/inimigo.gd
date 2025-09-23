extends CharacterBody2D

enum State {MOVING_RIGHT, RESTING_RIGHT, MOVING_LEFT, RESTING_LEFT, HUNTING, RESTING_HUNTING}

@export var player:CharacterBody2D
@export var speed:float = 200
@export var gravidade:float = 900
@export var  friction:float = 400
@export var acceleration:float = 650
@export var left_limit:float = -100
@export var right_limit:float = 100
var direction: Vector2

var state = State.MOVING_RIGHT
var start_position:float

func _ready() -> void:
	start_position = global_position.x

func _physics_process(delta: float) -> void:
	Gravidade(delta)
	StateMachine(delta)
	velocity = direction
	move_and_slide()

func Gravidade(delta):
	if not is_on_floor():
		direction.y += gravidade * delta
	else: 
		direction.y = 0

func StateMachine(delta):
	match state:
		State.MOVING_RIGHT:
			direction.x = move_toward(direction.x, speed, acceleration * delta)
			if global_position.x >= start_position + right_limit:
				state = State.RESTING_RIGHT
				$Timer.start(2)
		State.RESTING_RIGHT:
			direction.x = move_toward(direction.x, 0, friction * delta)
		State.MOVING_LEFT:
			direction.x = move_toward(direction.x, -speed, acceleration * delta)
			if global_position.x <= start_position + left_limit:
				state = State.RESTING_LEFT
				$Timer.start(2)
		State.RESTING_LEFT:
			direction.x = move_toward(direction.x, 0, friction * delta)
		State.HUNTING:
			var hunt_direction: float = player.global_position.x - global_position.x
			if hunt_direction > 0:
				direction.x = move_toward(direction.x, speed + 100, acceleration * delta)
			else:
				direction.x = move_toward(direction.x, -(speed + 100), acceleration * delta)
		State.RESTING_HUNTING:
			direction.x = move_toward(direction.x, 0, friction * delta)


func _on_timer_timeout() -> void:
	if state == State.RESTING_RIGHT:
		state = State.MOVING_LEFT
	elif state == State.RESTING_LEFT:
		state = State.MOVING_RIGHT
	elif state == State.RESTING_HUNTING:
		var hunt_direction: float = player.global_position.x - global_position.x
		if hunt_direction > 0:
			state = State.MOVING_LEFT
		else:
			state = State.MOVING_RIGHT
			
#___________________________________Funções de Sinalização do Range de Caçada_________________

func _on_hunt_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("caçando")
		state = State.HUNTING
		
func _on_hunt_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("fugiu")
		state = State.RESTING_HUNTING
		start_position = global_position.x
		$Timer.start()
		

func _on_kill_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.health = false
	
