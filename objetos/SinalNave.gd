extends Area2D

export var velSinalN = -600
export var informacao = 0

func _ready():
	pass

func _process(delta):
	# velocidade do sinal
	global_position.x += velSinalN * delta
	# identificador do momento em que o sinal foi emitido
	$LbInfo.text = 'Dia '+ str(informacao)
	
	# auto destruição do sinal para liberar memoria
#	if global_position.x < -200 or Input.is_action_just_pressed("ui_end"):
#		queue_free()

