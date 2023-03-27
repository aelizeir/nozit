import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nozit/Services/global.dart';
import 'package:nozit/page/add_edit_todo_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TodoDetailPage extends StatefulWidget {

  late final dynamic todo;

  TodoDetailPage({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _TodoDetailPageState createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {

  // late List todo = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future<void> refreshNote() async {
    setState(() => isLoading = true);
    final url = Uri.parse(baseURL + 'notes/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        widget.todo = result;
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            widget.todo['title'],
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(widget.todo['time']),
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            widget.todo['description'],
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined, color: Colors.grey),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditTodoPage(todo: widget.todo['_id']),
        ));
        refreshNote();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete, color: Colors.grey),
    onPressed: () async {
      await deleteById(widget.todo.id);
      Navigator.of(context).pop();
    },
  );

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deleteById(String id) async {
    final url = Uri.parse(baseURL + 'notes/{id}');
    var response = await http.delete(url);
    if(response.statusCode == 200) {
      final filtered = widget.todo.where((element) => element['_id'] != id).toList();
      setState(() {
        widget.todo = filtered;
      });
    }
    else {
      showErrorMessage('Unable to Delete');
    }
  }
}