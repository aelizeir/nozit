import 'dart:convert';
import 'package:nozit/homepage.dart';
import 'package:nozit/model/api_response.dart';
import 'package:nozit/model/user.dart';
import 'package:nozit/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nozit/pages/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/Auth_services.dart';
import '../Services/global.dart';
import '../rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      //ApiResponse apiResponse = ApiResponse();
      ApiResponse apiResponse = await AuthServices.login(_email, _password);
      //Map responseMap = jsonDecode(response.body);
      if (apiResponse.error == null) {
        pageRoute(apiResponse.data as User);
      }
      else {
        // ignore: use_build_context_synchronously
        //errorSnackBar(context, responseMap.values.first);
      }
      //pageRoute(responseMap['token']);
      //print(response.body);
      //print(response.statusCode);
    }
    else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  void pageRoute(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('user_id', user.id ?? 0);
    String token = await getToken();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ListPage(),
        )
    );
    print(token);
  }

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 1),
    ));
  }

  void registerRoute() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: SizedBox(
      //     height: double.infinity,
      //     width: double.infinity,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           Text(
      //               "NotesIt",
      //             style: TextStyle(
      //               color: Theme.of(context).primaryColor,
      //               fontSize: 40,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           const Text(
      //               "Notes made easy",
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           Container(
      //             child: TextFormField(
      //
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              RoundedButton(
                btnText: 'LOG IN',
                onBtnPressed: () => loginPressed(),
              )
            ],
          ),
        )
    );
  }
}