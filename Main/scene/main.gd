extends Node2D

var successes: int = 0
var puzzleNode: Node2D


func _ready():
	$Murmur.play()
	var cultists = get_tree().get_nodes_in_group("cultists")  
	for cultist in cultists:  
		$Applause.connect("finished", cultist._on_applaue_finished)
		
	load_ritual()


func _process(delta):
	pass


func load_ritual() -> void:
	if puzzleNode != null and has_node(puzzleNode.get_path()):
		remove_child(puzzleNode)
		
	puzzleNode = $PuzzleController.get_next_puzzle()
	add_child(puzzleNode)
	if puzzleNode.has_signal("ritual_succeeded"):
		puzzleNode.connect("ritual_succeeded", self._on_ritual_succeeded)


func _on_ritual_succeeded():
	get_tree().call_group("cultists", "applause")
	$Applause.play()
	
	successes += 1
	
	print("Rital succeeded " + str(successes) + " times")
	
	if successes == 1:
		get_tree().call_group("candles", "burn")
		$Fire.play()
		$PageFlip.play()
		load_ritual()
	if successes == 2:
		$Portal.appear()
		$PortalHum.play()
		$PageFlip.play()
		load_ritual()
	if successes == 3:
		$OldOne.appear()
		$Murmur.stop()
		$HappyParty.play()
		for cultist in get_tree().get_nodes_in_group("cultists"):
			cultist.party()  
		load_ritual()


