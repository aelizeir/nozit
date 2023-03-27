import 'dart:convert';

import 'package:nozit/Services/global.dart';
import 'package:nozit/model/user.dart';
import 'package:nozit/pages/add_todo.dart';
import 'package:nozit/pages/todo_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  bool isLoading = true;
  List items = <dynamic>[];
  int user_id = 0;
  // List todos = <dynamic>[];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  Future<void> navigateToAddTodo() async {
    final route = MaterialPageRoute(builder: (context) => const AddTodo(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditTodo(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
    else {
      showErrorMessage('Unable to Delete');
    }
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
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
      items = tentative;
    });
    setState(() {
      isLoading = false;
    });
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.checkmark_square_fill),
        title: const Text('Notes'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Item',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = items[index]['_id'] as String;
                  return Card(
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(items[index]['title']),
                      subtitle: Text(items[index]['description']),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if(value == 'edit'){
                            navigateToEditTodo(item);
                          } else if(value == 'delete'){
                            deleteById(id);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoDetails(notes: items[index]))
                        );
                      },
                    ),
                  );
                }),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTodo,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}