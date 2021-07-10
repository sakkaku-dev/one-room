extends KinematicBody2D

export var speed = 100

onready var input: PlayerInput = $PlayerInput

func _physics_process(delta):
	var motion = _move_vector()
	
	move_and_slide(motion * speed)
	
func _move_vector() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
