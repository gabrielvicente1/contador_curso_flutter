import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isScreenAwake = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: Card(
              margin: const EdgeInsets.all(8),
              elevation: 4,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.sunny),
                  const SizedBox(width: 5),
                  const Text('Tela sempre acesa'),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: _isScreenAwake,
                      activeColor: Colors.indigo,
                      onChanged: (bool value) {
                        setState(() {
                          _isScreenAwake = value;
                          if (_isScreenAwake) {
                            WakelockPlus.enable();
                            _showToast("Tela sempre acesa ativado");
                          } else {
                            WakelockPlus.disable();
                            _showToast("Tela sempre acesa desativado");
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Card(
              margin: const EdgeInsets.all(8),
              elevation: 4,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.scoreboard_sharp),
                  const SizedBox(width: 5),
                  const Text('Pontuação máxima'),
                  const Spacer(),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '12',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: const Text('EQUIPES', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(4, 2, 8, 2),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(

                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Eles',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
