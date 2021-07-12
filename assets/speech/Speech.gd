extends Node2D

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
	{"pos": Vector2(-19, -9), "width": 330, "sprite": "speech-bubble-s.png" },
	{"pos": Vector2(-26, -8), "width": 460, "sprite": "speech-bubble-m.png" },
	{"pos": Vector2(-37, -11), "width": 680, "sprite": "speech-bubble-l.png" }
]

func _ready():
	label.text = text
	_set_size(size)
	
	var dur = duration if duration != 0 else _get_default_duration()
	timer.start(duration)


func _get_default_duration() -> float:
	if size == BubbleSize.SMALL:
		return 2.0
	elif size == BubbleSize.MEDIUM:
		return 4.0
	
	return 6.0


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


func _on_Timer_timeout():
	queue_free()
