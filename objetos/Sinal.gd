extends Node2D
export var velSinal = 600
export var informacao = 0

func _ready():
	pass

func _process(delta):
	# velocidade do sinal
	global_position.x += velSinal * delta
	# identificador do momento em que o sinal foi emitido
	$LbInfo.text = str(informacao)
	
	# auto destruição do sinal para liberar memoria
	if global_position.x > 107000 or Input.is_action_just_pressed("ui_end"):
		queue_free()
	
