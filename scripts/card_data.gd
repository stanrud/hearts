class_name CardData

var suits = ["hearts", "diamonds", "clubs", "spades"]
var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]

func get_card_value(rank: String) -> int:
	match rank:
		"jack": return 11
		"queen": return 12
		"king": return 13
		"ace": return 14
		_: return int(rank)
