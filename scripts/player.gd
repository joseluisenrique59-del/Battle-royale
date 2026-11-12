extends CharacterBody3D

# MOV001 mache, MOV002 kouri, MOV003 sprint
const WALK_SPEED := 3.0
const RUN_SPEED := 6.0
const SPRINT_SPEED := 9.0
const JUMP_VELOCITY := 4.5

# Done ki soti nan jwistik ak bouton yo
var move_input := Vector2.ZERO
var sprint_pressed := false
var jump_requested := false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
# Gravite
if not is_on_floor():
velocity.y -= gravity * delta

# Sote: bouton tactil oswa klavye
if (Input.is_action_just_pressed("jump") or jump_requested) and is_on_floor():
velocity.y = JUMP_VELOCITY
jump_requested = false

# Dirèksyon: tactil dabò, si pa gen, klavye
var input := move_input
if input == Vector2.ZERO:
input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")

var moving := input.length() > 0.1
var speed := WALK_SPEED
if moving:
speed = RUN_SPEED
if sprint_pressed:
speed = SPRINT_SPEED

var direction := (transform.basis * Vector3(input.x, 0, input.y)).normalized()
if direction != Vector3.ZERO:
velocity.x = direction.x * speed
velocity.z = direction.z * speed
else:
velocity.x = move_toward(velocity.x, 0, speed)
velocity.z = move_toward(velocity.z, 0, speed)

move_and_slide()
