import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nozit/Services/global.dart';
import 'package:nozit/model/user.dart';

class AddTodo extends StatefulWidget {
  final Map? todo;
  const AddTodo({
    this.todo,
    Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController userIdController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if(todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  Future<void> updateData() async {
    String token = await getToken();
    final todo = widget.todo;
    if (todo == null) {
      print('You cannot do updates without todo data');
      return;
    }
    final id = todo['_id'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "isImportant": true,
      "title": title,
      "description": description,
      "time": DateTime.now(),
    };

    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-type': 'application/json',
      },
    );

    print(token);
    print(response.statusCode);
  }

  Future<void> submitData() async {
    String token = await getToken();
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "isImportant": true,
      "title": title,
      "description": description,
      "time": DateTime.now(),

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // TextField(
          //   controller: userIdController,
          //   decoration: const InputDecoration(hintText: 'User ID'),
          // ),
          // const SizedBox(height: 20),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    isEdit ? 'Update' : 'Submit'),
              )),
        ],
      ),
    );
  }
}