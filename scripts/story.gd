extends CanvasLayer

# 劇情文本列表
var story_lines = [
	"201X年XX月XX日。於【逃緣】一處山區發生一起命案，現場慘絕人寰。",
	"像我這樣的老鳥，當然是——嘔！",
	"吐了一地「豆花」。！",
	"混著現場濃烈的血腥味，胃裡又是一陣翻江倒海。",
	"法醫催促我離開，要我別留在現場妨礙，安分回到局裡調查證物",
	"過沒多久，現場證物已一一被收回局裡。",
	"裡頭有份引起我注意的現場證物——是張遊戲卡帶",
	"不清楚是被害人的？殺人犯留下的？",
	"在那種荒郊野外，能找到遊戲卡帶也真是奇怪？",
	"不過......",
	"這不妨礙我這個「去現場會妨礙調查」的警察，好好藉上班時間調查一番",
	"正大光明的摸魚時間到！！！！！",
]
var current_line = 0  # 當前顯示的文本索引
@onready var story_label =$Panel/Label  # 確保路徑正確
@onready var continue_button = $Panel/Button  # 確保路徑正確

func _ready():
	update_story()

# 更新故事文本
func update_story():
	if current_line < story_lines.size():
		story_label.text = story_lines[current_line]
	else:
		# 當劇情結束時，切換到主遊戲場景
		get_tree().change_scene_to_file("res://Scenes/World.tscn")  # 替換為你的主遊戲場景路徑
	

func _on_Button_pressed():
	current_line += 1
	update_story()
