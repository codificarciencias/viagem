extends Node2D

var dist = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Refer/GlobCam.make_current()
	pass

func _process(delta):
	# mostra velocidade da nave
	if $Nave.velocidade <= 0:
		$Controle/LbNaveVel.text = 'Vel = ' + str(int($Nave.velocidade*-1))
	else:
		$Controle/LbNaveVel.text = 'Vel = ' + str(int($Nave.velocidade))
	
	# Controle da camera global
	$Refer.position.x = ($Nave.position.x - $Terra.position.x)/2+$Terra.position.x
	if $Refer.position.x >= 400:
		dist = ($Nave.position.x - $Terra.position.x)/1100
		$Refer/GlobCam.zoom.x = dist
		$Refer/GlobCam.zoom.y = dist
		$Refer.scale = Vector2(0.5+dist*2, 0.5+dist*2)
		print(dist)
	
	if Input.is_action_just_pressed("ui_up"):
		if $Refer/GlobCam.current:
			$Nave/NavCam.make_current()
		else:
			$Refer/GlobCam.make_current()
