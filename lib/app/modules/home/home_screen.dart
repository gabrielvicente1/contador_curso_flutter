import 'package:audioplayers/audioplayers.dart';
import 'package:contador_flutter/app/models/player_models.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}


class HomeScreenState extends State<HomeScreen> {
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 3));

  final _playerOne = Player(name: "Nós", score: 2, victories: 1);
  final _playerTwo = Player(name: "Eles", score: 2, victories: 1);

  @override
  void initState() {
    super.initState();
    _resetAllPlayers();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _resetPlayer({required Player player, bool resetVictories = true}) {
    setState(() {
      player.score = 0;
      if (resetVictories) player.victories = 0;
    });
  }

  void _resetAllPlayers({bool resetVictories = true}) {
    _resetPlayer(player: _playerOne, resetVictories: resetVictories);
    _resetPlayer(player: _playerTwo, resetVictories: resetVictories);
  }

  Widget _showPlayerName(String name) {
    return Text(
      name.toUpperCase(),
      style: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
        color: Colors.indigo,
      ),
    );
  }

  Widget _showPlayerScore(int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        "$score",
        style: const TextStyle(fontSize: 80.0),
      ),
    );
  }

  Widget _buildRoundedButton({
    required String text,
    double size = 52.0,
    required Color color,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ClipOval(
        child: Container(
          color: color,
          height: size,
          width: size,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showScoreButtons(Player player) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildRoundedButton(
          text: '-1',
          color: Colors.black.withOpacity(0.1),
          onTap: () {
            setState(() {
              if (player.score > 0) player.score--;
            });
          },
        ),
        _buildRoundedButton(
          text: '+1',
          color: Colors.indigo,
          onTap: () {
            if (player.score == 11) {
              _showDialog(
                title: 'Fim do jogo',
                message: '${player.name} ganhou!',
              );
            } else {
              setState(() {
                player.score++;
              });
            }
          },
        ),
      ],
    );
  }

  void playSound() async {
    try {
      final newPlayer = AudioPlayer();
      await newPlayer.setSource(AssetSource('som_de_pato.mp3'));
      await newPlayer.resume();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao reproduzir o áudio: $error')),
      );
    }
  }

  void _showDialog({
    required String title,
    required String message,
  }) {
    _confettiController.play();  // Iniciar confetes ao abrir o modal
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
              ),
              Text(message),
              Center(
                child: InkWell(
                  onTap: () {
                    playSound();
                  },
                  child: Image.asset('assets/images/pato-445x445.png'),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("NOVO JOGO"),
              onPressed: () {
                setState(() {
                  _resetAllPlayers();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Truco',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              _resetAllPlayers();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        backgroundColor: Colors.indigo,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/icons/icone-de-cartas.png'),
              title: const Text('Ordem das Cartas'),
              onTap: () {
                Modular.to.pushNamed('/orderCards');
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/icone-configuracao.png'),
              title: const Text('Configurações'),
              onTap: () {
                Modular.to.pushNamed('/settings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _showPlayerName(_playerOne.name),
                  _showPlayerScore(_playerOne.score),
                  _showScoreButtons(_playerOne),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _showPlayerName(_playerTwo.name),
                  _showPlayerScore(_playerTwo.score),
                  _showScoreButtons(_playerTwo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
