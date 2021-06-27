extends Node2D

var dist = 0
var distancia


func _ready():
	$GlobCam.make_current()
	pass
#===============================================================================
func _process(delta): 
	$GlobCam.position.x = ($Nave.position.x - $Terra.position.x)/2+$Terra.position.x
	# Controle da camera global
	if $GlobCam.position.x >= 400:
		dist = ($Nave.position.x - $Terra.position.x)/1100
		$GlobCam.zoom.x = dist
		$GlobCam.zoom.y = dist
		
	$Fundo/SpFundo.scale = (Vector2(1.5-dist/200, 1.5-dist/200))
	
	
	# Painel de controle e dados ===============================================
	
	# mostra velocidade da nave
	if $Nave.velocidade <= 0:
		$Controle/LbNaveVel.text = 'Vel = ' + str(int(($Nave.velocidade*-100)/3.33))
	else:
		$Controle/LbNaveVel.text = 'Vel = ' + str(int(($Nave.velocidade*100)/3.33))
	
	# Distância entre a nave e o centro da terra
	distancia = int(($Nave.position.x - $Terra.position.x)*18.57)
	$Controle/LbDist.text = str(distancia) + ' Km'
	
	# marca emissão do sinal da nave
	$Controle/NaveEmisao.text = 'Emisão nave: '+str($Nave.naveEmissao)
	 
	# registra o que a nave esta vendo
	$Controle/NaveVisao.text = 'Visão Nave: '+str($Nave.naveVisao)
	
	# marca emissão do sinal da terra(tempo terra)
	$Controle/TerraEmisao.text = 'Emisão terra: '+str($Terra.terraEmissao)
	
	# registra o que a terra esta vendo
	$Controle/TerraVisao.text = 'Visão Terra: '+str($Terra.terraVisao)
	
	# ativa e desativa emissão da terra
	if $Controle/ChTerra.pressed:
		$Terra.ativar = true
	else:
		$Terra.ativar = false
	
	# ativa e desativa emissão da Nave
	if $Controle/ChNave.pressed:
		$Nave.ativar = true
	else:
		$Nave.ativar = false

## Pausar simulação
#func _on_BtPause_pressed():
#	$Controle/BtPause.visible = false
#	$Controle/BtPlay.visible = true
#	get_tree().paused = true
#
## Play Seguir com a simulação
#func _on_BtPlay_pressed():
#	$Controle/BtPlay.visible = false
#	$Controle/BtPause.visible = true
#	get_tree().paused = false
