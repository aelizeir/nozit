import 'package:nozit/my_drawer_header.dart';
import 'package:nozit/page/todo_page.dart';
import 'package:nozit/pages/LoginPage.dart';
import 'package:nozit/profile.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.notes;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.profile) {
      container = ProfilePage();
    } else if (currentPage == DrawerSections.notes) {
      container = TodoPage();
    } else if (currentPage == DrawerSections.logout) {
      // container = LogOutPage(email: );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // title: const Text(
        //   'WorkPlace',
        //   style: TextStyle(
        //       color: Colors.black),
        // ),
        // iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                myDrawerList(),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Profile", Icons.account_circle, currentPage == DrawerSections.profile ? true : false),
          menuItem(2, "Notes", Icons.notes, currentPage == DrawerSections.notes ? true : false),
          const Divider(),
          menuItem(3, "Log Out", Icons.logout_sharp, currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.blueGrey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.profile;
            } else if (id == 2) {
              currentPage = DrawerSections.notes;
            } else if (id == 3) {
              IconButton(onPressed: (){
                logoutNow().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen())));
              }, icon: const Icon(Icons.logout));
            }});
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white70,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  profile,
  notes,
  logout
}
