extends Area2D

@export var SPEED = 500

func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), 0.1).from(Vector2(0,0))
	
func _process(delta):
	position.y -= SPEED * delta
