import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class OrderCardsScreen extends StatelessWidget {
  final List<PlayingCard> trucoCards = [
    PlayingCard(Suit.diamonds, CardValue.ten),
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
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: const Text(
          'Ordem das cartas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/imagem_fundo_app_truco.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: trucoCards.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2), // Borda da carta
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'TRUCO MINEIRO', // Texto personalizado
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return PlayingCardView(
                card: trucoCards[index],
                showBack: false, // Exibe a face da carta
              );
            }
          },
        ),
      ),
    );
  }
}
