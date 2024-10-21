import 'package:contador_flutter/modules/home_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marcador de Truco',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomeScreen(),
      )
  );
}




