extends Area2D

export var ativar = false
var terraVisao = 0
var terraEmissao = 0
var PreSinalTerra = preload('res://objetos/Sinal.tscn')


# A terra emite e soma 1 no sinal
func _on_Transmitir_timeout():
	if ativar:
		terraEmissao += 1
		$TerraSom.play()
		var SinalTerra = PreSinalTerra.instance()
		SinalTerra.informacao = terraEmissao
		add_child(SinalTerra)
		SinalTerra.global_position = global_position
		
# A terra recebe informação do sinal
func _on_Terra_area_entered(area):
	if area.is_in_group('NaveSinal'):
		terraVisao = area.informacao
		$TerraSom.play()
	
		area.queue_free()
