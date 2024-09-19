extends Button

var base = Vector2(0,0);
var bgb = Vector2(0,0);
# Called when the node enters the scene tree for the first time.
func _ready():
	base =position
	bgb = get_node("../Basic").position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = base - ((get_viewport().get_mouse_position()-position) * 0.1)
	get_node("../Basic").position = bgb - ((get_viewport().get_mouse_position()-position) * 0.05)


func _on_button_up():
	get_tree().change_scene_to_file("res://node_2d.tscn")
