import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void decrement() {
    setState(() {
      count--;
    });
    if (kDebugMode) {
      print(count);
    }
  }

  void increment() {
    setState(() {
      count++;
    });
    if (kDebugMode) {
      print(count);
    }
  }

  void reset() {
    setState(() {
      count = 0;
    });
    if (kDebugMode) {
      print(count);
    }
  }

  bool get isEmpty => count == 0;

  bool get isFull => count == 20;

  bool get isReset => count == 0;

  String getStatusMessage() {
    return isFull ? 'Lotado!' : 'Disponível!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.12),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 56,
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                color: isFull ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  getStatusMessage(),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'TOTAL DE PESSOAS',
            style: TextStyle(
              fontSize: 35.0,
              color: isFull ? Colors.red : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 100,
              color: isFull ? Colors.red : Colors.white,
            ),
          ),
          Text(
            'Capacidade máxima de pessoas: 20 pessoas',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isFull ? Colors.red : Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: isEmpty ? null : decrement,
                style: TextButton.styleFrom(
                  backgroundColor:
                  isEmpty ? Colors.white.withOpacity(0.4) : Colors.red,
                  fixedSize: const Size(100, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'SAÍDA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              TextButton(
                onPressed: isFull ? null : increment,
                style: TextButton.styleFrom(
                  backgroundColor:
                  isFull ? Colors.white.withOpacity(0.4) : Colors.green,
                  fixedSize: const Size(100, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'ENTRADA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: isReset ? null : reset,
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Zerar contador',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
