extends Node2D

@onready var hand: Node2D = get_node_or_null("Hand")
@export var is_horizontal := true

func add_card(card: Node2D):
	if hand:
		hand.add_child(card)
		layout_hand()
	else:
		push_error("Player has no 'Hand' node!")

func layout_hand():
	var spacing = 30  # Adjust for card size
	for i in hand.get_child_count():
		var card = hand.get_child(i)
		if is_horizontal:
			card.position = Vector2(i * spacing, 0)
		else:
			card.position = Vector2(0, i * spacing)
