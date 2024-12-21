extends Area

signal item_interact

var item_name = "wall" ;


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_body_entered" )


func on_body_entered(body):
	if body.name == "Player":  # Check if the player entered
		show_text("display_text")

func _on_body_exited(body):
	if body.name == "Player":  # Check if the player exited
		hide_text()

func show_text(text):
	print("text")  # Replace with your own UI logic to display the text

func hide_text():
	print("Text hidden")  # Replace with your own UI logic to hide the text

