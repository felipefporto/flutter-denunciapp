import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dbHelper.dart';

class MyCustomForm extends StatefulWidget {
  final String selectedDenuncia;
  final String selectedAnonimato;

  MyCustomForm({
    required this.selectedDenuncia,
    required this.selectedAnonimato,
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
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
    'Católica', 'Judaica', 'Evangélica', 'Espírita', 'Budista',
    'Hindu', 'Islâmica', 'Candomblé', 'Umbanda', 'Jurema Sagrada',
    'Ateu', 'Outra', 'Sem Religião'
  ];

  String _selectedSexoAgressor = 'Masculino';
  String _selectedReligiaoAgressor = 'Católica';

  String _selectedSexoVitima = 'Masculino';
  String _selectedReligiaoVitima = 'Católica';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _celularController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Denúncia de ${widget.selectedDenuncia}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Do Denunciante:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your e-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _celularController,
                  decoration: InputDecoration(
                    labelText: 'Celular',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your celular number';
                    }
                    return null;
                  },
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Sexo do Agressor:'),
                    Column(
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Religião do Agressor:'),
                    Column(
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
                  ],
                ),
                // Adicione outros campos do agressor conforme necessário...
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Sexo da Vítima:'),
                    Column(
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Religião da Vítima:'),
                    Column(
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
                  ],
                ),
                // Adicione outros campos da vítima conforme necessário...
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
                // Adicione outros campos como Data e Hora da Ocorrência, Local da Ocorrência, Descrição Do Fato, etc...
                SizedBox(height: 16.0),
                Text('Data e Hora da Ocorrência:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _dataHoraOcorrenciaController,
                  decoration: InputDecoration(
                    labelText: 'Data e Hora da Ocorrência',
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Local da Ocorrência:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _localOcorrenciaController,
                  decoration: InputDecoration(
                    labelText: 'Local da Ocorrência',
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Descrição Do Fato:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _descricaoFatoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição Do Fato',
                  ),
                  maxLines: 3, // Se desejar permitir várias linhas de texto
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
                            'value':

                                'Email do Denunciante: ${_emailController.text}\n'
                                'Endereço do Denunciante: ${_celularController.text}\n'
                                'Nome do Agressor ${_nomeAgressorController.text}\n'
                                'Endereço do Agressor ${_enderecoAgressorController.text}\n'
                                'Bairro do Agressor ${_bairroAgressorController.text}\n'
                                'CEP do Agressor ${_cepAgressorController.text}\n'
                                'Estado do Agressor ${_estadoAgressorController.text}\n'
                                'Cidade do Agressor ${_cidadeAgressorController.text}\n'
                                'Idade do Agressor ${_idadeAgressorController.text}\n'
                                'Sexo do Agressor $_selectedSexoAgressor\n'
                                'Religião do Agressor $_selectedReligiaoAgressor\n'

                                'Nome da Vítima  ${_nomeVitimaController.text}\n'
                                'Endereço da Vítima  ${_enderecoVitimaController.text}\n'
                                'Bairro da Vítima  ${_bairroVitimaController.text}\n'
                                'CEP da Vítima  ${_cepVitimaController.text}\n'
                                'Estado da Vítima  ${_estadoVitimaController.text}\n'
                                'Cidade da Vítima  ${_cidadeVitimaController.text}\n'
                                'Idade da Vítima  ${_idadeVitimaController.text}\n'
                                'Sexo da Vítima $_selectedSexoVitima\n'
                                'Religião da Vítima $_selectedReligiaoVitima\n'
                                'Tipo da Agressão $_selectedTipoAgressao\n'
                                'CEP da Vítima  ${_cepVitimaController.text}\n'
                                'Data e hora da Ocorrência  ${_dataHoraOcorrenciaController.text}\n'
                                'Local da Ocorrência  ${_localOcorrenciaController.text}\n'
                                'Descrição do Fato  ${_descricaoFatoController.text}\n'
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
