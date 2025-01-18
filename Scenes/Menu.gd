extends CanvasLayer

func _ready():
	pass
func _process(delta):
	# 檢查是否按下空格鍵
	if Input.is_action_just_pressed("ui_Start"):  # 確保 "ui_accept" 綁定的是空格
		start_game()

# 開始遊戲的功能
func start_game(): # 你可以選擇先更新文本或者直接跳轉
	get_tree().change_scene_to_file("res://Scenes/story.tscn")  
