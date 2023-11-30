import 'package:flutter/material.dart';
import 'dbHelper.dart';

class FormSubmissionHistoryScreen extends StatefulWidget {
  @override
  _FormSubmissionHistoryScreenState createState() =>
      _FormSubmissionHistoryScreenState();
}

class _FormSubmissionHistoryScreenState extends State<FormSubmissionHistoryScreen> {
  final FormSubmissionDatabase _database = FormSubmissionDatabase();

  List<String> _formSubmissions = [];

  @override
  void initState() {
    super.initState();
    _loadFormSubmissions();
  }

  Future<void> _loadFormSubmissions() async {
    final submissions = await _database.getFormSubmissions();
    setState(() {
      _formSubmissions = submissions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de fórmulários preenchidos'),
      ),
      body: _formSubmissions.isEmpty
          ? Center(
        child: Text('Nenhum histórico registrado.'),
      )
          : ListView.builder(
        itemCount: _formSubmissions.length,
        itemBuilder: (context, index) {
          final submission = _formSubmissions[index];
          return ListTile(
            title: Text('Submission #$index'),
            subtitle: Text(submission),
          );
        },
      ),
    );
  }
}
