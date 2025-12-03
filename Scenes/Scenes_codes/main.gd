extends Node2D

@export var player : CharacterBody2D
var time_played : float = 0.0
var end_screen = load("res://Scenes/tela_fim.tscn").instantiate()


func _process(delta: float):
	if player.health == false :
		end_game()
	else:
		time_played += delta

func end_game():
	#get_tree().paused = true
	
	end_screen.tempo_final(time_played)
	get_tree().root.add_child(end_screen)
