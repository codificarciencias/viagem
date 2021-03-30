extends Node2D

var dist = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	
	if $Nave.velocidade <= 0:
		$Canvlayer/LbNaveVel.text = 'Vel = ' + str(int($Nave.velocidade*-1))
	else:
		$Canvlayer/LbNaveVel.text = 'Vel = ' + str(int($Nave.velocidade))
	
	$Refer.position.x = ($Nave.position.x - $Terra.position.x)/2+$Terra.position.x
	if $Refer.position.x >= 400:
		dist = ($Nave.position.x - $Terra.position.x)/900
		$Refer/Camera2D.zoom.x = dist
		$Refer/Camera2D.zoom.y = dist
		$Refer.scale = Vector2(7-dist/8000, 7-dist/8000)
	
