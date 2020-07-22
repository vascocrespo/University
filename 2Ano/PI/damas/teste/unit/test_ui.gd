extends "res://addons/gut/test.gd"

var Scene = preload("res://Scenes/Node2D.gd")

func test_is_ready():
	
	var ai = Scene.new()
	assert_eq(false, ai.can_move(0, ""))
	assert_eq(false, ai.can_move(2, ""))
	assert_eq(false, ai.can_move(4, ""))
	assert_eq(false, ai.can_move(6, ""))
	assert_eq(false, ai.can_move(9, ""))
	assert_eq(false, ai.can_move(11, ""))
	assert_eq(false, ai.can_move(13, ""))
	assert_eq(false, ai.can_move(15, ""))
	assert_eq(true, ai.can_move(16, ""))
	assert_eq(true, ai.can_move(18, ""))
	assert_eq(true, ai.can_move(20, ""))
	assert_eq(true, ai.can_move(22, ""))
	assert_eq(false, ai.can_move(25, ""))
	assert_eq(false, ai.can_move(27, ""))
	assert_eq(false, ai.can_move(29, ""))
	assert_eq(false, ai.can_move(31, ""))
	assert_eq(false, ai.can_move(32, ""))
	assert_eq(false, ai.can_move(34, ""))
	assert_eq(false, ai.can_move(36, ""))
	assert_eq(false, ai.can_move(38, ""))
	assert_eq(true, ai.can_move(41, ""))
	assert_eq(true, ai.can_move(43, ""))
	assert_eq(true, ai.can_move(45, ""))
	assert_eq(true, ai.can_move(47, ""))
	assert_eq(false, ai.can_move(48, ""))
	assert_eq(false, ai.can_move(50, ""))
	assert_eq(false, ai.can_move(52, ""))
	assert_eq(false, ai.can_move(54, ""))
	assert_eq(false, ai.can_move(57, ""))
	assert_eq(false, ai.can_move(59, ""))
	assert_eq(false, ai.can_move(61, ""))
	assert_eq(false, ai.can_move(63, ""))
	
	
	
func test_spaces():
	var cons = Scene.new()
	assert_eq(-1, cons.empty_space(0))
	assert_eq(-1, cons.empty_space(2))
	assert_eq(-1, cons.empty_space(4))
	assert_eq(-1, cons.empty_space(6))
	assert_eq(-1, cons.empty_space(63))
	assert_eq(-1, cons.empty_space(59))
	
func test_empty():
	var constan = Scene.new()
	assert_eq(true, constan.empty_list(constan.flag))

	

	
	