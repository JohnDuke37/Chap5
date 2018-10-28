extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MOVE_SPEED = 500
const SCREEN_WIDTH = 320

#func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
	position += Vector2(MOVE_SPEED * delta, 0.0)
	#print(position)
	if position.x > SCREEN_WIDTH + 8:
		queue_free()


func _on_shot_area_entered(area):
	if area.is_in_group("asteroid"):
		queue_free()
