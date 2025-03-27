

import '../../model/card_model.dart';

class DeckModel {
  List<CardModel> cards = [];

  DeckModel() {
    List<String> suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades'];
    List<String> ranks = [
      'Ace',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      'Jack',
      'Queen',
      'King'
    ];

    Map<String, int> rankIds = {
      'Ace': 14,
      '2': 2,
      '3': 3,
      '4': 4,
      '5': 5,
      '6': 6,
      '7': 7,
      '8': 8,
      '9': 9,
      '10': 10,
      'Jack': 11,
      'Queen': 12,
      'King': 13,
    };

    int idCounter = 0;
    for (var suit in suits) {
      for (var rank in ranks) {
        print("assets/cards/${suit.toLowerCase()}/${rank.toLowerCase()}_of_${suit.toLowerCase()}.png");
        cards.add(CardModel(
          id: idCounter++,
          suit: suit,
          rankName: rank,
          rank: rankIds[rank]!,
          imageUrl: 'assets/cards/${suit.toLowerCase()}/${rank.toLowerCase()}_of_${suit.toLowerCase()}.png',
        ));
      }
    }
  }

  void shuffle() {
    cards.shuffle();
  }

  void distributeCards(List<dynamic> players, int cardsPerPlayer) {
    shuffle();
    for (int i = 0; i < cardsPerPlayer; i++) {
      for (var player in players) {
        if (cards.isEmpty) {
          throw Exception('Not enough cards to deal');
        }
        player.hand.add(cards.removeAt(0));
      }
    }
  }

  List<CardModel> deal(int numberOfCards) {
    if (numberOfCards > cards.length) {
      throw Exception('Not enough cards to deal');
    }
    List<CardModel> dealtCards = cards.sublist(0, numberOfCards);
    cards.removeRange(0, numberOfCards);
    return dealtCards;
  }
  @override
  String toString() {
    return cards.toString();
  }
}
