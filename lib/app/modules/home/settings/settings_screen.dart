import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: Card(
              margin: EdgeInsets.all(8),
              elevation: 4,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.sunny),
                  SizedBox(width: 5),
                  Text('Tela sempre acesa'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Card(
              margin: EdgeInsets.all(8),
              elevation: 4,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.scoreboard_sharp),
                  SizedBox(width: 5),
                  Text('Pontuação máxima'),
                  Spacer(),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '12',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
