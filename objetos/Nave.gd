#*******************************************************************************
# Funcionalidades do objeto Terra
#*******************************************************************************

extends Area2D

export var nvdirecao = 'meio'
export var velocidade = 0
var naveVisao = 0
var naveEmissao = 0
var ativar = false
var preNavSinal = preload("res://objetos/SinalNave.tscn")

func _physics_process(delta): 
	
	if Input.is_action_pressed("ui_right") or nvdirecao == 'dir': # move e direciona a nave para direita
		_nav_dir(delta)
		
	elif Input.is_action_pressed("ui_left") or nvdirecao == 'esq': # move e direciona a nave para esquerda
		_nav_esq(delta)
		
	elif Input.is_action_pressed("ui_down") or nvdirecao == 'estab':# freia e estabiliza a nave
		_nave_freio(delta)
		
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
	
	
# Ocorre quando o sinal emitido pela Terra chega na Nave
# Soma 1 no painel de recepção da Nave
func _on_Nave_area_entered(area):
	if area.is_in_group('Sinais'):
		naveVisao = area.informacao
		$SomNave.play()

# A Nave emite e identifica o sinal com um número inteiro.
# Soma 1 no painel de emissão da nave
func _on_NavTempo_timeout():
	if ativar:
		naveEmissao += 1
		var navSinal = preNavSinal.instance()
		navSinal.informacao = naveEmissao
		get_parent().add_child(navSinal)
		$SomNave.play()
		navSinal.global_position = global_position


func _nav_dir(delta): # Função: move e direciona a nave para direita
	rotation_degrees = 0
	if velocidade < 20:
		velocidade += 3 * delta
	$SpNaveSt.visible = true
	$SpNave.visible = false


func _nav_esq(delta): # Função: move e direciona a nave para esquerda
	rotation_degrees = 180
	if velocidade > -20:
		velocidade -= 3 * delta
	$SpNaveSt.visible = true
	$SpNave.visible = false
	

func _nave_freio(delta): # Função: freia e estabiliza a nave
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
