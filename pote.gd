extends Area2D

@onready var player : CharacterBody2D = $"../Player"

var meta : int 

func _ready() -> void:
	var grupo_moedas = get_tree().get_nodes_in_group("Moedas")
	
	meta = grupo_moedas.size()
	print(meta)



func _on_body_entered(body: Node2D) -> void:
	
	body = player
	
	if body.inventory < meta:
		print("- Ainda não coletei todas as moedas, não posso perdelas!")
