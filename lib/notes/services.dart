import 'dart:convert';
import 'package:nozit/notes/notes.dart';
import 'package:nozit/Services/global.dart';
import 'package:http/http.dart' as http;


class Services {
  static const ROOT = 'http://192.168.1.4:8000/api/notes/';

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';



  static Future<List<Notes>> getNotes() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(Uri.parse(getNotesURL));
      print('getNotes Response: ${response.body}');
      print(response.statusCode);
      print(200 == response.statusCode);
      if (200 == response.statusCode) {
        List<Notes> list = parseResponse(response.body);
        print(list.length);
        return list;
      } else {
        return <Notes>[];
      }
    } catch (e) {
      return <Notes>[];
    }
  }

  static List<Notes> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    print(parsed);
    return parsed.map<Notes>((json) => Notes.fromJson(json)).toList();
  }


  static Future<bool> addNotes(bool isImportant, String title, String description, DateTime time) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_EMP_ACTION;
      map['isImportant'] = isImportant;
      map['title'] = title;
      map['description'] = description;
      map['time'] = time;
      final response = await http.post(Uri.parse(postNotesURL), body: map);
      print('addNotes Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> updateNotes(String id, bool isImportant, String title, String description, DateTime time) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_EMP_ACTION;
      map['id'] = id;
      map['isImportant'] = isImportant;
      map['title'] = title;
      map['description'] = description;
      map['time'] = time;
      final response = await http.put(Uri.parse(putNotesURL), body: map);
      print('updateNotes Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> deleteNotes(String empId) async {
    try {
      final response = await http.delete(Uri.parse(deleteNotesURL));
      print('deleteNotes Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }






}