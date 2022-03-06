# Aviso que a simulação iniciou ou reiniciou
extends AnimationPlayer


func _ready():
	.play("iniciando")
	
# ciclo de quadros por segundo (FPS) ===========================================
func _process(delta):
	# destroi o objeto iniciar
	if $LbIniciar.rect_position.x <= -460:
		self.queue_free()
