extends Node2D

var inicio = []
var dic = {}
var peca = Vector2()
var remove_peca = Vector2()
var comidos_pretas = []
var comidos_brancas = []
var damaPreta = preload("res://Sprites/DamaPreta.png")
var damaBranca = preload("res://Sprites/Dama_Branca.png")
var hanged = preload("res://Sprites/hanged.png")
var lovers = preload("res://Sprites/lovers.png")
var tower = preload("res://Sprites/tower.png")
var death = preload("res://Sprites/death.png")

var flag = []
var last_played = "Black"

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_Over_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	
func _on_Over2_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func everything():
	var blacks = 1
	var whites = 1

	for o in range(0,12):
		comidos_brancas.append(0)
		comidos_pretas.append(0)

	for i in range(0,64):
		if i < 8 or (i >=16 and i < 24):
			if i%8 == 0 or i%8 == 2 or i%8 == 4 or i%8 == 6:
				inicio.append("B")
				flag.append(0)
				dic["Black_peace"+str(blacks)] = i
				blacks=blacks+1

			else:
				inicio.append("E")
				flag.append(0)


		elif i < 16:
			if (i%8 - 1) == 0 or (i%8 - 1) == 2 or (i%8 - 1) == 4 or (i%8 - 1) == 6:
				inicio.append("B")
				flag.append(0)
				dic["Black_peace"+str(blacks)] = i
				blacks=blacks+1

			else:
				inicio.append("E")
				flag.append(0)



		elif (i>=40 and i < 48) or (i >= 56 and i < 64):
			if (i%8 - 1) == 0 or (i%8 - 1) == 2 or (i%8 - 1) == 4 or (i%8 - 1) == 6:
				inicio.append("W")
				flag.append(0)
				dic["White_peace"+str(whites)] = i
				whites = whites + 1

			else:
				inicio.append("E")
				flag.append(0)

		elif i >=48 and i < 56:
			if i%8 == 0 or i%8 == 2 or i%8 == 4 or i%8 == 6:
				inicio.append("W")
				flag.append(0)
				dic["White_peace"+str(whites)] = i
				whites = whites + 1

			else:
				inicio.append("E")
				flag.append(0)

		else:
			inicio.append("E")
			flag.append(0)



func _init():
	everything()
	pass

func position(pecas):

	var x = ((get_node(pecas).get_position().x) - 57) / 57
	var y = ((get_node(pecas).get_position().y) - 192) / 64
	var positions = x + (y * 8)
	return positions
	
func choose_card(last_played):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var carta = rng.randi_range(1,10)
	if carta < 5:
		get_node("Cards").set_texture(hanged)
		print(last_played)
		if last_played == "Black":
			var se = 0
			for keys in dic:
				var remove = dic.get(keys)
				
				if "Black" in keys and remove != -1 and inicio[remove] != "DB":
					se = 1
					inicio[remove] = "E"
					dic[keys] = -1
					remove_peca = get_node(keys)
					break
			if se == 1:
				for pos in range(0,12):
	
					if comidos_brancas[pos] == 0:
						comidos_brancas[pos] = 1
						remove_peca.position.x = 548.875
						remove_peca.position.y = 225.173 + (pos * 57)
						break
			
		elif last_played == "White":
			var se = 0
			for keys in dic:
				var remove = dic.get(keys)

				if "White" in keys and remove != -1 and inicio[remove] != "DW":
					se = 1
					inicio[remove] = "E"
					dic[keys] = -1
					remove_peca = get_node(keys)
					break
			if se == 1:
				for pos in range(0,12):
	
					if comidos_pretas[pos] == 0:
						comidos_pretas[pos] = 1
						remove_peca.position.x = 28.875
						remove_peca.position.y = 225.173 + (pos * 57)
						break
					
			
	elif carta < 0:
		get_node("Cards").set_texture(lovers)
		
		if last_played == "Black":
			var se = 1
			if comidos_brancas[0] == 1 or comidos_brancas[1] == 1 or comidos_brancas[2] == 1 or comidos_brancas[3] == 1:
				for keys in dic:
					var remove = dic.get(keys)
					if "Black" in keys and remove == -1:
						remove_peca = get_node(keys)
						
						for g in range(0,8,2):
							if inicio[g] == "E" :
								dic[keys] = g
								remove_peca.position.x = (((g - 8 * floor(g / 8))) * 57) + 86.954
								remove_peca.position.y = ((g/8) * 64) + 225.173
								se = 0
								break
								
						if se == 0:
							break
							
						for g in range(9,15,2):
							if inicio[g] == "E" :
								dic[keys] = g
								remove_peca.position.x = (((g - 8 * floor(g / 8))) * 57) + 86.954
								remove_peca.position.y = ((g/8) * 64) + 225.173
								se = 0
								break
						
						if se == 0:
							break
						for g in range(16,24,2):
							if inicio[g] == "E" :
								dic[keys] = g
								remove_peca.position.x = (((g - 8 * floor(g / 8))) * 57) + 86.954
								remove_peca.position.y = ((g/8) * 64) + 225.173
								se = 0
								break
						
						if se == 0:
							break
		
		if last_played == "White":
			var se = 1
			if comidos_pretas[0] == 1 or comidos_pretas[1] == 1 or comidos_pretas[2] == 1 or comidos_pretas[3] == 1:
				for keys in dic:
					var remove = dic.get(keys)
					if "White" in keys and remove == -1:
						remove_peca = get_node(keys)
						
						for g in range(63,54,-2):
							if inicio[g] == "E" :
								dic[keys] = g
								remove_peca.position.x = (((g - 8 * floor(g / 8))) * 57) + 86.954
								remove_peca.position.y = ((g/8) * 64) + 225.173
								se = 0
								break
						
						if se == 0:
							break
								
						for g in range(52,45,-2):
							if inicio[g] == "E" :
								dic[keys] = g
								remove_peca.position.x = (((g - 8 * floor(g / 8))) * 57) + 86.954
								remove_peca.position.y = ((g/8) * 64) + 225.173
								se = 0
								break
								
						if se == 0:
							break
						
						for g in range(45,38,-2):
							if inicio[g] == "E" :
								dic[keys] = g
								remove_peca.position.x = (((g - 8 * floor(g / 8))) * 57) + 86.954
								remove_peca.position.y = ((g/8) * 64) + 225.173
								se = 0
								break
						if se == 0:
							break
							
		
	elif carta < 9:
		get_node("Cards").set_texture(tower)
		if last_played == "Black":
			for some in range(0, 64):
				if inicio[some] == "B":
					inicio[some] = "DB"
					for keys in dic:
						var remove = dic.get(keys)
						if remove == some:
							remove_peca = get_node(keys)
							remove_peca.set_texture(damaPreta)
							break
					break		
		
		if last_played == "White":
			for some in range(63, -1, -1):
				if inicio[some] == "W":
					inicio[some] = "DW"
					for keys in dic:
						var remove = dic.get(keys)
						if remove == some:
							remove_peca = get_node(keys)
							remove_peca.set_texture(damaBranca)
							break
					break			
		
		
	else:
		get_node("Cards").set_texture(death)
		if last_played == "Black":
			get_node("GameOver").move(Vector2(0,0))
			get_node("Return").move(Vector2(576,0))
		if last_played == "White":
			get_node("GameOver2").move(Vector2(0,0))
			get_node("Return").move(Vector2(576,0))
		
	
func can_move(positions, last_played):
	var piece
	for key in dic:
			var value = dic.get(key)
			if value == positions:
				piece = key
	if piece == null:
		return false

	if "Black" in piece:
		if last_played != "Black":
			if inicio[positions] == "DB":
				flag[positions] = 2
				var count = positions
				
				while (count+9 < 64 and count >= 0):
					if ((inicio[count + 9] == "B") or ((count - 8 * floor(count / 8)) == 7)):
						break
					
					elif inicio[count] == "W" and inicio[count + 9] == "W":
						flag[count] = 0
						break
					
					elif inicio[count + 9] == "W" or inicio[count + 9] == "DW":
						flag[count + 9] = 3
					
						
					elif inicio[count + 9] == "E":
						
						flag[count + 9 ] = 1
					count += 9
				
				count = positions
				
				while (count+7 < 64 and count >= 0):	
					if ((inicio[count + 7] == "B") or ((count - 8 * floor(count / 8)) == 0)):
						break
						
					elif inicio[count] == "W" and inicio[count + 7] == "W":
						flag[count] = 0
						break
					
					elif inicio[count + 7] == "W" or inicio[count + 7] == "DW":
						flag[count + 7] = 3
						
					elif inicio[count + 7] == "E":
						flag[positions] = 2
						flag[count + 7 ] = 1
					count += 7
					
				count = positions
				
				while (count < 64 and count-7 >= 0):
						
					if ((inicio[count - 7] == "B") or ((count - 8 * floor(count / 8)) == 7)):
						break
						
					elif inicio[count] == "W" and inicio[count - 7] == "W":
						flag[count] = 0
						break
					
					elif inicio[count - 7] == "W" or inicio[count - 7] == "DW":
						flag[count - 7] = 3
					
					elif inicio[count - 7] == "E":
						flag[positions] = 2
						flag[count - 7 ] = 1
					count -= 7
				
				count = positions
				
				while (count < 64 and count-9 >= 0):	
					if ((inicio[count - 9] == "B") or ((count - 8 * floor(count / 8)) == 0)):
						break
						
					elif inicio[count] == "W" and inicio[count - 9] == "W":
						flag[count] = 0
						break
					
					elif inicio[count - 9] == "W" or inicio[count - 9] == "DW":
						flag[count - 9] = 3
						
					elif inicio[count - 9] == "E":
						flag[positions] = 2
						flag[count - 9] = 1
					count -= 9
					
			else:
				if(((inicio[positions + 7] == "W" or inicio[positions + 7] == "DW") and (positions + 14 < 64) and inicio[positions + 14] == "E") or ((inicio[positions + 9] == "W" or inicio[positions + 9] == "DW") and (positions + 18 < 64) and inicio[positions + 18] == "E")):

					var boolean = false
	
					if(((positions + 7) - 8 * floor((positions + 7) / 8)) != 0):
						if((inicio[positions + 7] == "W" or inicio[positions + 7] == "DW") and inicio[positions + 14] == "E"):
							
							flag[positions] = 2
							flag[positions + 14] = 3
							boolean = true
	
	
					if(((positions + 9) - 8 * floor((positions + 9) / 8)) != 7):
						if((inicio[positions + 9] == "W" or inicio[positions + 9] == "DW") and inicio[positions + 18] == "E"):
							flag[positions] = 2
							flag[positions + 18] = 3
							boolean = true
					if boolean == true:
						return true
	
				if ((positions - 8 * floor(positions / 8)) == 0 and positions < 48):
					if (inicio[positions + 9] == "W" or inicio[positions + 9] == "DW") and inicio[positions + 18] == "E":
						flag[positions] = 2
						flag[positions + 18] = 3
	
					if inicio[positions + 9] == "E":
						flag[positions] = 2
						flag[positions + 9] = 1
						return true
	
				elif ((positions - 8 * floor(positions / 8)) == 7 and positions < 48):
					if (inicio[positions + 7] == "W" or inicio[positions + 7] == "DW") and inicio[positions + 14] == "E":
						flag[positions] = 2
						flag[positions + 14] = 3
	
					if inicio[positions + 7] == "E":
						flag[positions] = 2
						flag[positions +7] = 1
						return true
	
				elif(inicio[positions + 9] == "E" or inicio[positions + 7] == "E" ):
					flag[positions] = 2
					if(inicio[positions + 9] == "E"):
	
						flag[positions + 9] = 1
	
					if(inicio[positions + 7] == "E"):
						flag[positions + 7] = 1
	
					return true

		return false

	if "White" in piece:
		if last_played != "White":
			
			if inicio[positions] == "DW":
				
				var count = positions
				
				while (count+9 < 64 and count >= 0):
					if ((inicio[count + 9] == "W") or ((count - 8 * floor(count / 8)) == 7)):
						break
						
					elif inicio[count] == "B" and inicio[count + 9] == "B":
						flag[count] = 0
						break
					
					elif inicio[count + 9] == "B" or inicio[count + 9] == "DB":
						flag[count + 9] = 3
					
					elif inicio[count + 9] == "E":
						flag[positions] = 2
						flag[count + 9 ] = 1
					count += 9
				
				count = positions
				
				while (count+7 < 64 and count >= 0):	
					if ((inicio[count + 7] == "W") or ((count - 8 * floor(count / 8)) == 0)):
						break
						
					elif inicio[count] == "B" and inicio[count + 7] == "B":
						flag[count] = 0
						break
					
					elif inicio[count + 7] == "B" or inicio[count + 7] == "DB":
						flag[count + 7] = 3	
						
					elif inicio[count + 7] == "E":
						flag[positions] = 2
						flag[count + 7 ] = 1
					count += 7
				count = positions
				
				while (count < 64 and count-7 >= 0):
						
					if ((inicio[count - 7] == "W") or ((count - 8 * floor(count / 8)) == 7)):
						break
						
					elif inicio[count] == "B" and inicio[count - 7] == "B":
						flag[count] = 0
						break
					
					elif inicio[count - 7] == "B" or inicio[count - 7] == "DB":
						flag[count - 7] = 3
						
					elif inicio[count - 7] == "E":
						flag[positions] = 2
						flag[count - 7 ] = 1
					count -= 7
					
				count = positions
				
				while (count < 64 and count-9 >= 0):	
					if ((inicio[count - 9] == "W") or ((count - 8 * floor(count / 8)) == 0)):
						break
						
					elif inicio[count] == "B" and inicio[count - 9] == "B":
						flag[count] = 0
						break
					
					elif inicio[count - 9] == "B" or inicio[count - 9] == "DB":
						flag[count - 9] = 3
						
					elif inicio[count - 9] == "E":
						flag[positions] = 2
						flag[count - 9] = 1
					count -= 9
			
			else:
				
				if(((inicio[positions - 7] == "B" or inicio[positions - 7] == "DB") and (positions - 14 > 0) and inicio[positions - 14] == "E") or ((inicio[positions - 9] == "B" or inicio[positions - 9] == "DB") and (positions - 18 > 0) and inicio[positions - 18] == "E")):
					var boolean = false
	
					if(((positions - 7) - 8 * floor((positions - 7) / 8)) != 7):
						if((inicio[positions - 7] == "B" or inicio[positions - 7] == "DB") and inicio[positions - 14] == "E"):
							flag[positions] = 2
							flag[positions - 14] = 3
							boolean = true
	
					if(((positions - 9) - 8 * floor((positions - 9) / 8)) != 0):
						if((inicio[positions - 9] == "B" or inicio[positions - 9] == "DB") and inicio[positions - 18] == "E"):
							flag[positions] = 2
							flag[positions - 18] = 3
							boolean = true
					if boolean == true:
						return true
	
				if((positions - 8 * floor(positions / 8)) == 0 and positions > 15):
	
					if((inicio[positions - 7] == "B" or inicio[positions - 7] == "DB") and inicio[positions - 14] == "E"):
					
						flag[positions] = 2
						flag[positions - 14] = 3
	
					elif inicio[positions - 7] == "E":
						flag[positions] = 2
						flag[positions - 7] = 1
						return true
	
				elif((positions - 8 * floor(positions / 8)) == 7 and positions > 15):
					if((inicio[positions - 9] == "B" or inicio[positions - 9] == "DB") and inicio[positions - 18] == "E"):
						flag[positions] = 2
						flag[positions - 18] = 3
	
					elif inicio[positions - 9] == "E":
						flag[positions] = 2
						flag[positions - 9] = 1
						return true



				elif(inicio[positions - 7] == "E" or inicio[positions - 9] == "E" ):
					flag[positions] = 2
					if(inicio[positions - 9] == "E"):
	
						flag[positions -9] = 1
	
					if(inicio[positions - 7] == "E"):
						flag[positions - 7] = 1
	
					return true
				return false

	return false

func empty_space(positions):
	if inicio[positions] == "E" and (flag[positions] == 1 or flag[positions] == 3):
		for n in range(0,64):
			if flag[n] == 2:
				return n

	for k in range(0,64):
		flag[k] = 0
	return -1


func empty_list(flag):
	for k in flag:
		if k != 0:
			return false
	return true

func move(num, positions):

	if num != -1:
		for key in dic:
			var value = dic.get(key)
			if value == num:
				peca = get_node(key)

				if ("Black" in key) == true:
					
					if inicio[value] == "DB":
						
						if flag[positions] == 1:
							
							inicio[positions] = "DB"
							inicio[value] = "E"
							if (((positions - value) - 9 * floor((positions - value) / 9)) == 0):
							   
								if(positions - value > 0):
									var temp = positions - 9
									peca.position.x = peca.position.x + (57 * ( (positions - value) / 9))
									peca.position.y = peca.position.y + (64 * ( (positions - value) / 9))
									
									last_played = "Black"
									
									while(temp != value):
										if flag[temp] == 3:
											if inicio[temp] == "DW":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)

												if remove == (temp):
													remove_peca = get_node(keys)
													dic[keys] = -1

											for pos in range(0,12):

												if comidos_pretas[pos] == 0:
													comidos_pretas[pos] = 1
													remove_peca.position.x = 28.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp - 9
										
								elif(positions - value < 0):
									peca.position.x = peca.position.x - (57 * ( (value - positions) / 9))
									peca.position.y = peca.position.y - (64 * ( (value - positions) / 9))
									var temp = positions + 9
									last_played = "Black"
									
									while(temp != value):
										
										if flag[temp] == 3:
											if inicio[temp] == "DW":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)

												if remove == (temp):
													remove_peca = get_node(keys)
													dic[keys] = -1

											for pos in range(0,12):

												if comidos_pretas[pos] == 0:
													comidos_pretas[pos] = 1
													remove_peca.position.x = 28.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp + 9
							
							
							if (((positions - value) - 7 * floor((positions - value) / 7)) == 0):
								
								if(positions - value > 0):
									
									peca.position.x = peca.position.x - (57 * ( (positions - value) / 7))
									peca.position.y = peca.position.y + (64 * ( (positions - value) / 7))
									var temp = positions - 7
									last_played = "Black"
									
									while((temp) != value):
										if flag[temp] == 3:
											if inicio[temp] == "DW":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)

												if remove == (temp):
													remove_peca = get_node(keys)
													dic[keys] = -1

											for pos in range(0,12):

												if comidos_pretas[pos] == 0:
													comidos_pretas[pos] = 1
													remove_peca.position.x = 28.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp - 7
										
										
								elif(positions - value < 0):
									peca.position.x = peca.position.x + (57 * ( (value - positions) / 7))
									peca.position.y = peca.position.y - (64 * ( (value - positions) / 7))
									var temp = positions + 7
									last_played = "Black"
									while((temp) != value):
										#print(temp)
										if flag[temp] == 3:
											if inicio[temp] == "DW":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)
#
												if remove == temp:
													remove_peca = get_node(keys)
													dic[keys] = -1
#
											for pos in range(0,12):

												if comidos_pretas[pos] == 0:
													comidos_pretas[pos] = 1
													remove_peca.position.x = 28.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp + 7
								
								
						
					elif (positions - value == 18):
						
						if positions > 55 and positions < 64:
							peca.set_texture(damaPreta)
							inicio[positions] = "DB"
							last_played = "Black"
							choose_card(last_played)
						else:
							last_played = "Black"
							if inicio[value + 9] == "DW":
								choose_card(last_played)
							
							inicio[positions] = "B"
						inicio[value] = "E"
						inicio[value + 9] = "E"
						peca.position.x += 114
						peca.position.y += 128
						
							
						for keys in dic:
							var remove = dic.get(keys)

							if remove == (value + 9):
								remove_peca = get_node(keys)
								dic[keys] = -1
						
						for pos in range(0,12):

							if comidos_pretas[pos] == 0:
								comidos_pretas[pos] = 1
								remove_peca.position.x = 28.875
								remove_peca.position.y = 225.173 + (pos * 57)
								break



					elif positions - value == 14:
						
						if positions > 55 and positions < 64:
							peca.set_texture(damaPreta)
							inicio[positions] = "DB"
							last_played = "Black"
							choose_card(last_played)
						else:
							inicio[positions] = "B"
							last_played = "Black"
							
							if inicio[value + 7] == "DW":
								choose_card(last_played)
						inicio[value] = "E"
						inicio[value + 7] = "E"
						peca.position.x -= 114
						peca.position.y += 128

						for keys in dic:
							var remove = dic.get(keys)

							if remove == (value + 7):
								remove_peca = get_node(keys)
								dic[keys] = -1
						
						for pos in range(0,12):

							if comidos_pretas[pos] == 0:
								comidos_pretas[pos] = 1
								remove_peca.position.x = 28.875
								remove_peca.position.y = 225.173 + (pos * 57)
								break

					elif positions - value == 9:
						if positions > 55 and positions < 64:
							inicio[positions] = "DB"
							last_played = "Black"
							choose_card(last_played)
							peca.set_texture(damaPreta)
						else:
							inicio[positions] = "B"
							last_played = "Black"
							
						inicio[value] = "E"
						peca.position.x += 57
						peca.position.y += 64
						

					elif positions - value == 7:
						if positions > 55 and positions < 64:
							inicio[positions] = "DB"
							last_played = "Black"
							choose_card(last_played)
							peca.set_texture(damaPreta)
						else:
							inicio[positions] = "B"
							last_played = "Black"
						inicio[value] = "E"
						peca.position.x -= 57
						peca.position.y += 64
						

				if ("White" in key) == true:
					
					if inicio[value] == "DW":
						if flag[positions] == 1:
							
							inicio[positions] = "DW"
							inicio[value] = "E"
							if (((positions - value) - 9 * floor((positions - value) / 9)) == 0):
								if(positions - value > 0):
									var temp = positions - 9
									peca.position.x = peca.position.x + (57 * ( (positions - value) / 9))
									peca.position.y = peca.position.y + (64 * ( (positions - value) / 9))
									
									last_played = "White"
									while(temp != value):
										if flag[temp] == 3:
											if inicio[temp] == "DB":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)

												if remove == (temp):
													remove_peca = get_node(keys)
													dic[keys] = -1

											for pos in range(0,12):

												if comidos_brancas[pos] == 0:
													comidos_brancas[pos] = 1
													remove_peca.position.x = 548.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp - 9
										
								elif(positions - value < 0):
									var temp = positions + 9
									peca.position.x = peca.position.x - (57 * ( (value - positions) / 9))
									peca.position.y = peca.position.y - (64 * ( (value - positions) / 9))
									
									last_played = "White"
									while(temp != value):
										
										if flag[temp] == 3:
											if inicio[temp] == "DB":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)

												if remove == (temp):
													remove_peca = get_node(keys)
													dic[keys] = -1

											for pos in range(0,12):

												if comidos_brancas[pos] == 0:
													comidos_brancas[pos] = 1
													remove_peca.position.x = 548.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp + 9
							
							
							if (((positions - value) - 7 * floor((positions - value) / 7)) == 0):
								if(positions - value > 0):
									peca.position.x = peca.position.x - (57 * ( (positions - value) / 7))
									peca.position.y = peca.position.y + (64 * ( (positions - value) / 7))
									var temp = positions - 7
									last_played = "White"
									
									while((temp) != value):
										if flag[temp] == 3:
											if inicio[temp] == "DB":
												choose_card(last_played)
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)

												if remove == (temp):
													remove_peca = get_node(keys)
													dic[keys] = -1

											for pos in range(0,12):

												if comidos_brancas[pos] == 0:
													comidos_brancas[pos] = 1
													remove_peca.position.x = 548.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp - 7
									
								elif(positions - value < 0):
									peca.position.x = peca.position.x + (57 * ( (value - positions) / 7))
									peca.position.y = peca.position.y - (64 * ( (value - positions) / 7))
									var temp = positions + 7
									last_played = "White"
									while((temp) != value):
										#print(temp)
										if flag[temp] == 3:
											if inicio[temp] == "DB":
												choose_card(last_played)
											
											inicio[temp] = "E"
											for keys in dic:
												var remove = dic.get(keys)
#
												if remove == temp:
													remove_peca = get_node(keys)
													dic[keys] = -1
#
											for pos in range(0,12):

												if comidos_brancas[pos] == 0:
													comidos_brancas[pos] = 1
													remove_peca.position.x = 548.875
													remove_peca.position.y = 225.173 + (pos * 57)
													break
										temp = temp + 7
					
					
					elif positions - value == -18:
						
						if positions >= 0 and positions < 8:
							inicio[positions] = "DW"
							last_played = "White"
							choose_card(last_played)
							peca.set_texture(damaBranca)
						else:
							inicio[positions] = "W"
							last_played = "White"
							
							if inicio[value - 9] == "DB":
								choose_card(last_played)
						
						inicio[value] = "E"
						inicio[value - 9] = "E"
						peca.position.x -= 114
						peca.position.y -= 128

						for keys in dic:
							var remove = dic.get(keys)

							if remove == (value -9):
								remove_peca = get_node(keys)
								dic[keys] = -1
						
						for pos in range(0,12):

							if comidos_brancas[pos] == 0:
								comidos_brancas[pos] = 1
								remove_peca.position.x = 548.875
								remove_peca.position.y = 225.173 + (pos * 57)
								break

					elif positions - value == -14:

						if positions >= 0 and positions < 8:
							inicio[positions] = "DW"
							last_played = "White"
							choose_card(last_played)
							peca.set_texture(damaBranca)
						else:
							inicio[positions] = "W"
							last_played = "White"
							if inicio[value - 7] == "DB":
								choose_card(last_played)
								
						inicio[value] = "E"
						inicio[value - 7] = "E"
						peca.position.x += 114
						peca.position.y -= 128
						for keys in dic:
							var remove = dic.get(keys)

							if remove == (value - 7):
								remove_peca = get_node(keys)
								dic[keys] = -1
						
						for pos in range(0,12):

							if comidos_brancas[pos] == 0:
								comidos_brancas[pos] = 1
								remove_peca.position.x = 548.875
								remove_peca.position.y = 225.173 + (pos * 57)
								
								break

					elif positions - value == -9:
						if positions >= 0 and positions < 8:
							inicio[positions] = "DW"
							last_played = "White"
							choose_card(last_played)
							peca.set_texture(damaBranca)
						else:
							inicio[positions] = "W"
							last_played = "White"
						inicio[value] = "E"
						peca.position.x -= 57
						peca.position.y -= 64
						


					elif positions - value == -7:
						if positions >= 0 and positions < 8:
							inicio[positions] = "DW"
							last_played = "White"
							choose_card(last_played)
							peca.set_texture(damaBranca)
						else:
							inicio[positions] = "W"
							last_played = "White"
						inicio[value] = "E"
						peca.position.x += 57
						peca.position.y -= 64
						

				dic[key] = positions
				for k in range(0,64):
					flag[k] = 0
				print(dic)
	var counter = 0
	var counter1 = 0
	for i in comidos_brancas:
		if i == 0:
			counter+=1
			break
	for i in comidos_pretas:
		if i == 0:
			counter1+=1
			break
	if (counter == 0):
		get_node("GameOver").move(Vector2(0,0))
		get_node("Return").move(Vector2(576,0))
	
	elif(counter1 == 0):
		get_node("GameOver2").move(Vector2(0,0))
		get_node("Return").move(Vector2(576,0))
	
	
func _on_White_space1_pressed():
	var positions = position("White_space1")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)


	else:
		var num = empty_space(positions)
		move(num, positions)
		
	



func _on_White_space2_pressed():
	var positions = position("White_space2")

	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)


func _on_White_space3_pressed():
	var positions = position("White_space3")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space4_pressed():
	var positions = position("White_space4")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)

func _on_White_space5_pressed():
	var positions = position("White_space5")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)


func _on_White_space6_pressed():

	var positions = position("White_space6")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)




func _on_White_space7_pressed():
	var positions = position("White_space7")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space8_pressed():
	var positions = position("White_space8")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space9_pressed():
	var positions = position("White_space9")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)


func _on_White_space10_pressed():
	var positions = position("White_space10")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)




func _on_White_space11_pressed():
	var positions = position("White_space11")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space12_pressed():
	var positions = position("White_space12")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space13_pressed():
	var positions = position("White_space13")

	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space14_pressed():
	var positions = position("White_space14")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)




func _on_White_space15_pressed():
	var positions = position("White_space15")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space16_pressed():
	var positions = position("White_space16")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)


func _on_White_space17_pressed():
	var positions = position("White_space17")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space18_pressed():
	var positions = position("White_space18")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space19_pressed():
	var positions = position("White_space19")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space20_pressed():
	var positions = position("White_space20")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space21_pressed():
	var positions = position("White_space21")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space22_pressed():
	var positions = position("White_space22")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space23_pressed():
	var positions = position("White_space23")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space24_pressed():
	var positions = position("White_space24")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space25_pressed():
	var positions = position("White_space25")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space26_pressed():
	var positions = position("White_space26")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space27_pressed():
	var positions = position("White_space27")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space28_pressed():
	var positions = position("White_space28")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space29_pressed():
	var positions = position("White_space29")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space30_pressed():
	var positions = position("White_space30")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



func _on_White_space31_pressed():
	var positions = position("White_space31")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)


func _on_White_space32_pressed():
	var positions = position("White_space32")
	if empty_list(flag) == true:
		if inicio[positions] == "E":
			return
		can_move(positions, last_played)
		print(flag)
		print(inicio)

	else:
		var num = empty_space(positions)
		move(num, positions)



