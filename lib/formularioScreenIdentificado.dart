import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dbHelper.dart';

class MyCustomFormIdentificado extends StatefulWidget {
  final String selectedDenuncia;
  final String selectedAnonimato;

  MyCustomFormIdentificado({
    required this.selectedDenuncia,
    required this.selectedAnonimato,
  });

  @override
  _MyCustomFormIdentificadoState createState() => _MyCustomFormIdentificadoState();
}

class _MyCustomFormIdentificadoState extends State<MyCustomFormIdentificado> {
  final _formKey = GlobalKey<FormState>();

  List<String> _tipoAgressaoOptions = [
    'Praticar, induzir, ou incitar a discriminação ou preconceito de raça, cor, etnia, ou procedência nacional',
    'Impedir ou obstar acesso a cargo público',
    'Impedir o acesso ou uso de qualquer tipo de transporte público',
    'Tratamento diferenciado no ambiente de trabalho',
    'Exigência de aspectos de aparência próprios de raça ou etnia em anúncios ou outras formas de recrutamento de trabalhadores',
    'Recusar ou impedir acesso a estabelecimento comercial',
    'Impedir acesso às entradas sociais em edifícios públicos ou residenciais e elevadores ou escada de acesso',
    'Impedir ou dificultar o casamento ou convivência familiar e social',
    'Xingar, humilhar, ameaçar, perseguir, chantagear ou incitar violência psicológica',
    'Bater, empurrar, chutar, violentar, puxar o cabelo ou incitar violência física',
    'Caluniar, injuriar, difamar ou incitar violência moral',
    'Forçar o ato sexual, forçar práticas sexuais, negar-se ao uso de preservativo, impedir o uso de contraceptivo ou incitar violência sexual',
    'Reter, controlar, destruir bens, objetos ou dinheiro. Impedir o acesso, busca, remuneração, ou obstar acesso ao trabalho',
    'Outros',
  ];

  String _selectedTipoAgressao = 'Praticar, induzir, ou incitar a discriminação ou preconceito de raça, cor, etnia, ou procedência nacional';

  List<String> _sexoOptions = ['Masculino', 'Feminino'];
  List<String> _religiaoOptions = [
    'Católica',
    'Judaica',
    'Evangélica',
    'Espírita',
    'Budista',
    'Hindu',
    'Islâmica',
    'Candomblé',
    'Umbanda',
    'Jurema Sagrada',
    'Ateu',
    'Outra',
    'Sem Religião'
  ];
  List<String> _corRacaOptions = [
    'Sem declaração',
    'Preta',
    'Branca',
    'Amarela',
    'Parda',
    'Indígena'
  ];

  TextEditingController _nomeDenuncianteController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _enderecoDenuncianteController = TextEditingController();
  TextEditingController _bairroDenuncianteController = TextEditingController();
  TextEditingController _estadoDenuncianteController = TextEditingController();
  TextEditingController _cidadeDenuncianteController = TextEditingController();
  TextEditingController _emailDenuncianteController = TextEditingController();
  TextEditingController _telefoneDenuncianteController = TextEditingController();
  TextEditingController _celularDenuncianteController = TextEditingController();
  TextEditingController _corRacaDenuncianteController = TextEditingController();

  TextEditingController _nomeAgressorController = TextEditingController();
  TextEditingController _enderecoAgressorController = TextEditingController();
  TextEditingController _bairroAgressorController = TextEditingController();
  TextEditingController _cepAgressorController = TextEditingController();
  TextEditingController _estadoAgressorController = TextEditingController();
  TextEditingController _cidadeAgressorController = TextEditingController();
  TextEditingController _idadeAgressorController = TextEditingController();

  TextEditingController _nomeVitimaController = TextEditingController();
  TextEditingController _enderecoVitimaController = TextEditingController();
  TextEditingController _bairroVitimaController = TextEditingController();
  TextEditingController _cepVitimaController = TextEditingController();
  TextEditingController _estadoVitimaController = TextEditingController();
  TextEditingController _cidadeVitimaController = TextEditingController();
  TextEditingController _idadeVitimaController = TextEditingController();

  TextEditingController _dataHoraOcorrenciaController = TextEditingController();
  TextEditingController _localOcorrenciaController = TextEditingController();
  TextEditingController _descricaoFatoController = TextEditingController();

  String _selectedSexoDenunciante = 'Masculino';
  String _selectedReligiaoDenunciante = 'Católica';
  String _selectedCorRacaDenunciante = 'Sem declaração';

  String _selectedSexoAgressor = 'Masculino';
  String _selectedReligiaoAgressor = 'Católica'; // Valor padrão
  String _selectedCorRacaAgressor = 'Sem declaração';

  String _selectedSexoVitima = 'Masculino';
  String _selectedReligiaoVitima = 'Católica';
  String _selectedCorRacaVitima = 'Sem declaração';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Denúncia Identificado'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Do Denunciante:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nomeDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Nome Completo do Denunciante',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dataNascimentoController,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento do Denunciante',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _enderecoDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Endereço do Denunciante',
                  ),
                ),
                TextFormField(
                  controller: _bairroDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Bairro do Denunciante',
                  ),
                ),
                TextFormField(
                  controller: _estadoDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Estado do Denunciante',
                  ),
                ),
                TextFormField(
                  controller: _cidadeDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Cidade do Denunciante',
                  ),
                ),
                TextFormField(
                  controller: _emailDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'E-Mail do Denunciante',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu E-Mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefoneDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Telefone do Denunciante',
                  ),
                ),
                TextFormField(
                  controller: _celularDenuncianteController,
                  decoration: InputDecoration(
                    labelText: 'Celular do Denunciante',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu celular';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('Sexo do Denunciante:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sexoOptions.map((sexo) {
                    return Row(
                      children: [
                        Radio(
                          value: sexo,
                          groupValue: _selectedSexoDenunciante,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSexoDenunciante = newValue!;
                            });
                          },
                        ),
                        Text(sexo),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Religião do Denunciante:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _religiaoOptions.map((religiao) {
                    return Row(
                      children: [
                        Radio(
                          value: religiao,
                          groupValue: _selectedReligiaoDenunciante,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedReligiaoDenunciante = newValue!;
                            });
                          },
                        ),
                        Text(religiao),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Cor/Raça do Denunciante:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _corRacaOptions.map((corRaca) {
                    return Row(
                      children: [
                        Radio(
                          value: corRaca,
                          groupValue: _selectedCorRacaDenunciante,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCorRacaDenunciante = newValue!;
                            });
                          },
                        ),
                        Text(corRaca),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Do Agressor:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nomeAgressorController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Agressor',
                  ),
                ),
                TextFormField(
                  controller: _enderecoAgressorController,
                  decoration: InputDecoration(
                    labelText: 'Endereço do Agressor',
                  ),
                ),
                TextFormField(
                  controller: _bairroAgressorController,
                  decoration: InputDecoration(
                    labelText: 'Bairro do Agressor',
                  ),
                ),
                TextFormField(
                  controller: _cepAgressorController,
                  decoration: InputDecoration(
                    labelText: 'CEP do Agressor',
                  ),
                ),
                TextFormField(
                  controller: _estadoAgressorController,
                  decoration: InputDecoration(
                    labelText: 'Estado do Agressor',
                  ),
                ),
                TextFormField(
                  controller: _cidadeAgressorController,
                  decoration: InputDecoration(
                    labelText: 'Cidade do Agressor',
                  ),
                ),
                TextFormField(
                  controller: _idadeAgressorController,
                  decoration: InputDecoration(
                    labelText: 'Idade do Agressor',
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Sexo do Agressor:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sexoOptions.map((sexo) {
                    return Row(
                      children: [
                        Radio(
                          value: sexo,
                          groupValue: _selectedSexoAgressor,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSexoAgressor = newValue!;
                            });
                          },
                        ),
                        Text(sexo),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Religião do Agressor:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _religiaoOptions.map((religiao) {
                    return Row(
                      children: [
                        Radio(
                          value: religiao,
                          groupValue: _selectedReligiaoAgressor,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedReligiaoAgressor = newValue!;
                            });
                          },
                        ),
                        Text(religiao),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Cor/Raça do Agressor:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _corRacaOptions.map((corRaca) {
                    return Row(
                      children: [
                        Radio(
                          value: corRaca,
                          groupValue: _selectedCorRacaAgressor,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCorRacaAgressor = newValue!;
                            });
                          },
                        ),
                        Text(corRaca),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Da Vítima:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nomeVitimaController,
                  decoration: InputDecoration(
                    labelText: 'Nome da Vítima',
                  ),
                ),
                TextFormField(
                  controller: _enderecoVitimaController,
                  decoration: InputDecoration(
                    labelText: 'Endereço da Vítima',
                  ),
                ),
                TextFormField(
                  controller: _bairroVitimaController,
                  decoration: InputDecoration(
                    labelText: 'Bairro da Vítima',
                  ),
                ),
                TextFormField(
                  controller: _cepVitimaController,
                  decoration: InputDecoration(
                    labelText: 'CEP da Vítima',
                  ),
                ),
                TextFormField(
                  controller: _estadoVitimaController,
                  decoration: InputDecoration(
                    labelText: 'Estado da Vítima',
                  ),
                ),
                TextFormField(
                  controller: _cidadeVitimaController,
                  decoration: InputDecoration(
                    labelText: 'Cidade da Vítima',
                  ),
                ),
                TextFormField(
                  controller: _idadeVitimaController,
                  decoration: InputDecoration(
                    labelText: 'Idade da Vítima',
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Sexo da Vítima:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sexoOptions.map((sexo) {
                    return Row(
                      children: [
                        Radio(
                          value: sexo,
                          groupValue: _selectedSexoVitima,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSexoVitima = newValue!;
                            });
                          },
                        ),
                        Text(sexo),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Religião da Vítima:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _religiaoOptions.map((religiao) {
                    return Row(
                      children: [
                        Radio(
                          value: religiao,
                          groupValue: _selectedReligiaoVitima,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedReligiaoVitima = newValue!;
                            });
                          },
                        ),
                        Text(religiao),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Cor/Raça da Vítima:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _corRacaOptions.map((corRaca) {
                    return Row(
                      children: [
                        Radio(
                          value: corRaca,
                          groupValue: _selectedCorRacaVitima,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCorRacaVitima = newValue!;
                            });
                          },
                        ),
                        Text(corRaca),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),

                Text('Do Tipo da Agressão:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _tipoAgressaoOptions.map((tipo) {
                    return Row(
                      children: [
                        Radio(
                          value: tipo,
                          groupValue: _selectedTipoAgressao,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedTipoAgressao = newValue.toString();
                            });
                          },
                        ),
                        Text(tipo),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Data e Hora da Ocorrência:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _dataHoraOcorrenciaController,
                  decoration: InputDecoration(
                    labelText: 'Data e Hora da Ocorrência',
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Local da Ocorrência:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _localOcorrenciaController,
                  decoration: InputDecoration(
                    labelText: 'Local da Ocorrência',
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Descrição Do Fato:',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _descricaoFatoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição Do Fato',
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Construct the email content using the form data
                      final emailContent = {
                        'personalizations': [
                          {
                            'to': [{'email': 'denunciappitape@gmail.com'}], // Replace with the recipient's email
                            'subject': 'Your subject here',
                          },
                        ],
                        'from': {'email': 'denunciappitape@gmail.com'}, // Use the sender's email
                        'content': [
                          {
                            'type': 'text/plain',
                            'value': 'Tipo da Agressão: $_selectedTipoAgressao\n'
                                'Nome do Denunciante: ${_nomeDenuncianteController.text}\n'
                                'Data de Nascimento: ${_dataNascimentoController.text}\n'
                                'Endereço do Denunciante: ${_enderecoDenuncianteController.text}\n'
                                'Bairro do Denunciante: ${_bairroDenuncianteController.text}\n'
                                'Estado do Denunciante: ${_estadoDenuncianteController.text}\n'
                                'Cidade do Denunciante: ${_cidadeDenuncianteController.text}\n'
                                'Email do Denunciante: ${_emailDenuncianteController.text}\n'
                                'Telefone do Denunciante: ${_telefoneDenuncianteController.text}\n'
                                'Celular do Denunciante: ${_celularDenuncianteController.text}\n'
                                'Cor/Raça do Denunciante: $_selectedCorRacaDenunciante\n'
                                'Nome do Agressor: ${_nomeAgressorController.text}\n'
                                'Endereço do Agressor: ${_enderecoAgressorController.text}\n'
                                'Bairro do Agressor: ${_bairroAgressorController.text}\n'
                                'CEP do Agressor: ${_cepAgressorController.text}\n'
                                'Estado do Agressor: ${_estadoAgressorController.text}\n'
                                'Cidade do Agressor: ${_cidadeAgressorController.text}\n'
                                'Idade do Agressor: ${_idadeAgressorController.text}\n'
                                'Sexo do Agressor: $_selectedSexoAgressor\n'
                                'Religião do Agressor: $_selectedReligiaoAgressor\n'
                                'Cor/Raça do Agressor: $_selectedCorRacaAgressor\n'
                                'Nome da Vítima: ${_nomeVitimaController.text}\n'
                                'Endereço da Vítima: ${_enderecoVitimaController.text}\n'
                                'Bairro da Vítima: ${_bairroVitimaController.text}\n'
                                'CEP da Vítima: ${_cepVitimaController.text}\n'
                                'Estado da Vítima: ${_estadoVitimaController.text}\n'
                                'Cidade da Vítima: ${_cidadeVitimaController.text}\n'
                                'Idade da Vítima: ${_idadeVitimaController.text}\n'
                                'Sexo da Vítima: $_selectedSexoVitima\n'
                                'Religião da Vítima: $_selectedReligiaoVitima\n'
                                'Cor/Raça da Vítima: $_selectedCorRacaVitima\n'
                                'Data e Hora da Ocorrência: ${_dataHoraOcorrenciaController.text}\n'
                                'Local da Ocorrência: ${_localOcorrenciaController.text}\n'
                                'Descrição do Fato: ${_descricaoFatoController.text}\n',
                          },
                        ],
                      };

                      try {
                        final response = await http.post(
                          Uri.parse('https://api.sendgrid.com/v3/mail/send'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer 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',
                            'Access-Control-Allow-Origin': '*'// Replace with your SendGrid API key
                          },
                          body: json.encode(emailContent),
                        );

                        if (response.statusCode == 202) {
                          // Email sent successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Denúncia enviada com sucesso!'),
                            ),
                          );

                          final formDataJson = json.encode(emailContent);
                          final db = FormSubmissionDatabase();
                          await db.insertFormSubmission(formDataJson);

                        } else {
                          // Email sending failed, log the response for debugging
                          print('Failed to send email. Status code: ${response.statusCode}');
                          print('Response body: ${response.body}');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao enviar a denúncia: ${response.statusCode}'),
                            ),
                          );
                        }
                      } catch (e) {
                        // Handle network-related errors
                        print('Network error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro de rede: $e'),
                          ),
                        );
                      }


                    }
                  },
                  child: Text('Submit'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: MyCustomFormIdentificado(
          selectedDenuncia: 'Denúncia',
          selectedAnonimato: 'Anonimato',
        ),
      ),
    ),
  );
}
