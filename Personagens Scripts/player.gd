extends CharacterBody2D


#-------------------------------------------  MOVIMENTO  -------------------------------------------
@export var max_speed : float = 350  ##irá definir a velocidade máxima dp jogador
var acceleration : float  = 550  ##define o quão rápido o jogador chega na velocidade máxima
var friction : float = 500  ##define o quão rápido o jogador para 
#-------------------------------------------  PULO  -------------------------------------------
@export var jump : float = -650   ##define a força do pulo (valor negativo no eixo y na Godot significa que vai para cima)
var jump_cut : float = 0.5  ##fator que "corta" a velocidade do pulo quando o botão é solto
#-------------------------------------------
@export var gravity : float = 900  ##define o valor da gravidade (valor positivo no eixo y significa que vai para baixo)
##Delta = 1/Frame Rate(Hz)

#-------------------------------------------

func _ready() -> void:
	add_to_group("Player")
	
	
func _physics_process(delta):  ##função da Godot que é chamada em intervalos fixos, ideal para cálculos de física
	gravidade(delta)
	movement(delta)
	move_and_slide()  ##Função própria da godot que move o corpo com base no "velocity" e lida com colisões

func gravidade(delta):
	if not is_on_floor(): ##se o jogador NÃO estiver no chão...
		velocity.y += gravity * delta  #a velocidade do jogador no eixo y aumentará de acordo com o valor da gravidade
	else:
		velocity.y = 0

func movement(delta):
	#-------------------------------------------  PULO  -------------------------------------------
	if Input.is_action_just_pressed("ui_accept") and  is_on_floor():  ##se o player estiver no chão e pressionar a tecla espaço...
		velocity.y = jump  #a velocidade no eixo y recebe a força do pulo
	
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:  ##se o jogador soltar o botão de pulo e ainda estiver subindo...
		velocity.y *= jump_cut  #multiplica a velocidade de subida por um valor menor, cortando o pulo
	#-------------------------------------------  ANDAR  -------------------------------------------
	
	var direction = Input.get_axis("ui_left","ui_right")  #a variavel "direction" recebe a direção positiva(1) e negativa(-1) no eixo x
	if Input.is_action_pressed("run"):  ##se estiver pressionado o botão de correr...
		max_speed = 650  #velocidade aumenta para 650
		acceleration = 700  #aceleração aumenta para 700
		friction = 250  #fricção diminui para 250
	else:  ##se não estiver pressionado...
		max_speed = 350  #velocidade diminui para 350
		acceleration = 550  #aceleração diminui para 550
		friction = 500  #fricção aumenta para 500
	
	if direction != 0:   ##se o jogador estiver precionando as teclas direcionais esquerda ou direita...
		velocity.x = move_toward(velocity.x, direction * max_speed, acceleration * delta) #move para a direção até uma certa velocidade e com determinada aceleração
	else: ##se não estiver pressionando...
		velocity.x = move_toward(velocity.x, 0, friction * delta)  #a velocidade do jogador diminui até 0
