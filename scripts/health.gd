extends Node

# Sistèm sante. Mete l kòm yon nœud anfan nan Player.
signal damaged(amount: float, part: String)
signal downed
signal died

const MAX_HP := 100.0
const DOWN_TIME := 30.0      # Segonn yon jwè tonbe anvan li mouri (COM005)
const BLEED_RATE := 2.0      # HP pou chak segonn ki tonbe pandan senyen

var hp := MAX_HP
var is_downed := false
var is_dead := false
var bleeding := false        # COM011
var leg_wounded := false     # COM003
var arm_wounded := false     # COM004
var down_timer := 0.0

func _process(delta: float) -> void:
if not is_downed:
return
down_timer -= delta
if bleeding:
hp = max(hp - BLEED_RATE * delta, 0.0)
if down_timer <= 0.0:
die()

func take_damage(amount: float, part: String = "body") -> void:
if is_dead or is_downed:
return
hp = max(hp - amount, 0.0)
damaged.emit(amount, part)
if part == "leg":
leg_wounded = true
elif part == "arm":
arm_wounded = true
bleeding = true   # Chak blesi fè senyen
if hp <= 0.0:
_go_down()

func _go_down() -> void:
is_downed = true
down_timer = DOWN_TIME
downed.emit()

func revive(amount: float = 30.0) -> void:   # COM006
if not is_downed:
return
is_downed = false
hp = amount
bleeding = false
down_timer = 0.0

func bandage() -> void:   # MED001
bleeding = false

func heal(amount: float) -> void:   # MED002
if is_dead or is_downed:
return
hp = min(hp + amount, MAX_HP)

func die() -> void:   # COM008
if is_dead:
return
is_dead = true
is_downed = false
died.emit()
