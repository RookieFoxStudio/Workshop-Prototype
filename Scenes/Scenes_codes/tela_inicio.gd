extends Control


func _on_jogar_pressed():  ##função para começar a cena principal do jogo
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")  #pega a árvore de cenas e chama a cena "main.tscn"

func _on_sair_pressed():  ##função para sair da cena
	get_tree().quit()  #pega a árvore de cenas e desliga as cenas
