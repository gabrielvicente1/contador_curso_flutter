import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class OrderCardsScreen extends StatelessWidget {
  final List<PlayingCard> trucoCards = [
    PlayingCard(Suit.diamonds, CardValue.queen),
    PlayingCard(Suit.spades, CardValue.queen),
    PlayingCard(Suit.hearts, CardValue.queen),
    PlayingCard(Suit.clubs, CardValue.queen),
    PlayingCard(Suit.diamonds, CardValue.jack),
    PlayingCard(Suit.spades, CardValue.jack),
    PlayingCard(Suit.hearts, CardValue.jack),
    PlayingCard(Suit.clubs, CardValue.jack),
    PlayingCard(Suit.diamonds, CardValue.king),
    PlayingCard(Suit.spades, CardValue.king),
    PlayingCard(Suit.hearts, CardValue.king),
    PlayingCard(Suit.clubs, CardValue.king),
    PlayingCard(Suit.diamonds, CardValue.ace),
    PlayingCard(Suit.spades, CardValue.ace),
    PlayingCard(Suit.hearts, CardValue.ace),
    PlayingCard(Suit.clubs, CardValue.ace),
    PlayingCard(Suit.diamonds, CardValue.two),
    PlayingCard(Suit.spades, CardValue.two),
    PlayingCard(Suit.hearts, CardValue.two),
    PlayingCard(Suit.clubs, CardValue.two),
    PlayingCard(Suit.diamonds, CardValue.three),
    PlayingCard(Suit.spades, CardValue.three),
    PlayingCard(Suit.hearts, CardValue.three),
    PlayingCard(Suit.clubs, CardValue.three),
    PlayingCard(Suit.diamonds, CardValue.seven),
    PlayingCard(Suit.spades, CardValue.ace),
    PlayingCard(Suit.hearts, CardValue.seven),
    PlayingCard(Suit.clubs, CardValue.four),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ordem das cartas', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          backgroundColor: Colors.indigo,
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: trucoCards.length,
            itemBuilder: (context, index) {
              return PlayingCardView(
                card: trucoCards[index],
                showBack: false, // Exibe a face da carta
              );
            }));
  }
}
