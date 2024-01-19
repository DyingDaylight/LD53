extends Node2D


func _ready() -> void:
	add_to_group("cultists")
	$AnimatedSprite2D.play("default")
	

func _process(delta) -> void:
	pass
	
	
func applause() -> void:
	$AnimatedSprite2D.play("applause")


func _on_applaue_finished() -> void:
	if $AnimatedSprite2D.animation == "applause":
		$AnimatedSprite2D.play("default")
	

func party() -> void:
	$AnimatedSprite2D.play("parting")
	$AnimatedSprite2D.animation = "parting"
