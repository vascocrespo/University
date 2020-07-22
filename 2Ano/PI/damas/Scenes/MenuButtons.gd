extends Node2D



func _on_StartGame_pressed():
	get_node("Start").move(Vector2(-576,0))
	get_node("Modes").move(Vector2(0,0))


func _on_Back_pressed():
	get_node("Start").move(Vector2(0,0))
	get_node("Modes").move(Vector2(576,0))
	


func _on_1v1Same_pressed():
	get_tree().change_scene("res://Scenes/board.tscn")


func _on_vsPC_pressed():
	get_tree().change_scene("res://Scenes/board.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Rules.tscn")
