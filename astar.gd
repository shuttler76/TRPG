extends Node


var map = []
var tilemap
var came_from
var frontier


func _ready():
	#saves the reference to the main world tiles
	tilemap = get_tree().get_root().get_node("Level/WorldTiles")
	
	#sets up a 2d array full of 0s
	for x in range(32):
		map.append([])
		for y in range(16):
			map[x].append(0)
	
	#sets each moveable tile to a 1 in the 2d array
	for x in range(32):
		for y in range(16):
			if(tilemap.get_cell(x,y) == 0):
				map[x][y] = 1


func find_paths(start):
	#sets up needed variables
	frontier = []	#queue of the tiles to check on the border of the checked area
	put(start, 0)
	came_from = {}
	var cost_so_far = {}
	came_from[start] = null
	cost_so_far[start] = 0
	var cost_max = 10	#basically 2+(range of movement*2)
	
	#runs while the queue has tiles to work with
	while not emptyList():
		#gets the first item in queue
		var current = get_first()
		
		#goes through each neighbor of the current tile
		for next in neighbors(current):
			var new_cost = cost_so_far[current] + cost(current, next)	#calculates the cost of an option
			if (!(next in cost_so_far) or new_cost < cost_so_far[next]) and new_cost < cost_max:
				cost_so_far[next] = new_cost	#saves the cost for the neighbor
				put(next, new_cost)				#appends the neighbor to the queue
				came_from[next] = current		#saves where the neighbors came from to create paths
	
	return came_from

#a tad ugly, but returns all valid neighbors
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

#calculates the cost of movement
func cost(pos1, pos2):
	return(map[pos1.x][pos1.y] + map[pos2.x][pos2.y])

#an attempt at a biased insert; not perfect, but works nonetheless
func put(item, bias):
	if frontier.find(bias) == -1:	#if the index doesn't exist, append it to the end of the list
		frontier.append(item)
	else:
		frontier.insert(bias+1) 	#otherwise, insert it in the slot after the bias


#gets and removes the first item in the queue
func get_first():
	var temp = frontier[0]
	frontier.remove(0)
	return(temp)


func is_at(index):
	return(frontier[index])


func emptyList():
	return(frontier.empty())
