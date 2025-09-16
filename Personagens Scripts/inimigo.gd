extends CharacterBody2D


enum State {MOVING_RIGHT, RESTING_RIGHT, MOVING_LEFT, RESTING_LEFT}

@export var speed:float = 200
@export var gravidade:float = 900
@export var  friction:float = 500
@export var acceleration:float = 750
@export var left_limit:float = -100
@export var right_limit:float = 100
var direction: Vector2


var state = State.MOVING_RIGHT
var start_position:float
 
func _ready() -> void:
	start_position = global_position.x
	$Timer.connect("timeout",Callable(self,"_on_timer_timeout"))

func _physics_process(delta: float) -> void:
	Gravidade(delta)
	Patrol(delta)
	velocity = direction
	move_and_slide()

func Gravidade(delta):
	if not is_on_floor():
		direction.y += gravidade * delta
	else: 
		direction.y = 0

func Patrol(delta):
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



func _on_timer_timeout() -> void:
	if state == State.RESTING_RIGHT:
		state = State.MOVING_LEFT
	elif state == State.RESTING_LEFT:
		state = State.MOVING_RIGHT
