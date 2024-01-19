extends Node2D


var puzzleNode





func _ready() -> void:
	puzzleNode = $PuzzleController.get_next_puzzle()
	add_child(puzzleNode)
	print(puzzleNode.answer)


func _process(delta):
	if Input.is_action_just_pressed("test_ritual_succeesed"):
		pass



