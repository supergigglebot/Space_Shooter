extends AnimatedSprite2D

var rng := RandomNumberGenerator.new()
var speed: int
var movement = rng.randi_range(250,400)

func _ready() -> void:
#stars
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x,random_y)
	 
	speed = rng.randi_range(300,500)

func _process(delta: float) -> void:
	position += Vector2(0, 1.0) * movement * delta
	
