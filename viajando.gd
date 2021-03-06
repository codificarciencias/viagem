#*******************************************************************************
# Funcionalidades de controle da simulação
#*******************************************************************************

extends Node2D

var dist = 0
var distancia = 0.0
var emitirNave = false
var emitirTerra = false

var tempo = 0
var tempoPlay = false
var centezimo = 0
var segundo = 0
var minuto = 0

func _ready():
	$GlobCam.make_current() # inicializa com a câmera global
	
	
# ciclo de quadros por segundo (FPS) ===========================================
func _process(delta):
	
	# Parametro inicial da camera global
	$GlobCam.position.x = ($Nave.position.x - $Terra.position.x)/2+$Terra.position.x
	# Controle da camera global
	if $GlobCam.position.x >= 400:
		dist = ($Nave.position.x - $Terra.position.x)/1100
		$GlobCam.zoom.x = dist
		$GlobCam.zoom.y = dist
	# Efeito de fundo	
	$Fundo/SpFundo.scale = (Vector2(1.5-dist/200, 1.5-dist/200))
	
	
	# Painel de controle e dados ===============================================
	
	# mostra velocidade da nave e rotaciona o velocímetro
	if $Nave.velocidade <= 0:
		$Controle/PainelBaixo/Velocimetro/LbNaveVel.text = str(int(($Nave.velocidade*-100)/3.33))
		$Controle/PainelBaixo/Velocimetro/Ponteiro.rotation_degrees = ($Nave.velocidade*-12.2)-122
	else:
		$Controle/PainelBaixo/Velocimetro/LbNaveVel.text = str(int(($Nave.velocidade*100)/3.33))
		$Controle/PainelBaixo/Velocimetro/Ponteiro.rotation_degrees = ($Nave.velocidade*12.2)-122
	
	
	# Distância entre a nave e o centro da terra
	distancia = int(($Nave.position.x - $Terra.position.x)*18.57)
	$Controle/PainelCima/LbDist.text = str((distancia)/33)
	
	# marca emissão do sinal da nave
	$Controle/PainelBaixo/ChNave/NaveEmisao.text = str($Nave.naveEmissao)
	 
	# registra o que a nave esta vendo
	$Controle/PainelBaixo/ChNave/NaveVisao.text = str($Nave.naveVisao)
	
	# marca emissão do sinal da terra(tempo terra)
	$Controle/PainelBaixo/ChTerra/TerraEmisao.text = str($Terra.terraEmissao)
	
	# registra o que a terra esta vendo
	$Controle/PainelBaixo/ChTerra/TerraVisao.text = str($Terra.terraVisao)
	
	
		
# funcionamento do cronômetro depois do play
	$Controle/PainelCima/BtCrono/Crono.text = str('%02d'% minuto , ':', '%02d'% segundo, ':', '%02d'% centezimo)
	if tempoPlay == true :
		tempo += delta
		centezimo = fmod(tempo, 1)*100
		segundo = fmod(tempo, 60)
		minuto = fmod(tempo, 60*60)/60


# faz a unificaçao dos botões do teclado com os da tela
	if Input.is_action_pressed("ui_down"):
		_on_BtEstab_pressed()
	elif Input.is_action_just_released("ui_down"):
		_on_BtEstab_released()
	elif Input.is_action_pressed("ui_right"):
		_on_BtDir_pressed()
	elif Input.is_action_just_released("ui_right"):
		_on_BtDir_released()
	elif Input.is_action_pressed("ui_left"):
		_on_BtEsq_pressed()
	elif Input.is_action_just_released("ui_left"):
		_on_BtEsq_released()
		

# botão do cronômetro: pausar, zerar e reiniciar a contagem do tempo
func _on_BtCrono_pressed(): 
	$Processo/ClickAudio.play() # som do botão
	
	if tempoPlay == true : # pausa o Cronometro
		tempoPlay = false
	elif tempoPlay == false and tempo == 0: # inicia o Cronometro
		tempoPlay = true
	elif tempoPlay == false and tempo > 0: # zera o Cronometro
		tempo = 0
		centezimo = 0
		segundo = 0
		minuto = 0
	

# Botão reiniciar simulação
func _on_btnReset_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_ChTerra_pressed(): # botao de emissão da Terra
	$Processo/ClickAudio.play()
	var BtTerra = $"Controle/PainelBaixo/ChTerra"
	
	if emitirTerra == true :
		BtTerra.texture_normal = load("res://image/icoTerra.png")
		$Terra.ativar = false
		emitirTerra = false
	else:
		BtTerra.texture_normal = load("res://image/icoTerraAt.png")
		$Terra.ativar = true
		emitirTerra = true


func _on_ChNave_pressed(): # botao de emissão da nave
	$Processo/ClickAudio.play()
	var BtNave = $"Controle/PainelBaixo/ChNave"
	
	if emitirNave == true:
		BtNave.texture_normal = load("res://image/icoNave.png")
		$Nave.ativar = false
		emitirNave = false
	else:
		BtNave.texture_normal = load("res://image/icoNaveAt.png")
		$Nave.ativar = true
		emitirNave = true


# Inicio do código de controle da Manete de movimento da nave (((
func _on_BtDir_pressed(): # Pressionar manete para direita
	$Controle/PainelBaixo/Manete.texture = load("res://image/botao/ManeteDir.png")
	$Nave.nvdirecao='dir'

func _on_BtDir_released(): # liberar manete
	$Controle/PainelBaixo/Manete.texture = load("res://image/botao/ManeteCentro.png")
	$Nave.nvdirecao = 'meio'

func _on_BtEsq_pressed():  # Pressionar manete para esquerda
	$Controle/PainelBaixo/Manete.texture = load("res://image/botao/ManeteEsq.png")
	$Nave.nvdirecao = 'esq'
	
func _on_BtEsq_released(): # liberar manete
	_on_BtDir_released()
# Fim do bloco de controle da manete )))


# Botão de estabilizar ou repousar a nave
func _on_BtEstab_pressed():
	$Controle/PainelBaixo/BtEstab.normal = load("res://image/botao/BtnFrearon.png")
	$Controle/PainelBaixo/Manete.texture = load("res://image/botao/ManeteCentro.png")
	$Nave.nvdirecao = 'estab'
	
# Liberar botão estabilizar
func _on_BtEstab_released():
	$Controle/PainelBaixo/BtEstab.normal = load("res://image/botao/BtnFrear.png")
	_on_BtDir_released()
