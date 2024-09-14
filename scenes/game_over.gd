extends Control

var level_scene: PackedScene = load("res://scenes/level.tscn")

func _ready():
	$CenterContainer/VBoxContainer/Score.text = $CenterContainer/VBoxContainer/Score.text + str(Global.score)

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene_to_packed(level_scene)
