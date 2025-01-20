extends CharacterBody3D

var speed: float = 5.0  # 移動速度
var inventory = {}  # 玩家物品清單
@onready var inventory_ui = $CanvasLayer/VBoxContainer
@onready var audio_stream_player_3d = $AudioStreamPlayer3D
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Reset the x 和 z 方向的速度
	velocity.x = 0
	velocity.z = 0

	# 獲取輸入
	var input_vector = Vector2.ZERO
	if Input.get_action_strength("ui_up"):
		input_vector.y -= 1
	if Input.get_action_strength("ui_down"):
		input_vector.y += 1
	if Input.get_action_strength("ui_left"):
		input_vector.x -= 1
	if Input.get_action_strength("ui_right"):
		input_vector.x += 1

	# 動畫和音效處理
	if input_vector == Vector2.ZERO:
		audio_stream_player_3d.stop()
		animation_state.travel("Idle")
	else:
		if not audio_stream_player_3d.playing:
			audio_stream_player_3d.play()
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")

		# 規範化輸入，避免斜向移動速度過快
		input_vector = input_vector.normalized()

	# 計算方向
	var direction = Vector3(input_vector.x, 0, input_vector.y) * speed

	# 將方向應用到內建 velocity
	velocity.x = direction.x
	velocity.z = direction.z

	# 移動角色
	move_and_slide()

func add_to_inventory(item_name: String):
	if inventory.has(item_name):
		inventory[item_name] += 1  # 如果物品已存在，增加數量
	else:
		inventory[item_name] = 1  # 如果物品不存在，新增
