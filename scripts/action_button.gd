extends Control

# Bouton aksyon: sprint (kenbe) oswa sote (peze yon fwa).
# Mete l nan yon nœud Control, epi chwazi "action" nan Inspector la.
@export var target: CharacterBody3D
@export_enum("sprint", "jump") var action := "sprint"
@export var radius := 50.0
@export var anchor_x := 0.85   # Pozisyon an pousantaj ekran (0.0 a 1.0)
@export var anchor_y := 0.75

var pressed := false
var touch_index := -1

func _ready() -> void:
_reposition()
get_viewport().size_changed.connect(_reposition)

func _reposition() -> void:
var vp := get_viewport_rect().size
position = Vector2(vp.x * anchor_x, vp.y * anchor_y) - Vector2(radius, radius)
size = Vector2(radius * 2, radius * 2)

func _gui_input(event: InputEvent) -> void:
if event is InputEventScreenTouch:
if event.pressed and touch_index == -1:
touch_index = event.index
_set_pressed(true)
elif not event.pressed and event.index == touch_index:
touch_index = -1
_set_pressed(false)

func _set_pressed(value: bool) -> void:
pressed = value
if target == null:
return
if action == "sprint":
target.sprint_pressed = value
elif action == "jump" and value:
target.jump_requested = true
queue_redraw()

func _draw() -> void:
var c := Vector2(radius, radius)
var alpha := 0.5 if pressed else 0.2
draw_circle(c, radius, Color(1, 1, 1, alpha))
