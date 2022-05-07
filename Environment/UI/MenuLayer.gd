extends CanvasLayer

signal start_game

onready var start_message = $startMenu/StartMessage
onready var tween = $Tween
onready var score_label = $gameOverMenu/VBoxContainer/ScoreLabel
onready var High_score_label = $gameOverMenu/VBoxContainer/HighScoreLabel
onready var game_over_menu = $gameOverMenu

var game_started = false

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		print("H")
		emit_signal("start_game")
		tween.interpolate_property(start_message,"modulate:a", 1, 0 , 0.5 )
		tween.start()
		game_started = true
		
func init_game_over_menu(score, highScore):
	score_label.text = "SCORE: " + str(score)
	High_score_label.text = "Best: " + str(highScore)
	game_over_menu.visible = true
	

func _on_Button_pressed():
	get_tree().reload_current_scene()
