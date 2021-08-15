extends Node2D



func _process(delta): # loop do FPS
	
	# Fecha o aplicativo com botao Esc
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


	# Escolher câmera, a simulação inicia com a câmera global
	if Input.is_action_just_pressed("ui_up"):
		if $"../GlobCam".current: # câmera da nave
			$"../Controle/Panel2/SelCam".text = 'Nave Cam'
			$"../Nave/NavCam".make_current()
		elif $"../Nave/NavCam".current:  # câmera da terra
			$"../Controle/Panel2/SelCam".text = 'Terra Cam'
			$"../Terra/TerraCam".make_current()
		elif $"../Terra/TerraCam".current: # câmera livre com zoom
			$"../Controle/Panel2/SelCam".text = 'Zoom Cam'
			$ZoomCam.make_current()
			$ZoomCam.position = $"../GlobCam".position
			$ZoomCam.zoom = $"../GlobCam".zoom
		else: # retorna para câmera global
			$"../Controle/Panel2/SelCam".text = 'Global Cam'
			$"../GlobCam".make_current()
	
	
	# Operações de zoom da câmera
	if $ZoomCam.current and Input.is_action_pressed("Zoom"):
		if get_global_mouse_position().x > $ZoomCam.position.x + $ZoomCam.zoom.x*100 :
			$ZoomCam.position.x += $ZoomCam.zoom.x*10
		elif get_global_mouse_position().x < $ZoomCam.position.x - $ZoomCam.zoom.x*100:
			$ZoomCam.position.x -= $ZoomCam.zoom.x*10
		# rolagem do mouse whell
		if Input.is_action_just_released("ZoomMais"):
			$ZoomCam.zoom -= Vector2(1,1)
		elif Input.is_action_just_released("ZoomMenos"):
			$ZoomCam.zoom += Vector2(1,1)
		elif Input.is_action_just_pressed("ZoomCam"):
			$ZoomCam.position = $"../GlobCam".position
			$ZoomCam.zoom = $"../GlobCam".zoom
	
	# Botao pause ao pressionar Enter
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().paused :
			_on_BtPlay_pressed()
		else:
			_on_BtPause_pressed()


# Roda a simulação
func _on_BtPlay_pressed():
	$"../Controle/BtPlay".visible = false
	$"../Controle/BtPause".visible = true
	get_tree().paused = false


# Pausa a simulação
func _on_BtPause_pressed():
	$"../Controle/BtPause".visible = false
	$"../Controle/BtPlay".visible = true
	get_tree().paused = true

