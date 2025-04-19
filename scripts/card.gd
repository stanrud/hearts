extends Node2D
class_name Card

@export var suit: String = ""
@export var rank: String = ""
@export var value: int = 0  # Used for determining trick winner
@export var back: String = "green2"
@export var card_texture: Texture2D

@onready var sprite = $Sprite

var is_face_up = false
var is_selected = false
var is_played = false

func _ready():
	update_visual()
	set_process_input(true)
	if not is_in_group("Card"):
		add_to_group("Card")

func _input(event):
	if (event is InputEventScreenTouch and event.pressed):
		if is_topmost_card_at_position(event.position):
			if not is_selected:
				select()
			elif is_selected and not is_played:
				# Only play if it's the topmost selected card
				play_card()

func is_topmost_card_at_position(pos: Vector2) -> bool:
	var cards = get_tree().get_nodes_in_group("Card")

	for i in range(cards.size() - 1, -1, -1):
		var card = cards[i]
		if not card.is_visible_in_tree():
			continue

		var local_pos = card.to_local(pos)
		if card.sprite.get_rect().has_point(local_pos):
			return card == self  # Only return true if *this* card is the topmost match

	return false

func select():
	# Deselect all sibling cards in the same hand
	for sibling in get_parent().get_children():
		if sibling != self and sibling is Card:
			sibling.deselect()
	if not is_selected:
		is_selected = true
		position.y -= 20

func deselect():
	if is_selected:
		is_selected = false
		position.y += 20

func set_card(_suit: String, _rank: String, _value: int):
	suit = _suit
	rank = _rank
	value = _value
	#update_visual()

func update_visual():
	if not sprite:
		push_error("Sprite node is missing on this Card scene")
		return

	if card_texture:
		sprite.texture = card_texture

	if is_face_up:
		sprite.texture = load("res://cards/images/%s_of_%s.png" % [rank, suit])
	else:
		sprite.texture = load("res://cards/images/card_back_%s.png" % [back])

func flip(face_up: bool):
	is_face_up = face_up

func play_card():
	if is_played:
		return

	var play_area = get_tree().get_root().get_node("Game/PlayArea")
	get_parent().remove_child(self)
	play_area.add_child(self)

	# Move card to center of play area
	global_position = play_area.global_position
	is_selected = false
	is_played = true
