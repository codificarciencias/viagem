#*******************************************************************************
# Funcionalidades do objeto Terra
#*******************************************************************************

extends Area2D

export var ativar = false
var terraVisao = 0
var terraEmissao = 0
var PreSinalTerra = preload('res://objetos/Sinal.tscn')


# A terra emite e identifica o sinal com um número inteiro.
# Soma 1 no painel de emissão da terra
func _on_Transmitir_timeout():
	if ativar: # ao acionar o botão de emissão da terra
		terraEmissao += 1
		$TerraSom.play()
		var SinalTerra = PreSinalTerra.instance()
		SinalTerra.informacao = terraEmissao
		add_child(SinalTerra)
		SinalTerra.global_position = global_position
		
# Ocorre quando o sinal emitido pela nave chega na terra
# Soma 1 no painel de recepção da terra
func _on_Terra_area_entered(area):
	if area.is_in_group('NaveSinal'):
		terraVisao = area.informacao
		$TerraSom.play()
	
		area.queue_free()
