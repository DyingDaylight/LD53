extends Node2D


@onready var draggable_scene: PackedScene = preload("res://Main/objects/DragAndDroppable.tscn")
@onready var draggable_container = $Task/SourceContainter/MarginContainer/Draggables
@onready var droppable_container = $Task/TargetContainer/HBoxContainer/Droppables


var answers = ["skrisht'gt", "mnar", "ron'gt", "mnar'gt", "ron", "skrisht'gthor", "ronhor"]
var draggables = [
	{"id": 1, "label": "ron"},
	{"id": 2, "label": "skrisht'gthor"},
	{"id": 3, "label": "mnar'gt"},
	{"id": 4, "label": "ronhor"},
	{"id": 5, "label": "mnar"},
	{"id": 6, "label": "ron'gt"},
	{"id": 7, "label": "skrisht'gt"},
]
var WRONG_COLOR = Color(0.41, 0, 0, 1)
var RIGHT_COLOR = Color(0, 0.80, 0, 1)
var END_COLOR = Color(Color.DIM_GRAY.r, Color.DIM_GRAY.g, Color.DIM_GRAY.b, 0)


signal ritual_succeeded


func _ready() -> void:
	_populate_draggables()
	_populate_droppables()
	
	$Sprite2D2/Bookmark.connect("hint_requested", self.show_hint)


func _populate_draggables():
	for draggable in draggables:
		var drag_item = draggable_scene.instantiate()
		drag_item.set_draggable(draggable["id"], draggable["label"])
		drag_item.connect("item_dropped_on_target", self._on_item_dropped_on_target)
		draggable_container.add_child(drag_item)
		

func _populate_droppables():
	for draggable in draggables:
		var drag_item = draggable_scene.instantiate()
		drag_item.set_droppable()
		drag_item.connect("item_dropped_on_target", self._on_item_dropped_on_target)
		droppable_container.add_child(drag_item)
		
		var texture: GradientTexture2D = GradientTexture2D.new()
		texture.fill_from = Vector2(0.5, 1)
		texture.fill_to = Vector2(0.5, 0.75)
		texture.gradient = Gradient.new()
		texture.gradient.set_color(0, WRONG_COLOR)
		texture.gradient.set_color(1, END_COLOR)

		var style: StyleBoxTexture = StyleBoxTexture.new()
		style.texture = texture
		
		drag_item.get_child(0).add_theme_stylebox_override("normal", style)
		
		
func _on_item_dropped_on_target(dropped_item: Draggable) -> void:
	for drag_item in get_tree().get_nodes_in_group("drop_targets"):
		drag_item = (drag_item as Draggable)
		if drag_item == dropped_item:
			drag_item.set_droppable()
			break
	
	var correct_answers: int = 0
	for i in range(len(answers)):
		var answerField: Label = droppable_container.get_child(i).get_child(0)
		var theme = answerField.get_theme_stylebox("normal")
		var answer = answerField.get_text()
		if answers[i] == answer:
			correct_answers += 1
			theme.texture.gradient.set_color(0, RIGHT_COLOR)
		else:
			theme.texture.gradient.set_color(0, WRONG_COLOR)
			
	if correct_answers == len(answers):
		ritual_succeeded.emit()
		
		
func show_hint():
	$PageFlip.play()
	$Task.visible = !$Task.visible
	$Hint.visible = !$Hint.visible
		
		
		
	
