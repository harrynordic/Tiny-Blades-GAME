extends CharacterBody2D

@onready var anim = $anim as AnimationPlayer
@onready var auxiliar_anim = $auxiliar_anim as AnimationPlayer
@onready var texture = $texture as Sprite2D

const ATTACK_AREA: PackedScene = preload('res://prefabs/enemy_attack_area.tscn')
const OFFSET: Vector2 = Vector2(0, 31)

var player_ref: CharacterBody2D = null
var can_die: bool = false

@export var health: int = 3
@export var move_speed: float = 192.0
@export var distance_limit: float = 60.0




func _physics_process(delta):
	if can_die == true:
		return
	
	if player_ref == null or player_ref.can_die:
		velocity = Vector2.ZERO
		animate()
		return
		
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance: float = global_position.distance_to(player_ref.global_position)
	
	if distance < distance_limit:
		anim.play('attack')
		return
	
	
	velocity = direction * move_speed
	move_and_slide()
	animate()


func spawn_attack_area() -> void:
	var attack_area = ATTACK_AREA.instantiate()
	attack_area.position = OFFSET
	add_child(attack_area)


func animate():
	if velocity.x > 0:
		texture.flip_h = false
	elif velocity.x < 0:
		texture.flip_h = true
		
		
	if velocity != Vector2.ZERO:
		anim.play('run')
		return
		
	anim.play('idle')


func update_health(value: int):
	health -= value
	if health <= 0:
		can_die = true
		anim.play('death')
		
		return
	
	auxiliar_anim.play('hit')


func _on_detection_area_body_entered(body):
	player_ref = body


func _on_detection_area_body_exited(_body):
	player_ref = null


func _on_anim_animation_finished(anim_name):
	if anim_name == 'death':
		queue_free()
