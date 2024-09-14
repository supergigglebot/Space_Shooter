extends CanvasLayer

static var image = load("res://PNG/UI/playerLife2_red.png")
var time_elapsed := 0
var asteroidscore := 0

func set_health(amount):
	#remove children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	#create new children - amount set by health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		
func asteroid_score():
	asteroidscore += 5

func _on_score_timer_timeout():
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed + asteroidscore)
	Global.score = time_elapsed + asteroidscore
	
