import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'Utils.dart';
import 'home.dart';
import 'dart:io';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  NewPostState createState() => NewPostState();
}

class NewPostState extends State<NewPost> {
  File? file;
  bool isUploadFile = false;
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isUploadFile ? const Text("Select and Image") : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getFile,
        tooltip: "Add image",
        child: const Icon(Icons.add_a_photo),
        backgroundColor: Colors.deepPurple.shade200,
      ),
    );
  }

  Future getFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    setState(() {
      file = File(result.files.single.path!);
      print(file);
      print(file!.path);
      isUploadFile = true;
    });
  }

  Widget enableUpload() => SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(file!, width: 600.0, height: 300.0),
            const SizedBox(height: 15),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              validator: (value) => value == null ? 'Description is required' : null,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: uploadStatusImage, 
              child: const Text("Add a new post")
            )
          ],
        )
      ),
    ),
  );

  void uploadStatusImage() async {
    if(validateForm()) {
      //Genero el path de la imagen
      final fileName = basename(file!.path);
      final destination = 'files/$fileName';

      //Obtengo la url de la imagen
      UploadTask? uploadTask;
      try{
        Reference ref = FirebaseStorage.instance.ref(destination);
        uploadTask = ref.putFile(file!);
      } on FirebaseException catch(e) {
        Utils.showSnackBar(e.message);
        return;
      }

      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();

      //Guardo al referencia de firebase realtime database
      saveToDatabase(url);

      //Regreso al Home
      Navigator.push(this.context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  void saveToDatabase(String url) async {
    //Guardar una publicacion (imagen, descripcion, fecha, tiempo)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    var postData = {
      'user': user.uid,
      'image': url,
      'description': descriptionController.text,
      'date': date,
      'time': time
    };

    final newPostKey = ref.child('posts').push().key;
    final Map<String, Map> updates = {};
    updates['/posts/$newPostKey'] = postData;
    updates['/user-posts/${user.uid}/$newPostKey'] = postData;
    ref.update(updates);
  }

  bool validateForm() {
    final form = formKey.currentState!;
    bool validate = form.validate();
    if(validate) {
      form.save();
    }
    return validate;
  }

}