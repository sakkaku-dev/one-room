extends Node2D

onready var camera := $Camera

var speech = preload("res://assets/speech/Speech.tscn")
var speech_offset = Vector2(-17, -3)

var message_queue: Array = []

func _ready():
	Game.connect("narrator", self, "_add_message")
	Game.queue_message("start")

func _add_message(message):
	message_queue.append(message)

func _is_showing_message() -> bool:
	return camera.find_node("Speech") != null
	
func _process(delta):
	if not _is_showing_message() and message_queue.size() > 0:
		_show_message(message_queue.pop_front())


func _show_message(message) -> void:
	var node = speech.instance()
	node.size = message["size"]
	node.text = message["message"]
	if message.has("duration"):
		node.duration = message["duration"]
	camera.add_child(node)
	node.position += speech_offset

