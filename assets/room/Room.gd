extends Node2D

onready var camera := $Camera

var speech = preload("res://assets/speech/Speech.tscn")

func _ready():
	Game.connect("narrator", self, "_show_message")

func _show_message(message) -> void:
	var node = speech.instance()
	node.size = message["size"]
	node.text = message["message"]
	
