extends Control


func _ready() -> void:
	if OS.get_locale_language() == "ru":
		$VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/RuButton.button_pressed = true
	else:
		$VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/EnButton.button_pressed = true


func _on_toggle_pressed(button_pressed: bool, value: String) -> void:
	if button_pressed == true:
		if value == "En":
			$VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/RuButton.button_pressed = false
			TranslationServer.set_locale("en")
		if value == "Ru":
			$VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/EnButton.button_pressed = false
			TranslationServer.set_locale("ru")
	if button_pressed == false:
		if value == "En" and $VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/RuButton.button_pressed == false:
			$VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/EnButton.button_pressed = true
		if value == "Ru" and $VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/EnButton.button_pressed == false:
			$VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/RuButton.button_pressed = true
			

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/scene/main.tscn")


func _on_timer_timeout() -> void:
	$VBoxContainer/Title.play("start")
	$PencilSound.play(0.1)
	$VBoxContainer/Title.connect("animation_finished", _on_firing_animation_finished)
	
	

func _on_firing_animation_finished() -> void:
	$VBoxContainer/Title.play("default")
