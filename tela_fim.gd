extends Control

@export var time : Label

func tempo_final(time_seconds : float):
	var total_seconds = floori(time_seconds)
	var seconds = total_seconds % 60
	var minutes = total_seconds / 60
	time.text = "Tempo: %s:%s" % [str(minutes).pad_zeros(2), str(seconds).pad_zeros(2)]



func _on_recomeçar_pressed() -> void:
	get_tree().change_scene_to_file("res://tela_início.tscn")
	queue_free()

func _on_sair_pressed() -> void:
	get_tree().quit()
