extends Area2D
export var ativar = false
export var tempo = 0
var PreSinalTerra = preload('res://objetos/Sinal.tscn')


#func _ready():
#	pass

#func _process(delta):
#	pass


# A cada unidade de tempo executa a função
func _on_Transmitir_timeout():
	if ativar:
		tempo += 1
		$TerraSom.play()
		var SinalTerra = PreSinalTerra.instance()
		SinalTerra.informacao = tempo
		add_child(SinalTerra)
		SinalTerra.global_position = global_position
	
	
