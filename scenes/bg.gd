extends Node2D

var star_scene: PackedScene = load("res://scenes/star.tscn")

func _on_star_timer_timeout() -> void:
	var star = star_scene.instantiate()
	$Stars.add_child(star)
	
	
	
