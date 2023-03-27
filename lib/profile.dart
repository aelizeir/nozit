import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<String> titles = <String>['Name', 'Relationship', 'Occupation', 'Birthday', 'Age'];
  final double coverHeight = 380;
  final double profileHeight = 134;

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 1;
    final bottom = profileHeight / 1;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile', style: TextStyle(
      //       fontSize: 24,
      //       color: Colors.black54,
      //       fontWeight: FontWeight.bold
      //   ),
      //   ),
      // ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: bottom),
                color: Colors.orangeAccent,
                child: Image.asset("assets/cover-photo.jpg",
                    width: double.infinity,
                    height: coverHeight,
                    fit: BoxFit.cover),
              ),
              Container(
                  margin: EdgeInsets.only(top: top),
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFCBA4),
                      shape: BoxShape.circle,
                      // boxShadow: [
                      //   BoxShadow(
                      //       blurRadius: 10,
                      //       color: Color(0xFFFFCBA4),
                      //       spreadRadius: 5
                      //   )
                      // ]
                  ),
                  child: CircleAvatar(
                    radius: profileHeight,
                    backgroundColor: const Color(0xFFFAF9F6),
                    child: const CircleAvatar(
                      radius: 125,
                      backgroundImage: AssetImage("assets/profile.JPG"),
                    ),
                  )
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: ListTile(
              leading: const Icon(Icons.person),
              minVerticalPadding: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textColor: Colors.white60,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 4,
                    child: Text('Name'),
                  ),
                  Expanded(
                    flex: 9,
                    child: Text(': Ali Gutierrez'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          ListTile(
            leading: const Icon(Icons.work),
            minVerticalPadding: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textColor: Colors.white60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 4,
                  child: Text('Work'),
                ),
                Expanded(
                  flex: 9,
                  child: Text(': Student'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          ListTile(
            leading: const Icon(Icons.cake),
            minVerticalPadding: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textColor: Colors.white60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 4,
                  child: Text('Birthday'),
                ),
                Expanded(
                  flex: 9,
                  child: Text(': August 29, 2001'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          ListTile(
            leading: const Icon(Icons.yard),
            minVerticalPadding: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textColor: Colors.white60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 4,
                  child: Text('Age'),
                ),
                Expanded(
                  flex: 9,
                  child: Text(': 21 years old'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
