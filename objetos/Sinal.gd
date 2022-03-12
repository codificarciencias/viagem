#*******************************************************************************
# Funcionalidades do objeto Sinal (LUZ) emitido pela Terra
#*******************************************************************************
extends Node2D

const velSinal = 600
export var informacao = 0


func _ready():
	pass

func _process(delta):
	# velocidade do sinal sem influencia da velocidade da terra (referencial de emissão)
	global_position.x += velSinal * delta # velocidade da Luz
	
	# identificador do momento em que o sinal foi emitido
	$LbInfo.text = str(informacao)
	
	# Destruição do sinal apos ultrapassar limite da tela (liberar memória)
	if global_position.x > 107000 or Input.is_action_just_pressed("ui_end"):
		queue_free()
	
