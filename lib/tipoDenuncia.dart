import 'package:flutter/material.dart';
import 'formularioScreen.dart';
import 'formularioScreenIdentificado.dart';
class TipoDenuncia extends StatefulWidget {
  @override
  _TipoDenunciaState createState() => _TipoDenunciaState();
}

class _TipoDenunciaState extends State<TipoDenuncia> {
  String _selectedDenuncia = 'Racismo'; // Valor inicial
  String _selectedAnonimato = 'Identificado'; // Valor inicial

  final List<String> _denunciaOptions = ['Racismo', 'Injúria', 'Intolerância'];
  final List<String> _anonimatoOptions = ['Identificado', 'Anônimo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Tipo de Denúncia'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selecione o Tipo de Denúncia:'),
            DropdownButton<String>(
              value: _selectedDenuncia,
              onChanged: (newValue) {
                setState(() {
                  _selectedDenuncia = newValue!;
                });
              },
              items: _denunciaOptions.map((denuncia) {
                return DropdownMenuItem<String>(
                  value: denuncia,
                  child: Text(denuncia),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Selecione o Anonimato:'),
            DropdownButton<String>(
              value: _selectedAnonimato,
              onChanged: (newValue) {
                setState(() {
                  _selectedAnonimato = newValue!;
                });
              },
              items: _anonimatoOptions.map((anonimato) {
                return DropdownMenuItem<String>(
                  value: anonimato,
                  child: Text(anonimato),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedAnonimato == 'Identificado') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyCustomFormIdentificado(
                        selectedDenuncia: _selectedDenuncia,
                        selectedAnonimato: _selectedAnonimato,
                      ),

                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyCustomForm(
                        selectedDenuncia: _selectedDenuncia,
                        selectedAnonimato: _selectedAnonimato,
                      ),
                    ),
                  );
                }
              },
              child: Text('Continuar para o Formulário'),
            ),
          ],
        ),
      ),
    );
  }
}
