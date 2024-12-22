extends Area

signal item_pick_up

onready var picksound = $"../Picksound"

var item_name = "長得像心臟的火龍果"
var can_interact = false  # 用來檢測是否可以互動

# Called when the node enters the scene tree for the first time.
func _ready():
	# 連接信號，檢測玩家是否進入或離開互動範圍
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	if body.name == "Player":  # 玩家進入範圍
		can_interact = true
		print("按'E' 撿起" + item_name)
func _on_body_exited(body):
	if body.name == "Player":  # 玩家離開範圍
		can_interact = false

func _process(delta):
	# 當玩家在範圍內並按下 E 鍵（ui_interact）時觸發互動
	if can_interact and Input.is_action_just_pressed("ui_Interact"):
		interact()
		emit_signal("item_pick_up", item_name)
		call_deferred("queue_free")
func interact():
	var player = get_parent().get_node("Player")  # 獲取玩家節點
	if player:
		player.add_to_inventory(item_name)
		picksound.play()
