import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const baseURL = 'http://192.168.254.143:8000';
const loginURL = '$baseURL/api/auth/login';
const registerURL = '$baseURL/api/auth/register';
const logoutURL = '$baseURL/api/auth/logout';


const postNotesURL = '$baseURL/api/notes';
const getNotesURL = '$baseURL/api/notes';
const putNotesURL = '$baseURL/api/notes/{id}';
const deleteNotesURL = '$baseURL/api/notes/{id}';


const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}