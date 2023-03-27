import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nozit/widget/todo_form_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:nozit/model/user.dart';
import '../Services/global.dart';

class AddEditTodoPage extends StatefulWidget {

  final Map? todo;

  const AddEditTodoPage({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  _AddEditTodoPageState createState() => _AddEditTodoPageState();
}

class _AddEditTodoPageState extends State<AddEditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if(todo != null) {
      isImportant = widget.todo?['isImportant'] ?? false;
      title = widget.todo?["title"] ?? '';
      description = widget.todo?['description'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: TodoFormWidget(
        isImportant: isImportant,
        title: title,
        description: description,
        onChangedImportant: (isImportant) =>
            setState(() => this.isImportant = isImportant),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateTodo,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateTodo() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.todo != null;

      if (isUpdating) {
        await updateTodo();
      } else {
        await addTodo();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateTodo() async {
    String token = await getToken();
    final note = widget.todo;
    if (note == null) {
      print('You cannot do updates without todo data');
      return;
    }
    final id = note['_id'];
    final body = {
      "isImportant": isImportant,
      "title": title,
      "description": description,
    };

    var headers = {
      "Content-Type" : "application/json",
      'Authorization':'Bearer $token'
    };
    final uri = Uri.parse(putNotesURL);
    final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: headers
    );
    print(token);
    print(response.statusCode);
  }

  Future addTodo() async {
    String token = await getToken();
    final body = {
      'isImportant': true,
      'title': title,
      'description': description,
      'time': DateTime.now(),
    };

    var headers = {
      "Content-Type" : "application/json",
      'Authorization':'Bearer $token'
    };
    final uri = Uri.parse(postNotesURL);
    final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: headers
    );
    print(token);
    print(response.statusCode);
  }

}