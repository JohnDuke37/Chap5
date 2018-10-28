extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var explosion_scene = load("res://explosion.tscn")
var move_speed =100
var score_emitted = false

signal score


#func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#position.x = 340
	#position.y = 90

func _process(delta):
	position -= Vector2(move_speed * delta, 0.0)
	if position.x < -100:
		queue_free();


func _on_Asteroid_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("shot"):
		if not score_emitted:
			score_emitted = true
			emit_signal("score")
			queue_free()
		
		var stage_node = get_parent()
		var explosion_instance = explosion_scene.instance()
		
		explosion_instance.position = position
		stage_node.add_child(explosion_instance)
		
