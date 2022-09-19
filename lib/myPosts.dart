import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'post.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  MyPostsState createState() => MyPostsState();
}

class MyPostsState extends State<MyPosts> {
  List<Post> postList = [];
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('user-posts/${user.uid}');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map;
      postList.clear();
      data.forEach((key, value) {
        postList.add(Post(
          value['image'].toString(),
          value['description'].toString(),
          value['date'].toString(),
          value['time'].toString()
        ));
      });
      setState(() {
        print('Length: ${postList.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) => Container(
    child: postList.isEmpty
    ? const Text("No posts available") 
    : ListView.builder(
        itemCount: postList.length,
          itemBuilder: (_, index) => Post.postsUI(
          postList[index].image,
          postList[index].description,
          postList[index].date,
          postList[index].time,
          context
        )
      ),
  );

}