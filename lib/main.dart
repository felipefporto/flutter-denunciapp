import 'package:flutter/material.dart';
import 'TipoDenuncia.dart'; // Importe a classe TipoDenuncia
import 'formHistory.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Home';
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('DenunciAPP'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TipoDenuncia(), // Abra a tela TipoDenuncia
                  ),
                );
              },
              child: Text('Iniciar Denúncia'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FormSubmissionHistoryScreen(), // Navigate to FormSubmissionHistoryScreen
                  ),
                );
              },
              child: Text('Histórico de Denúncias'),
            ),
          ],
        ),
      ),
    );
  }
}


