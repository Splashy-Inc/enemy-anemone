extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_blast_button_pressed() -> void:
	var blast = InputEventAction.new()
	blast.action = "blast"
	blast.pressed = true
	Input.parse_input_event(blast)


func _on_clam_button_button_down() -> void:
	var tower_press = InputEventAction.new()
	tower_press.action = "tower"
	tower_press.pressed = true
	Input.parse_input_event(tower_press)

func _on_clam_button_button_up() -> void:
	var tower_release = InputEventAction.new()
	tower_release.action = "tower"
	tower_release.pressed = false
	Input.parse_input_event(tower_release)
