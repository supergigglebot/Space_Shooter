extends Node2D

var asteroid_scene: PackedScene = load("res://scenes/asteroid.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var game_over_scene: PackedScene = load("res://scenes/game_over.tscn")
@onready var pause_menu = $CanvasLayer/PauseMenu
var paused = false
var bus_idx = AudioServer.get_bus_index("Music")
var effect = AudioServer.get_bus_effect(bus_idx, 0)
var health: int = 3



func _ready():
	
	AudioServer.set_bus_effect_enabled(bus_idx, 1, false)
	effect.cutoff_hz = 20500.0
	#setup health UI
	get_tree().call_group('ui', 'set_health', health)

func _on_asteroid_timer_timeout():
	var asteroid = asteroid_scene.instantiate()
	$Asteroids.add_child(asteroid)
	
	#connect the signal
	asteroid.connect('collision', _on_asteroid_collision)
	

	
func _on_asteroid_collision():
	var lowpass : AudioEffectLowPassFilter = AudioServer.get_bus_effect(1,0)
	var cutoff_automation := create_tween()
	effect.cutoff_hz = 500.0
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	cutoff_automation.tween_property(lowpass, "cutoff_hz", 20500, 1.5)
	if health <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")
		AudioServer.set_bus_effect_enabled(bus_idx, 1, true)
	$player.play_collision_sound()
	$player.i_frame_timer()
	
	
	
func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():

	if paused:
		pause_menu.hide()
		effect.cutoff_hz = 20500.0 
		Engine.time_scale = 1
		
	else:
		pause_menu.show()
		effect.cutoff_hz = 1500.0 
		Engine.time_scale = 0
	paused = !paused
