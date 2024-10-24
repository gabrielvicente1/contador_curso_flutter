import 'package:audioplayers/audioplayers.dart';
import 'package:contador_flutter/app/models/player_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
        color: Colors.white,
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
    required Color color,
    required Function onTap,
    required String textButton,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/trevo.png',
            width: 80,
            height: 90,
          ),
          Text(
            textButton,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 4),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedButtonHeart({
    required Color color,
    required Function onTap,
    required String textButton,

  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/copas.png',
            width: 80,
            height: 90,
          ),
          Text(
            textButton,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 4),
              Text(
                textButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showScoreButtons(Player player) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildRoundedButtonHeart(
          color: Colors.white,
          onTap: () {
            setState(() {
              if (player.score > 0) player.score--;
            });
          },
            textButton: '-1',
        ),
        _buildRoundedButton(
          text: '+1',
          color: Colors.red,
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
          textButton: '+1',
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
                child: Image.asset('assets/images/pato-445x445.png'),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              child: const Text("NOVO JOGO", style: TextStyle(color: Colors.white),),
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
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              _resetAllPlayers();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:   [
             DrawerHeader(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/naipes-baralho-truco.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/icons/icone-de-cartas.png'),
              title: const Text('Ordem das Cartas'),
              onTap: (){
                Modular.to.pushNamed('/orderCards');
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/icone-configuracao.png'),
              title: const Text('Configurações'),
              onTap: (){
                Modular.to.pushNamed('/settings');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/imagem_fundo_app_truco.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
      ),
    );
  }
}
