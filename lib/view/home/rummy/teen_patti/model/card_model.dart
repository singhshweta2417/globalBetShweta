

import 'package:flutter/material.dart';

class CardModel {
  final int id;
  final String suit;
  final String rankName;
  final int rank;
  final String imageUrl;

  CardModel({
    required this.id,
    required this.suit,
    required this.rankName,
    required this.rank,
    required this.imageUrl,
  });

  @override
  String toString() {
    return '$rankName of $suit';
  }

  // Convert CardModel to Fire store Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'suit': suit,
      'rankName': rankName,
      'rank': rank,
      'imageUrl': imageUrl,
    };
  }

  // Convert Map to CardModel
  static CardModel fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      suit: map['suit'],
      rankName: map['rankName'],
      rank: map['rank'],
      imageUrl: map['imageUrl'],
    );
  }
}
