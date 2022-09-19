import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myPosts.dart';
import 'posts.dart';
import 'newPost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key : key);

  @override
  HomeState createState() => HomeState(); 
}

class HomeState extends State<Home> {
  int index = 1;
  final screens = [
    const MyPosts(),
    const Posts(),
    const NewPost(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hackernews"),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(), 
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.deepPurple.shade50,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
          )
        ), 
        child: NavigationBar(
          height: 60,
          backgroundColor: const Color(0xFFf1f5fb),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.assignment), 
              selectedIcon: Icon(Icons.assignment_outlined),
              label: "My posts"
            ),
            NavigationDestination(
              icon: Icon(Icons.home), 
              selectedIcon: Icon(Icons.home_outlined),
              label: "Home"
            ),
            NavigationDestination(
              icon: Icon(Icons.post_add), 
              selectedIcon: Icon(Icons.photo_filter_sharp),
              label: "New post"
            )
          ],
        ),
      ),
    );
  }
}