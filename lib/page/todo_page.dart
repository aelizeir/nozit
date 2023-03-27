import 'dart:convert';

import 'package:nozit/Services/global.dart';
import 'package:nozit/homepage.dart';
import 'package:flutter/material.dart';
import 'package:nozit/model/user.dart';
import 'package:nozit/notes/notes.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nozit/page/add_edit_todo_page.dart';
import 'package:nozit/page/todo_detail_page.dart';
import 'package:nozit/widget/todo_card_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List allNotes = <dynamic>[];
  int user_id = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Future<void> refreshNotes() async {
    setState(() => isLoading = true);

    String token = await getToken();
    user_id = await getUserId();
    var headers = {
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    };
    final uri = Uri.parse('$getNotesURL/$user_id');
    final response = await http.get(uri,headers: headers);
    var notes = jsonDecode(response.body) as Map;
    var tentative = notes['notes'] as List;
    print(response.body);
    setState(() {
      allNotes = tentative;
    });
      setState(() => isLoading = false);
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : allNotes.isEmpty
          ? const Text(
        'No Notes',
        style: TextStyle(color: Colors.grey, fontSize: 24),
      )
          : buildTodo(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blueGrey,
      child: const Icon(Icons.edit_note_sharp, ),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditTodoPage()),
        );

        refreshNotes();
      },
    ),
  );

  Widget buildTodo() => ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: allNotes.length,
      itemBuilder: (context, index) {
        final todos = allNotes[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TodoDetailPage(todo: todos.id!),
            ));

            refreshNotes();
          },
          child: TodoCardWidget(notes: todos, index: index),
        );
      }
  );

  //     StaggeredGridView.countBuilder(
  //   padding: const EdgeInsets.all(8),
  //   itemCount: todo.length,
  //   staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
  //   crossAxisCount: 4,
  //   mainAxisSpacing: 4,
  //   crossAxisSpacing: 4,
  //   itemBuilder: (context, index) {
  //     final todos = todo[index];
  //
  //     return GestureDetector(
  //       onTap: () async {
  //         await Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => TodoDetailPage(todoId: todos.id!),
  //         ));
  //
  //         refreshNotes();
  //       },
  //       child: TodoCardWidget(todo: todos, index: index),
  //     );
  //   },
  // );
}