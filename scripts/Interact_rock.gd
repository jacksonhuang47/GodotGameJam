extends Area

signal item_interact

var item_name = "石頭"
var can_interact = false  # 用來檢測是否可以互動

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	if body.name == "Player":  # Check如果進入範圍的是玩家
		can_interact = true  # 玩家進入互動範圍
		print("按'E' 跟 " + item_name + "互動")

func _on_body_exited(body):
	if body.name == "Player":  # Check如果離開範圍的是玩家
		can_interact = false  # 玩家離開互動範圍


func _process(delta):	
	# 當玩家在範圍內並按下 E 鍵時進行互動
	if can_interact and Input.is_action_just_pressed("ui_Interact"):
		interact()

func interact():
	print("就是顆" + item_name)  # 在此處添加互動邏輯