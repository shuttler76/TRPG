extends Node


var map = []
var tilemap
var came_from

func find_paths(start):
	tilemap = get_tree().get_root().get_node("Level/TileMap")
	for x in range(32):
		map.append([])
		for y in range(16):
			map[x].append(0)
	
	for x in range(32):
		for y in range(16):
			if(tilemap.get_cell(x,y) == 0):
				map[x][y] = 1
#		print(map[x])
	
#	var start = get_tree().get_root().get_node("Level/Player").position/16
#	var goal = Vector2(0,0)
	var frontier = priority_queue
	frontier.put(start, 0)
	came_from = {}
	var cost_so_far = {}
	came_from[start] = null
	cost_so_far[start] = 0
	var cost_max = 10
	
	while not frontier.empty():
		var current = frontier.get_first()
		
#		if current == goal:
#			break
		
		for next in neighbors(current):
			var new_cost = cost_so_far[current] + cost(current, next)
			if (!(next in cost_so_far) or new_cost < cost_so_far[next]) and new_cost < cost_max:
				cost_so_far[next] = new_cost
				var priority = new_cost
				frontier.put(next, priority)
				came_from[next] = current
	
#	var path = goal
#	while(path != start):
#		get_tree().get_root().get_node("Level/TileMap2").set_cell(path.x, path.y, 0)
#		path = came_from[path]
		
#	for i in came_from:
#		yield(get_tree().create_timer(0.1),"timeout")
#		get_tree().get_root().get_node("Level/TileMap2").set_cell(i.x, i.y, 0)
	return came_from


func neighbors(position):
	var array = []
	if position.x-1 > 0 and map[position.x-1][position.y]!=0:
		array.append(Vector2(position.x-1,position.y))
	if position.x+1 < 32 and map[position.x+1][position.y]!=0:
		array.append(Vector2(position.x+1,position.y))
	if position.y-1 > 0 and map[position.x][position.y-1]!=0:
		array.append(Vector2(position.x,position.y-1))
	if position.y+1 < 16 and map[position.x][position.y+1]!=0:
		array.append(Vector2(position.x,position.y+1))
	return(array)

func cost(pos1, pos2):
	return(map[pos1.x][pos1.y] + map[pos2.x][pos2.y])

