extends KinematicBody

var speed: float = 5.0  # Movement speed
var velocity: Vector3 = Vector3.ZERO
var inventory = {}  # 玩家物品清單
onready var inventory_ui = $CanvasLayer/VBoxContainer
onready var audio_stream_player_3d = $AudioStreamPlayer3D
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	# 初始化背包顯示

	update_inventory_ui()


# Variables
func _physics_process(delta: float) -> void:
	# Reset the velocity to zero (retain the y-component for gravity)
	velocity.x = 0
	velocity.z = 0

	# Get movement input
	var input_vector = Vector2.ZERO
	if Input.get_action_strength("ui_up"):
		input_vector.y -= 1
	if Input.get_action_strength("ui_down"):
		input_vector.y += 1
	if Input.get_action_strength("ui_left"):
		input_vector.x -= 1
	if Input.get_action_strength("ui_right"):
		input_vector.x += 1
		
	# 如果沒有移動則播放閒置動畫
	if input_vector == Vector2.ZERO:
		audio_stream_player_3d.stop()
		animation_state.travel("Idle")
	if input_vector != Vector2.ZERO and audio_stream_player_3d.playing == false:
		# 如果有移動，則播放行走動畫
		audio_stream_player_3d.play()
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")

	# Normalize the input to avoid faster diagonal movement
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
	# Calculate movement direction relative to the world
	var direction = Vector3(input_vector.x, 0, input_vector.y) * speed

	# Apply direction to velocity
	velocity.x = direction.x
	velocity.z = direction.z
	
	

	# Move the player using move_and_slide
	move_and_slide(velocity)

			
func add_to_inventory(item_name: String):
	if inventory.has(item_name):
		inventory[item_name] += 1  # 如果物品已存在，增加數量
	else:
		inventory[item_name] = 1  # 如果物品不存在，新增

	update_inventory_ui()
	print("得到了 " + item_name + " * " + str(inventory[item_name]))
	
func update_inventory_ui():

	for i in range(1, inventory_ui.get_child_count()):
		inventory_ui.get_child(i).queue_free()

	# 動態添加背包物品
	for item_name in inventory.keys():
		var item_label = Label.new()
		item_label.text = item_name + ": " + str(inventory[item_name])
		inventory_ui.add_child(item_label)	
		print("Added Label:", item_label.text)
func show_inventory():
	print("背包內容:")
	for item_name in inventory.keys():
		print(item_name + ": " + str(inventory[item_name]))




