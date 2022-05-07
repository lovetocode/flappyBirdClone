extends Node2D

var score setget set_score
var high_score = 0 

const SAVE_FILE_PATH = "user://savedata.save"

onready var hud = $HUD
onready var obstacle_spawner = $ObstacleSpawner
onready var ground = $Ground
onready var menu_layer = $MenuLayer

func _ready():
	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
	load_high_score()
	
func new_game():
	self.score = 0
	obstacle_spawner.start()

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)
	
func _on_obstacle_created(obs):
	obs.connect("score", self, "player_score")


func _on_DeathZone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_Player_die():
	game_over()
	
func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	if score > high_score:
		high_score = score
		save_high_score()
		
		
	menu_layer.init_game_over_menu(score, high_score)


func _on_MenuLayer_start_game():
	new_game()
	
func save_high_score():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(high_score)
	save_data.close()
	
func load_high_score():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		high_score = save_data.get_var()
		save_data.close()
