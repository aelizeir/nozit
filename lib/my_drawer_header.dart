import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {

  MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/profile.JPG'),
              )
            ),
          ),
          const Text(
            "Ali Gutierrez",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20),
          ),
          Text(
            "aligutierrez1016@gmail.com",
            style: TextStyle(
                color: Colors.grey[200],
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
