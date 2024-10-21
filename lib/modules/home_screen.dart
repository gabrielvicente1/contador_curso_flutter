import 'package:audioplayers/audioplayers.dart';
import 'package:contador_flutter/models/player_models.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final _playerOne = Player(name: "Nós", score: 2, victories: 1);
  final _playerTwo = Player(name: "Eles", score: 2, victories: 1);

  @override
  void initState() {
    super.initState();
    _resetAllPlayers();
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
              player.score--;
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
                confirm: () {
                  setState(() {
                    player.victories++;
                  });
                  _resetAllPlayers(resetVictories: false);
                },
                cancel: () {
                  setState(() {
                    player.score--; // Volta para 11 pontos se cancelar
                  });
                },
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

  bool _isPlaying = false;

  void playSound() async {
    if (_isPlaying) return; // Previne a reprodução de múltiplos sons
    _isPlaying = true; // Indica que o som está sendo reproduzido
    try {
      await _audioPlayer.setSource(AssetSource('assets/som_de_pato.mp3'));
      await _audioPlayer.resume();
    } catch (error) {
      "Erro ao reproduzir o áudio: $error";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao reproduzir o áudio')),
      );
    } finally {
      _isPlaying = false; // Reseta o estado
    }
  }

  void _showDialog({
    required String title,
    required String message,
    required Function confirm,
    required Function cancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            Center(
              child: InkWell(
                onTap: () {
                  playSound();
                },
                child: Image.asset('assets/images/pato_chorando_r.png'),
              ),
            ),
            ElevatedButton(
              child: const Text("CANCELAR"),
              onPressed: () {
                Navigator.of(context).pop();
                cancel();
              },
            ),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                confirm();
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
        title: const Text('Marcador de Truco',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.indigo,
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
