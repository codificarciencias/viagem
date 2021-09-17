extends AnimationPlayer

func _ready():
	.play("iniciando")
	

func _process(delta):
	if $LbIniciar.rect_position.x <= -460:
		self.queue_free()
