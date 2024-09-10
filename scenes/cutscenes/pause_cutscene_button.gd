extends Button

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func _ready() -> void:
	if visible:
		animation_player.pause()

func _on_pressed() -> void:
	animation_player.play()
