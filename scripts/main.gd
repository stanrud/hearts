extends Node


@onready var card_manager = $CardManager
@onready var card_factory = $CardManager/CardFactory
@onready var hand = $CardManager/Hand
@onready var hand2 = $CardManager/Hand2
@onready var hand3 = $CardManager/Hand3
@onready var hand4 = $CardManager/Hand4
@onready var deck = $CardManager/Deck
@onready var discard = $CardManager/Discard


func _ready():
	_reset_deck()
	_on_draw_cards()
	

func _reset_deck():
	var list = _get_randomized_card_list()
	deck.clear_cards()
	for card in list:
		card_factory.create_card(card, deck)


func _get_randomized_card_list() -> Array:
	var suits = ["club", "spade", "diamond", "heart"]
	var values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
	
	var card_list = []
	for suit in suits:
		for value in values:
			card_list.append("%s_%s" % [suit, value])
	
	card_list.shuffle()
	
	return card_list

func _on_draw_cards() -> void:
	hand.move_cards(deck.get_top_cards(13))
	hand2.move_cards(deck.get_top_cards(13))
	hand3.move_cards(deck.get_top_cards(13))
	hand4.move_cards(deck.get_top_cards(13))

func _on_draw_1_button_pressed() -> void:
	hand.move_cards(deck.get_top_cards(1))


func _on_draw_3_button_pressed() -> void:
	var current_draw_number = 3
	while current_draw_number > 0:
		var result = hand.move_cards(deck.get_top_cards(current_draw_number))
		if result:
			break
		current_draw_number -= 1


func _on_reset_deck_button_pressed():
	_reset_deck()


func _on_undo_button_pressed():
	card_manager.undo()


func _on_shuffle_hand_button_pressed():
	hand.shuffle()


func _on_discard_1_button_pressed():
	var cards = hand.get_random_cards(1)
	discard.move_cards(cards)


func _on_discard_3_button_pressed():
	var cards = hand.get_random_cards(3)
	discard.move_cards(cards)


func _on_move_to_pile_1_button_pressed():
	var cards = hand.get_random_cards(1)
	hand2.move_cards(cards)


func _on_move_to_pile_2_button_pressed():
	var cards = hand.get_random_cards(1)
	hand3.move_cards(cards)


func _on_move_to_pile_3_button_pressed():
	var cards = hand.get_random_cards(1)
	hand4.move_cards(cards)


func _on_clear_all_button_pressed():
	_reset_deck()
	hand.clear_cards()
	hand2.clear_cards()
	hand3.clear_cards()
	hand4.clear_cards()
	discard.clear_cards()
