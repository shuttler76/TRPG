extends Node


var genSeed
var x
var i = 0
var j = 0
var passes = 0
var s = 0
var X = 0
var Y = 0
var tex
var color =  Color(0,0,0)
var rows = 1
var columns = 1


func genImage():
	genSeed = pow(OS.get_ticks_usec(),2)
	print(genSeed)
	x = Image.new()
	x.create(16, 16, false, Image.FORMAT_RGBA8) #set up an Image
	x.lock()
	tex = ImageTexture.new()
#	tex.create(x.get_width(), x.get_height(), Image.FORMAT_RGBA8, 2) #set up the Texture the Image becomes
	
	#gen code here
	for i in range(rows*columns): # for each sprite (32 rows x 16 columns)
		genSeed = pow(OS.get_ticks_usec(),2)
		for passes in range(4, 0, -1): # 4 passes, outline left/right and fill left/right
			s = genSeed
			for j in range(floor(randVal()/5 + 50), 0, -1):
				X = j%8
				Y = int(j/8)
				if randVal() < 19:
					color = Color(randVal()/255.0,randVal()/255.0,randVal()/255.0)
				elif pow(randVal(),2) / 2e3 > X*X + pow(Y-5,2):
					x.set_pixel(7 + i%32*16 - passes%2*2*X + X, 2 + (i/32)*16 + Y, color)
	
	x.unlock()
	x.save_png("res://img.png")
	tex.create_from_image(x, 2) #set Image data to texture
	x = 0
#	texture = tex #set sprite texture to ImageTexture
	return(tex)


func randVal():
	randomize()
	s+=1
	var r = int(fmod((sin(s + i*i) + 1)*1e9, 256)) #make a random int between 0-255
	return(r) 


func _process(delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		_ready()
	pass
