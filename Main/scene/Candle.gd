extends Node2D


func _ready() -> void:
	add_to_group("candles")


func _process(delta) -> void:
	pass


func burn() -> void:
	$AnimatedSprite2D.play("burning")
	$PointLight2D.visible = true
	$Particles.visible = true
