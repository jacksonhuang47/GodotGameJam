extends KinematicBody

var speed: float = 5.0  # Movement speed
var velocity: Vector3 = Vector3.ZERO
var inventory = {}  # 玩家物品清單
onready var inventory_ui = $CanvasLayer/VBoxContainer

func _ready():
	pass



# Variables
func _physics_process(delta: float) -> void:
	# Reset the velocity to zero (retain the y-component for gravity)
	velocity.x = 0
	velocity.z = 0

	# Get movement input
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1

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

	





