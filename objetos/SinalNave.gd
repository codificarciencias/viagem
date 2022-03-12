#*******************************************************************************
# Funcionalidades do objeto Sinal (LUZ) emitido pela nave
#*******************************************************************************

extends Area2D

const velSinalN = -600
export var informacao = 0

func _ready():
	pass

func _process(delta):
	# velocidade do sinal sem influencia da velocidade da nave(referencial de emissão)
	global_position.x += velSinalN * delta # velocidade da luz
	
	# identificador do momento em que o sinal foi emitido
	$LbInfo.text = str(informacao)
	
	# auto destruição do sinal para liberar memoria
#	if global_position.x < -200 or Input.is_action_just_pressed("ui_end"):
#		queue_free()

