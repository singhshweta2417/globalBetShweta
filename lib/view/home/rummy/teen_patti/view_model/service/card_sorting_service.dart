
import '../../model/card_model.dart';

class CardSortingService {
  void sortCards(List<CardModel> cards) {
    cards.sort((a, b) => a.rank.compareTo(b.rank));
  }

  bool isTrail(List<CardModel> cards) {
    return cards.length == 3 &&
        cards[0].rank == cards[1].rank &&
        cards[1].rank == cards[2].rank;
  }

  bool isPureSequence(List<CardModel> cards) {
    if (cards.length < 3) return false;
    sortCards(cards);

    for (int i = 1; i < cards.length; i++) {
      if (cards[i].suit != cards[0].suit ||
          cards[i].rank != cards[i - 1].rank + 1) {
        return false;
      }
    }
    return true;
  }

  bool isSequence(List<CardModel> cards) {
    if (cards.length < 3) return false;
    sortCards(cards);

    for (int i = 1; i < cards.length; i++) {
      if (cards[i].rank != cards[i - 1].rank + 1) {
        return false;
      }
    }
    return true;
  }

  bool isColor(List<CardModel> cards) {
    return cards.length == 3 &&
        cards[0].suit == cards[1].suit &&
        cards[1].suit == cards[2].suit &&
        !isPureSequence(cards);
  }

  bool isPair(List<CardModel> cards) {
    if (cards.length != 3) return false;
    return (cards[0].rank == cards[1].rank ||
        cards[1].rank == cards[2].rank ||
        cards[0].rank == cards[2].rank);
  }

  CardModel getHighCard(List<CardModel> cards) {
    if (cards.isEmpty) throw Exception('No cards in the list');
    sortCards(cards);
    return cards.last;
  }

  int getHandRank(List<CardModel> cards) {
    if (isTrail(cards)) return 6;
    if (isPureSequence(cards)) return 5;
    if (isSequence(cards)) return 4;
    if (isColor(cards)) return 3;
    if (isPair(cards)) return 2;
    return 1;
  }

  dynamic compareHands(List<CardModel> hand1, List<CardModel> hand2,
      String player1, String player2) {
    int rank1 = getHandRank(hand1);
    int rank2 = getHandRank(hand2);

    if (rank1 > rank2) {
      return {'player_id': player1, 'rank_name': handRankName(rank1), 'lose_id':player2};
    }
    if (rank1 < rank2) {
      return {'player_id': player2, 'rank_name': handRankName(rank2), 'lose_id':player1};
    }

    sortCards(hand1);
    sortCards(hand2);

    for (int i = hand1.length - 1; i >= 0; i--) {
      if (hand1[i].rank > hand2[i].rank) {
        return {'player_id': player1, 'rank_name': 'High card', 'lose_id':player2};
      }
      if (hand1[i].rank < hand2[i].rank) {
        return {'player_id': player2, 'rank_name': 'High card', 'lose_id':player1};
      }
    }
    return {'player_id': player1, 'rank_name': 'Tie', 'lose_id':player2};
  }

  String handRankName(int rank) {
    switch (rank) {
      case 6:
        return "Trail (Three of a Kind)";
      case 5:
        return "Pure Sequence (Straight Flush)";
      case 4:
        return "Sequence (Straight)";
      case 3:
        return "Color (Flush)";
      case 2:
        return "Pair (Two of a King)";
      case 1:
      default:
        return "High Card";
    }
  }
}
