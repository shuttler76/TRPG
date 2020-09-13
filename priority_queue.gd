extends Node


var queue = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func put(item, bias):
	if queue.find(bias) == -1:
		queue.append(item)
	else:
		queue.insert(bias+1)


func get_first():
	var temp = queue[0]
	queue.remove(0)
	return(temp)


func is_at(index):
	return(queue[index])


func empty():
	return(queue.empty())
