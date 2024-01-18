extends CharacterBody2D

@onready var anim = $anim as AnimationPlayer
@onready var texture = $texture as Sprite2D
@onready var attack_area_collision = $attack_area/collision as CollisionShape2D
@onready var auxiliar_anim = $auxiliar_anim as AnimationPlayer

var can_attack: bool = true
var can_die: bool = false

@export var health: int = 5
@export var move_speed: float = 256.0
@export var damage: int = 1

func _ready():
	pass



func _physics_process(delta):
	if ( can_attack == false or
		can_die
		):
		return
	move()
	animate()
	attack_handler()



func move():
	var direction: Vector2 = get_direction()
	velocity = direction * move_speed
	move_and_slide()



func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis('move_left', 'move_right'), 
		Input.get_axis('move_up', 'move_down')
	).normalized()



func animate():
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_collision.position.x = 58
	elif velocity.x < 0:
		texture.flip_h = true
		attack_area_collision.position.x = -58


	if velocity != Vector2.ZERO:
		anim.play('run')
		return
	anim.play('idle')



func attack_handler():
	if Input.is_action_just_pressed("key_attack") and can_attack:
		can_attack = false
		anim.play('attack')


func _on_attack_area_body_entered(body):
	body.update_health(damage)


func update_health(value: int):
	health -= value
	if health <= 0:
		can_die = true
		anim.play('death')
		attack_area_collision.set_deferred('disabled', true)
		
		return
	
	auxiliar_anim.play('hit')

func _on_anim_animation_finished(anim_name: String):
	match anim_name:
		'attack':
			can_attack = true
		
		
		'death':
			get_tree().reload_current_scene()
		
