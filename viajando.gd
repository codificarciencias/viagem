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
	
	# Escolher camera
	if Input.is_action_just_pressed("ui_up"):
		if $GlobCam.current:
			$Nave/NavCam.make_current()
		elif $Nave/NavCam.current:
			$Terra/TerraCam.make_current()
		else:
			$GlobCam.make_current()
			
	
	# Painel de controle e dados ===============================================
	
	# mostra velocidade da nave
	if $Nave.velocidade <= 0:
		$Controle/LbNaveVel.text = 'Vel = ' + str(int(($Nave.velocidade*-100)/3.33))
	else:
		$Controle/LbNaveVel.text = 'Vel = ' + str(int(($Nave.velocidade*100)/3.33))
	
	# Distância entre a nave e o centro da terra
	distancia = int(($Nave.position.x - $Terra.position.x)*18.57)
	$Controle/LbDist.text = str(distancia) + ' Km'
	 
	# Visão da nave, mostra o que a nave esta observando(tempo nave)
	$Controle/LbTempoNave.text = 'Tempo nave: '+str($Nave.naveVisao)
	
	# emissão do sinal da terra(tempo terra)
	$Controle/LbTempoTerra.text = 'Tempo terra: '+str($Terra.tempo)
