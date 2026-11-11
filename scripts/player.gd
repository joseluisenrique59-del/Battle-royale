extends CharacterBody3D

# MOV001 mache, MOV002 kouri, MOV003 sprint
const WALK_SPEED := 3.0
const RUN_SPEED := 6.0
const SPRINT_SPEED := 9.0
const JUMP_VELOCITY := 4.5
const MOUSE_SENS := 0.003

# Ekran tactil la ap ekri nan varyab sa a (x = gòch/dwat, y = devan/dèyè)
var move_input := Vector2.ZERO
var sprint_pressed := false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
.git/# Gravite
.git/if not is_on_floor():
.git/velocity.y -= gravity * delta

.git/# Sote (sote an tès)
.git/if Input.is_action_just_pressed("jump") and is_on_floor():
.git/velocity.y = JUMP_VELOCITY

.git/# Dirèksyon: tactil dabò, si pa gen, klavye
.git/var input := move_input
.git/if input == Vector2.ZERO:
.git/input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")

.git/var moving := input.length() > 0.1
.git/var speed := WALK_SPEED
.git/if moving:
.git/speed = RUN_SPEED
.git/if sprint_pressed:
.git/speed = SPRINT_SPEED

.git/var direction := (transform.basis * Vector3(input.x, 0, input.y)).normalized()
.git/if direction != Vector3.ZERO:
.git/velocity.x = direction.x * speed
.git/velocity.z = direction.z * speed
.git/else:
.git/velocity.x = move_toward(velocity.x, 0, speed)
.git/velocity.z = move_toward(velocity.z, 0, speed)

.git/move_and_slide()
