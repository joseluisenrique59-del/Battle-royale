extends Control

# Jwistik tactil. Mete l nan yon nœud Control, anba agoch ekran an.
@export var target: CharacterBody3D   # Glise nœud Player la la
@export var radius := 80.0
@export var deadzone := 0.15

var output := Vector2.ZERO
var touch_index := -1

func _gui_input(event: InputEvent) -> void:
if event is InputEventScreenTouch:
if event.pressed and touch_index == -1:
touch_index = event.index
_update(event.position)
elif not event.pressed and event.index == touch_index:
touch_index = -1
_release()
elif event is InputEventScreenDrag and event.index == touch_index:
_update(event.position)

func _update(pos: Vector2) -> void:
var offset := pos - size / 2.0
if offset.length() > radius:
offset = offset.normalized() * radius
output = offset / radius
if output.length() < deadzone:
output = Vector2.ZERO
if target:
target.move_input = output
queue_redraw()

func _release() -> void:
output = Vector2.ZERO
if target:
target.move_input = Vector2.ZERO
queue_redraw()

func _draw() -> void:
var c := size / 2.0
draw_circle(c, radius, Color(1, 1, 1, 0.2))
draw_circle(c + output * radius, radius * 0.4, Color(1, 1, 1, 0.5))
