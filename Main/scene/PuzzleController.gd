extends Node2D

var counter: int = 0
var packed_puzzles = [preload("res://Main/puzzles/NumbersPuzzle.tscn"),
					preload("res://Main/puzzles/SuffixPuzzle.tscn"),
					preload("res://Main/puzzles/PossessivePuzzle.tscn"),
					preload("res://Main/puzzles/Final.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_next_puzzle() -> Node2D:
	if counter >= len(packed_puzzles):
		return null
		
	var puzzle = packed_puzzles[counter].instantiate()
	counter += 1
	return puzzle
