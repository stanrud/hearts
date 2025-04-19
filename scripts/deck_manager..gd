extends Node

const CardScene = preload("res://scenes/card.tscn")

var deck: Array[Node2D] = []

@onready var card_data = CardData.new()
@onready var PlayerScene = preload("res://scenes/player.tscn")
var players: Array = []

func _ready():
	print("DeckManager is ready")
	create_deck()
	shuffle_deck()
	position_players()
	deal_cards()

func create_deck():
	print("Creating deck...")
	deck.clear()
	for suit in card_data.suits:
		for rank in card_data.ranks:
			var value = card_data.get_card_value(rank)
			var card = CardScene.instantiate()

			if not card.has_node("Sprite"):
				print("⚠️ Missing Sprite in card scene:", card)
			else:
				print("✅ Card created with Sprite:", card)

			card.set_card(suit, rank, value)
			card.flip(true)
			deck.append(card)
	print("Deck created with %s cards" % deck.size())

func shuffle_deck():
	deck.shuffle()

func position_players():
	var positions = [
		Vector2(400, 1600),  # Bottom (Player 1)
		Vector2(100, 600),  # Left (Player 2)
		Vector2(400, 300),  # Top (Player 3)
		Vector2(980, 600)   # Right (Player 4)
	]
	for i in range(4):
		var player = PlayerScene.instantiate()
		player.position = positions[i]
		add_child(player)
		players.append(player)

		# Optional: set horizontal layout flag depending on position
		player.is_horizontal = i % 2 == 0

func deal_cards():
	var current_player = 0
	for card in deck:
		if current_player == 0:
			card.flip(true)
		else:
			card.flip(false)
		players[current_player].add_card(card)
		current_player = (current_player + 1) % 4
