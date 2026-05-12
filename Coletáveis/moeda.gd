extends Area2D

@onready var animation = $AnimationPlayer
@onready var player : CharacterBody2D = $"../Player"

func _ready() -> void:
	add_to_group("Moedas")

func _on_body_entered(body: Node2D) -> void:
	print("Player coletou a moeda.")
	
	if body.name == "Player":
		animation.play("Coletado")
		print("Animação bonitinha")
		await animation.animation_finished
		queue_free()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "Coletado":
		player.inventory = player.inventory + 1
		print(player.inventory)
	
