extends Node2D



func _process(delta):
	
	
	# Escolher camera
	if Input.is_action_just_pressed("ui_up"):
		if $"../GlobCam".current:
			$"../Nave/NavCam".make_current()
		elif $"../Nave/NavCam".current:
			$"../Terra/TerraCam".make_current()
		else:
			$"../GlobCam".make_current()
			
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().paused :
			_on_BtPlay_pressed()
		else:
			_on_BtPause_pressed()

func _on_BtPlay_pressed():
	$"../Controle/BtPlay".visible = false
	$"../Controle/BtPause".visible = true
	get_tree().paused = false


func _on_BtPause_pressed():
	$"../Controle/BtPause".visible = false
	$"../Controle/BtPlay".visible = true
	get_tree().paused = true
