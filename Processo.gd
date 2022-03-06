#*******************************************************************************
# Funcionalidades que continuam ativas mesmo com a simulação em pausa 
#*******************************************************************************

extends Node2D


# ciclo de quadros por segundo (FPS) ===========================================
func _process(delta):
	
	# Fecha o aplicativo com botao Esc
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# Exibe data e hora
	$"../Controle/PainelCima/LbData".text = str('Data: ', '%02d'% OS.get_date()['day'], '-', 
	'%02d'% OS.get_date()['month'],'-', OS.get_date()['year'], 
	' Hora: ', '%02d'% OS.get_time()['hour'],' : ', '%02d'% OS.get_time()['minute'],' : ', 
	'%02d'% OS.get_time()['second'])
	
	# Escolher câmera, a simulação inicia com a câmera global
	if Input.is_action_just_pressed("ui_up"):
		_selecionar_camera()
	
	# Operações de zoom da câmera
	if $ZoomCam.current and Input.is_action_pressed("Zoom"):
		$"../Controle/SpCamCur".visible = true
		if get_global_mouse_position().x > $ZoomCam.position.x + $ZoomCam.zoom.x*100 :
			$ZoomCam.position.x += $ZoomCam.zoom.x*10
			$"../Controle/SpCamCur".texture = load("res://image/camera/curssorCam.png")
			$"../Controle/SpCamCur".flip_h = false
		elif get_global_mouse_position().x < $ZoomCam.position.x - $ZoomCam.zoom.x*100:
			$ZoomCam.position.x -= $ZoomCam.zoom.x*10
			$"../Controle/SpCamCur".texture = load("res://image/camera/curssorCam.png")
			$"../Controle/SpCamCur".flip_h = true
		else:
			$"../Controle/SpCamCur".texture = load("res://image/camera/curssorZoom.png")
			
		# rolagem da roda do mouse
		if Input.is_action_just_released("ZoomMais") and $ZoomCam.zoom > Vector2(1,1):
			$ZoomCam.zoom -= Vector2(1,1)
		elif Input.is_action_just_released("ZoomMenos"):
			$ZoomCam.zoom += Vector2(1,1)
		elif Input.is_action_just_pressed("ZoomCam"):
			$ZoomCam.position = $"../GlobCam".position
			$ZoomCam.zoom = $"../GlobCam".zoom
	else:
		$"../Controle/SpCamCur".visible = false
		
		
	# Botao pause ao pressionar Enter
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().paused :
			_on_BtPlay_pressed()
		else:
			_on_BtPause_pressed()


# libera a simulação a simulação (PLAY)
func _on_BtPlay_pressed():
	$ClickAudio.play()
	$"../Controle/PainelCima/BtPlay".visible = false
	$"../Controle/PainelCima/BtPause".visible = true
	get_tree().paused = false


# Pausa a simulação (PAUSE)
func _on_BtPause_pressed():
	$ClickAudio.play()
	$"../Controle/PainelCima/BtPause".visible = false
	$"../Controle/PainelCima/BtPlay".visible = true
	get_tree().paused = true


# Maximiza e minimiza a tela cheia
func _on_btnCheio_pressed():
	var maximizar = $"../Controle/PainelCima/btnCheio"
	$ClickAudio.play()
	if OS.window_fullscreen == true:
		OS.window_fullscreen = false
		maximizar.texture_normal = load("res://image/botao/telaCheia.png")
		maximizar.texture_hover = load("res://image/botao/cheiaHover.png")
	else:
		OS.window_fullscreen = true
		maximizar.texture_normal = load("res://image/botao/telaVazia.png")
		maximizar.texture_hover = load("res://image/botao/telaHover.png")


# Botão de selecionar câmera 
func _on_SelCam_pressed():
	_selecionar_camera()
	

# funcionalidade para selecionar câmera
func _selecionar_camera():
	var camera_sel = $"../Controle/PainelCima/SelCam"
	if $"../GlobCam".current: # câmera da nave
		camera_sel.texture_normal = load("res://image/camera/navecam.png")
		$"../Nave/NavCam".make_current()
		
	elif $"../Nave/NavCam".current:  # câmera da terra
		camera_sel.texture_normal = load("res://image/camera/terracam.png")
		$"../Terra/TerraCam".make_current()
		
	elif $"../Terra/TerraCam".current: # câmera livre com zoom
		camera_sel.texture_normal = load("res://image/camera/zoomcam.png")
		$ZoomCam.make_current()
		$ZoomCam.position = $"../GlobCam".position
		$ZoomCam.zoom = $"../GlobCam".zoom
		
	else: # retorna para câmera global
		camera_sel.texture_normal = load("res://image/camera/globalcam.png")
		$"../GlobCam".make_current()
