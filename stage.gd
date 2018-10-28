extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var is_game_over = false
var SCREEN_WIDTH = 320
var SCREEN_HEIGHT = 180
var asteroid_scene = preload("res://Asteroid.tscn")

var score = 0



func _ready():
	# Called every time the node is added to the scene.
	get_node("Player").connect("destroyed",self,"_on_player_destroyed")
	get_node("spawn_timer").connect("timeout",self,"_on_spawn_timer_timeout")


func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://stage.tscn")
		
func _on_player_destroyed():
	get_node("ui/retry").show()
	is_game_over = true
	
func _on_spawn_timer_timeout():
	var asteroid_instance = asteroid_scene.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, rand_range(0, SCREEN_HEIGHT))
	asteroid_instance.connect("score",self,"_on_player_score")
	asteroid_instance.move_speed = 100 + score
	self.add_child(asteroid_instance)
	get_node("spawn_timer").wait_time *=0.99
	
func _on_player_score():
	score += 1
	get_node("ui/score").text = "Score " + str(score)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
