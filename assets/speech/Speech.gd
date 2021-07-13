extends Node2D

class_name Speech

enum BubbleSize {
	SMALL,
	MEDIUM,
	LARGE,
}

onready var label := $Label
onready var sprite := $Sprite
onready var timer := $Timer

export var text = "Example Text"
export(BubbleSize) var size = BubbleSize.SMALL
export var duration = 0.0


const sizes = [
	{"pos": Vector2(-10, -3), "width": 185, "sprite": "speech-bubble-s.png", "root_pos": Vector2(0, 0) },
	{"pos": Vector2(-13, -6), "width": 255, "sprite": "speech-bubble-m.png", "root_pos": Vector2(-3, -1) },
	{"pos": Vector2(-19, -6), "width": 360, "sprite": "speech-bubble-l.png", "root_pos": Vector2(-10, -2) }
]

func _ready():
	label.text = text
	_set_size(size)
	
	var dur = duration if duration <= 0 else _get_default_duration()
	timer.start(duration)


func _get_default_duration() -> float:
	if size == BubbleSize.SMALL:
		return 3.0
	elif size == BubbleSize.MEDIUM:
		return 6.0
	
	return 9.0


func _set_size(size_idx: int) -> void:
	var size = sizes[size_idx]
	
	label.rect_size = Vector2(size["width"], 0)
	label.rect_position = size["pos"]

	var dir = get_script().get_path().get_base_dir()
	var image = Image.new()
	var err = image.load(dir + "/" + size["sprite"])
	if err == OK:
		var texture = ImageTexture.new()
		texture.create_from_image(image, 0)
		sprite.texture = texture
	
	position = size["root_pos"]


func _on_Timer_timeout():
	queue_free()
