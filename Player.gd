extends Node2D


var hovered = false
var selected = false
var moving = false
var movePath = []
var selectMap
var paths


func _ready():
	$Sprite.texture = spriteGen.genImage()
	selectMap = get_tree().get_root().get_node("Level/TileMap2")
	globalTween.connect("tween_completed", self, "tween_end")


func _process(delta):
	if !moving:
		if Input.is_action_just_pressed("select") and hovered:
			if !selected:
				paths = astar.find_paths(position/16)
				for i in paths:
					selectMap.set_cell(i.x, i.y, 0)
				selected = true
			else:
				selectMap.clear()
				selected = false
		elif Input.is_action_just_pressed("select") and selected:
			var mouse = get_global_mouse_position()
			if selectMap.get_cellv(mouse/16) != -1:
				var point = Vector2(int(mouse.x/16),int(mouse.y/16))
				movePath.insert(0,point)
				while paths[point] != Vector2(int(position.x/16),int(position.y/16)):
					movePath.insert(0,paths[point])
					point = paths[point]
				selectMap.clear()
				selected = false
				moving = true
				moveTo(movePath[0])
				movePath.remove(0)


func _on_Area2D_mouse_entered():
	hovered = true


func _on_Area2D_mouse_exited():
	hovered = false


func moveTo(pos):
	globalTween.interpolate_property(self, "position", position, pos*16, 0.2, Tween.TRANS_LINEAR)
	globalTween.start()


func tween_end(obj, prop):
	if movePath.size() > 0:
		moveTo(movePath[0])
		movePath.remove(0)
	else:
		moving = false
