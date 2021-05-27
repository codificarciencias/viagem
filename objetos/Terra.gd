extends Area2D

export var tempo = 0
var PreSinalTerra = preload('res://objetos/Sinal.tscn')


func _ready():
	pass

func _process(delta):
	pass



func _on_Transmitir_timeout():
	tempo += 1
	var SinalTerra = PreSinalTerra.instance()
	SinalTerra.informacao = tempo
	add_child(SinalTerra)
	SinalTerra.global_position = global_position
	
	
