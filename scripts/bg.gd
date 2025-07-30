extends ParallaxBackground

@export var scroll_speed = 15
@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")

@onready var sprite = $ParallaxLayer/Sprite2D

const MAX_POSITION = Vector2(64, 64)

func _ready() -> void:
	sprite.texture = bg_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	
	if (sprite.region_rect.position >= MAX_POSITION):
		sprite.region_rect.position = Vector2.ZERO
