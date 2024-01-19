extends Node2D


func _ready():
	pass


func _process(delta):
	pass
	
	
func appear():
	visible = true
	$Sprite.play("default")
	$Sprite/AnimationPlayer.play("Appearing")
	$Roar.play()
