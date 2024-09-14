extends Control

@onready var main = $"../../"


func _on_resume_pressed() -> void:
	main.pauseMenu()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	$CenterContainer/VBoxContainer.hide()
	$settings.show()


func _on_settings_back() -> void:
	$settings.hide()
	$CenterContainer/VBoxContainer.show()
