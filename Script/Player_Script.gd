extends CharacterBody2D

const gravity = 10
var speed : int = 150
var jump : int = 200
var delta : float = 1.1
var attack = false
var dash = false



func _physics_process(delta):
	movement()
	jumping()
	gravity_body()
	attack_player()
	running()
	
	
	

#Função de ataque do player
func attack_player():
	if Input.is_action_just_pressed("attack") and is_on_floor():
			attack = true
			$Player_Animated_Sprite.play("slash")
			velocity.x = 0
			$"Area2D/Colisao direita".disabled = false
		
	if Input.is_action_just_released("attack"):
		attack = false
		$"Area2D/Colisao direita".disabled = true



#Função de pulo
func jumping():
	if Input.is_action_just_pressed("jump") and is_on_floor() and attack == false:
		velocity.y -= jump
		$Player_Animated_Sprite.play("jump")
		
		
#Função para gravidade
func gravity_body():
	if not is_on_floor():
		velocity.y += gravity * delta
		$Player_Animated_Sprite.play("fall")


#Função para movimentação do personagem
func movement():
	var direction = Input.get_axis("left","right")
	if direction and attack == false:
		velocity.x = speed * direction
		if dash == false and direction:
			$Player_Animated_Sprite.play("walk")
	elif attack == false:
		velocity.x = 0
		$Player_Animated_Sprite.play("idle")
	move_and_slide()
	
#Usado para trocar a direção do personagem, apenas para mostrar o sprite para o outro lado
	if direction == 1:
		$Player_Animated_Sprite.flip_h = false
		$"Area2D/Colisao direita".position = Vector2(17.75, -17)
	elif direction == -1:
		$Player_Animated_Sprite.flip_h = true
		$"Area2D/Colisao direita".position = Vector2(-17.75, -17)



func running():
	if Input.is_action_pressed("shift") and velocity.x != 0:
		dash = true
		if dash == true and is_on_floor():
			speed = 250
			$Player_Animated_Sprite.play("running")
	if Input.is_action_just_released("shift"):
		dash = false
		if dash == false:
			speed = 150

	
