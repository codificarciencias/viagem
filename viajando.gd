extends Node2D

var dist = 0
var distancia
var emitir = ''

func _ready():
	$GlobCam.make_current() # inicializa com a câmera global
	
	# inicializa o cronometro com intervalo se 1 segundo pausado e zerado
	$Controle/Cronometro.start(1)
	$Controle/Cronometro.paused = true
	
	
#===============================================================================
func _process(delta): 
	$GlobCam.position.x = ($Nave.position.x - $Terra.position.x)/2+$Terra.position.x
	# Controle da camera global
	if $GlobCam.position.x >= 400:
		dist = ($Nave.position.x - $Terra.position.x)/1100
		$GlobCam.zoom.x = dist
		$GlobCam.zoom.y = dist
		
	$Fundo/SpFundo.scale = (Vector2(1.5-dist/200, 1.5-dist/200))
	
	# ativa e desativa emissão da nave e da terra
	if emitir == 'terra':
		$Terra.ativar = true
	elif emitir == 'nave':
		$Nave.ativar = true
	else:
		$Terra.ativar = false
		$Nave.ativar = false	
	
	# Painel de controle e dados ===============================================
	
	# mostra velocidade da nave e rotaciona o velocímetro
	if $Nave.velocidade <= 0:
		$Controle/LbNaveVel.text = str(int(($Nave.velocidade*-100)/3.33))
		$Controle/Velocimetro/Ponteiro.rotation_degrees = ($Nave.velocidade*-12.2)-122
	else:
		$Controle/LbNaveVel.text = str(int(($Nave.velocidade*100)/3.33))
		$Controle/Velocimetro/Ponteiro.rotation_degrees = ($Nave.velocidade*12.2)-122
	
	
	
	# Distância entre a nave e o centro da terra
	distancia = int(($Nave.position.x - $Terra.position.x)*18.57)
	$Controle/LbDist.text ='Dist/Mm = '+ str((distancia)/33)
	
	# marca emissão do sinal da nave
	$Controle/NaveEmisao.text = str($Nave.naveEmissao)
	 
	# registra o que a nave esta vendo
	$Controle/NaveVisao.text = str($Nave.naveVisao)
	
	# marca emissão do sinal da terra(tempo terra)
	$Controle/TerraEmisao.text = str($Terra.terraEmissao)
	
	# registra o que a terra esta vendo
	$Controle/TerraVisao.text = str($Terra.terraVisao)
	
	
		
# função de funcionamento do cronômetro
var minuto = 0
var segundo = 0
func _on_Cronometro_timeout():
	if segundo < 10:
		$Controle/Crono.text = str(minuto)+':0'+str(segundo)
	else:
		$Controle/Crono.text = str(minuto)+':'+str(segundo)
	segundo +=1
	if segundo == 60:
		segundo = 0
		minuto+=1

# botão do cronômetro: pausar, zerar e reiniciar contagem do tempo
func _on_BtCrono_pressed(): 
	minuto = 0
	segundo = 0
	$Processo/ClickAudio.play()
	_on_Cronometro_timeout()
	if $Controle/Cronometro.paused == true:
		$Controle/Cronometro.paused = false
	else:
		$Controle/Cronometro.paused = true

# Botão reiniciar simulação
func _on_btnReset_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_ChTerra_pressed(): # botao de emissão da Terra
	$Processo/ClickAudio.play()
	if emitir != 'terra':
		emitir = 'terra'
		$"Controle/ChTerra/SpAtivado".visible = true
		$"Controle/ChTerra/SpDesat".visible = false
	else:
		emitir = ''
		$"Controle/ChTerra/SpAtivado".visible = false
		$"Controle/ChTerra/SpDesat".visible = true


func _on_ChNave_pressed(): # botao de emissão da nave
	$Processo/ClickAudio.play()
	if emitir != 'nave':
		emitir = 'nave'
		$"Controle/ChNave/Desat".visible = false
		$"Controle/ChNave/Ativo".visible = true
	else:
		emitir = ''
		$"Controle/ChNave/Desat".visible = true
		$"Controle/ChNave/Ativo".visible = false

