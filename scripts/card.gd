extends Node2D

@export var suit: String = ""
@export var rank: String = ""
@export var value: int = 0  # Used for determining trick winner
@export var back: String = "green2"

@onready var sprite = $Sprite

var is_face_up = false

func _ready():
	update_visual()

func set_card(_suit: String, _rank: String, _value: int):
	suit = _suit
	rank = _rank
	value = _value
	#update_visual()

func update_visual():
	if not sprite:
		push_error("Sprite node is missing on this Card scene")
		return

	if is_face_up:
		sprite.texture = load("res://cards/images/%s_of_%s.png" % [rank, suit])
	else:
		sprite.texture = load("res://cards/images/card_back_%s.png" % [back])

func flip(face_up: bool):
	is_face_up = face_up
