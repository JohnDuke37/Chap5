extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MOVE_SPEED = 150 
const SCREEN_HEIGHT = 180
const SCREEN_WIDTH = 320
var can_shoot = true
var shot_scene = preload("res://shot.tscn")
var explosion_scene = preload("res://explosion.tscn")

signal destroyed

func _ready():
	position.x = 40
	position.y = 90

func _process(delta):
#	# Called every frame. Delta is time since last frame.
	var input_dir = Vector2()
	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1
	
	position += (delta * MOVE_SPEED) *input_dir
	
	if position.x < 8:
		position.x = 8
	if position.x > SCREEN_WIDTH-8:
		position.x = SCREEN_WIDTH-8
	if position.y < 8:
		position.y = 8
	if position.y > SCREEN_HEIGHT-8:
		position.y = SCREEN_HEIGHT-8
	
	if Input.is_key_pressed(KEY_SPACE) && can_shoot:
		var stage_node = get_parent()
		var shot_instance = shot_scene.instance()
		var shot_instance2 = shot_scene.instance()
		
		shot_instance.position = position + Vector2(9,-5)
		shot_instance2.position = position + Vector2(9,5)
		stage_node.add_child(shot_instance)
		stage_node.add_child(shot_instance2)
		
		can_shoot = false
		get_node("reload_timer").start()
		


func _on_reload_timer_timeout():
	can_shoot= true


func _on_Player_area_entered(area):
	
	if area.is_in_group("asteroid"):
		var stage_node = get_parent()
		var explosion_instance = explosion_scene.instance()
	
		explosion_instance.position = position
		stage_node.add_child(explosion_instance)
		queue_free()
		emit_signal("destroyed")
	
