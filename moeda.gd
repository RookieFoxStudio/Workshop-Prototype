extends Area2D


func _ready() -> void:
	add_to_group("moeda")
	

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		body.inventory += 1
		print(body.inventory)
