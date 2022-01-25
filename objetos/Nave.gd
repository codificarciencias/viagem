extends Area2D

export var velocidade = 0
var naveVisao = 0
var naveEmissao = 0
var ativar = false
var preNavSinal = preload("res://objetos/SinalNave.tscn")

func _physics_process(delta): #repetição
	
	if Input.is_action_pressed("ui_right") : # move e direciona a nave para direita
		rotation_degrees = 0
		if velocidade < 20:
			velocidade += 3 * delta
		$SpNaveSt.visible = true
		$SpNave.visible = false
		
	elif Input.is_action_pressed("ui_left") : # move e direciona a nave para esquerda
		rotation_degrees = 180
		if velocidade > -20:
			velocidade -= 3 * delta
		$SpNaveSt.visible = true
		$SpNave.visible = false
		
	elif Input.is_action_pressed("ui_down"): # freia e estabiliza a nave
		if velocidade > 0.5:
			velocidade-= 10*delta
			rotation_degrees = 180
			$SpNaveSt.visible = true
			$SpNave.visible = false
		if velocidade < -0.5:
			velocidade += 10*delta
			rotation_degrees = 0
			$SpNaveSt.visible = true
			$SpNave.visible = false
		if velocidade > -0.5 and velocidade < 0.5:
			$SpNaveSt.visible = false
			$SpNave.visible = true
			velocidade = 0
		
	else: # apenas troca a imagem da nave para apagado
		$SpNaveSt.visible = false
		$SpNave.visible = true
	
	translate(Vector2(velocidade, 0)) # realiza o moviento da nave
	
	# evita que a nave passe para esquerda da terra
	if position.x < $"../Terra".position.x:
		velocidade = 0
		position.x = $"../Terra".position.x
	
	# Limita a distância máxima entre terra e nave
	if $"..".distancia/33 >= 60000:
		velocidade = 0
		position.x = $"../Terra".position.x + 106622
		$"../Controle/LbMsg".text =str(position.x)
	
	
# A nave recebe informação do sinal
func _on_Nave_area_entered(area):
	if area.is_in_group('Sinais'):
		naveVisao = area.informacao
		$SomNave.play()

# a nave emite e soma 1 no sinal
func _on_NavTempo_timeout():
	if ativar:
		naveEmissao += 1
		var navSinal = preNavSinal.instance()
		navSinal.informacao = naveEmissao
		get_parent().add_child(navSinal)
		$SomNave.play()
		navSinal.global_position = global_position
		
