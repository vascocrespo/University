extends Node2D

func move(target):
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
