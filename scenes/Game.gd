extends Node

signal narrator(message)

const _messages = {
	"start": { "size": Speech.BubbleSize.MEDIUM, "message": "I see you are finally awake"},
}

func queue_message(message: String) -> void:
	if _messages.has(message):
		emit_signal("narrator", _messages[message])
