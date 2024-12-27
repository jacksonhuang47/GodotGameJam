extends KinematicBody

var patrol_speed: float = 0.1  # 巡邏速度
var loop_patrol: bool = true  # 是否循環巡邏

onready var path_follow = $Path/PathFollow

func _ready():
	# 初始化路徑跟隨
	if loop_patrol:
		path_follow.loop = true

func _process(delta):
	pass
