extends ColorRect
class_name Draggable

var id: int
var label: String
var draggable = true

signal item_dropped_on_target(draggable)


func _ready() -> void:
	add_to_group("DRAGGABLE")
	
	
func set_draggable(id: int, label: String):
	self.id = id 
	self.label = label
	$Label.text = label
	color = Color.WHITE_SMOKE
	draggable = true


func set_droppable():
	id = 0
	label = ""
	$Label.text = label
	color = Color.DIM_GRAY
	draggable = false

	
func _get_drag_data(_position: Vector2):
	if draggable:
		set_drag_preview(_get_preview_control())
		return self
		
		
func _can_drop_data(at_position: Vector2, data) -> bool:
	var can_drop: bool = data is Node and data.is_in_group("DRAGGABLE") and not draggable
	return can_drop
	
	
func _drop_data(at_position: Vector2, data) -> void:
	set_draggable(data.id, data.label)
	emit_signal("item_dropped_on_target", data)
	
	
func _on_item_dropped_on_target(draggable):
	if draggable.get("id") != id:
		return
		
	set_droppable()


func _get_preview_control() -> Control:
	var preview = ColorRect.new()
	preview.size = size
	var preview_color = color
	preview_color.a = 0.5
	preview.color = preview_color
	return preview
