class_name NumberPuzzle
extends Node2D


var answers = ["asrrur", "ravbisti ngor", "ngor dush bisti thest", "woft dush ravbistasr woft"]
var WRONG_COLOR = Color(0.41, 0, 0, 1)
var RIGHT_COLOR = Color(0, 0.80, 0, 1)
var END_COLOR = Color(1, 1, 1, 0)

signal ritual_succeeded


func _ready() -> void:
	var answerFields = get_tree().get_nodes_in_group("number_answers")  
	for i in range(4):
		var answerField = (answerFields[i] as LineEdit)
		if i == 0:
			answerField.grab_focus()
			
		var texture: GradientTexture2D = GradientTexture2D.new()
		texture.fill_from = Vector2(0.5, 1)
		texture.fill_to = Vector2(0.5, 0.75)
		texture.gradient = Gradient.new()
		texture.gradient.set_color(0, WRONG_COLOR)
		texture.gradient.set_color(1, END_COLOR)

		var style: StyleBoxTexture = StyleBoxTexture.new()
		style.texture = texture
		
		answerField.flat = false
		answerField.add_theme_stylebox_override("normal", style)
		
	$Sprite2D2/Bookmark.connect("hint_requested", self.show_hint)


func _process(delta: float) -> void:
	pass
	
	
func _on_line_edit_text_submitted(new_text: String) -> void:
	check_answers()
	
	
func check_answers() -> void:
	var answerFields = get_tree().get_nodes_in_group("number_answers")  
	var correct_answers = 0
	for i in range(4):
		var answerField = (answerFields[i] as LineEdit)
		var theme = answerField.get_theme_stylebox("normal")
		var answer = answerField.get_text().to_lower().strip_edges(true, true)
		if answer == answers[i]:
			correct_answers += 1
			theme.texture.gradient.set_color(0, RIGHT_COLOR)
		else:
			theme.texture.gradient.set_color(0, WRONG_COLOR)

	if correct_answers == 4:
		ritual_succeeded.emit()
	
	
func _on_text_changed(new_text: String) -> void:
	check_answers()
	
	
func show_hint():
	$PageFlip.play()
	$Task.visible = !$Task.visible
	$Hint.visible = !$Hint.visible
