extends CharacterBody2D

@export var SPEED: int = 500
@onready var screen_size = get_viewport_rect().size
signal laser(pos)
var can_shoot := true


func _ready() -> void:
	position = Vector2(100,500)


func _process(_delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * SPEED
	move_and_slide()
	screen_wrap()
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPos.global_position)
		can_shoot = false
		$LaserTimer.start()
		$LaserSound.play()
	
func play_collision_sound():
	$DamageSound.play()
	
func _on_laser_timer_timeout():
	can_shoot = true

func i_frame_timer():
	$CollisionPolygon2D.call_deferred("set_disabled", true)
	$IFrameTimer.start()
	$Sprite2D.play("damage")

func _on_i_frame_timer_timeout():
	$CollisionPolygon2D.call_deferred("set_disabled", false)
	
func screen_wrap():
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
