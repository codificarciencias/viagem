# ******************************************************************************
#    ADICIONAR ENTRADA DO MOUSE EM CONFIGURAÇÃO DO PROJETO PARA FUNCIONAR
# ******************************************************************************

extends Node2D

# riscador
var riscar = preload("res://riscador/Risco.tscn")
var lista = []
var cont


func _ready():
	#limpa e inicia o riscador
	cont = 0
	lista.clear()
	lista.append(riscar.instance())
	add_child(lista[0])



func _process(delta):
#Eventos do riscador
# ******************************************************************************
#    ADICIONAR ENTRADA DO MOUSE EM CONFIGURAÇÃO DO PROJETO PARA FUNCIONAR
# ******************************************************************************
	if Input.is_action_just_pressed("mouseRigth"): # limpar tela
		_ready()
		
	elif Input.is_action_pressed("mouseLeft"): #risca a tela
		lista[cont].add_point(Vector2(get_global_mouse_position().x, get_global_mouse_position().y))
	
	elif Input.is_action_just_released("mouseLeft"): # carrega novo risco
		cont+=1
		lista.append(riscar.instance())
		add_child(lista[cont])
	#fim do evento do riscador	
