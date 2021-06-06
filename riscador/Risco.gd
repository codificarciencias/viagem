extends Line2D


func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("mouseRigth"):
		.clear_points()
		
