// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCMHg9tC3oCNzffV5tAXLLA-toaEhWd-xM',
    appId: '1:492027981726:web:75b3bbc3619723599d708f',
    messagingSenderId: '492027981726',
    projectId: 'publicaciones-a60d5',
    authDomain: 'publicaciones-a60d5.firebaseapp.com',
    databaseURL: 'https://publicaciones-a60d5-default-rtdb.firebaseio.com',
    storageBucket: 'publicaciones-a60d5.appspot.com',
    measurementId: 'G-HJDBNDQW8F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-lv0ppCV-NaNIXQ-w-vFitkup9NTyr4I',
    appId: '1:492027981726:android:af966b00c8487a809d708f',
    messagingSenderId: '492027981726',
    projectId: 'publicaciones-a60d5',
    databaseURL: 'https://publicaciones-a60d5-default-rtdb.firebaseio.com',
    storageBucket: 'publicaciones-a60d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDT70ETc7aUG5qnvMlUPSK9CNhAh0mSTPE',
    appId: '1:492027981726:ios:989ff90c9f2236329d708f',
    messagingSenderId: '492027981726',
    projectId: 'publicaciones-a60d5',
    databaseURL: 'https://publicaciones-a60d5-default-rtdb.firebaseio.com',
    storageBucket: 'publicaciones-a60d5.appspot.com',
    iosClientId: '492027981726-1lcqgtvhtn65s9o7bseobq3g4sbrgfsf.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackernews',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDT70ETc7aUG5qnvMlUPSK9CNhAh0mSTPE',
    appId: '1:492027981726:ios:989ff90c9f2236329d708f',
    messagingSenderId: '492027981726',
    projectId: 'publicaciones-a60d5',
    databaseURL: 'https://publicaciones-a60d5-default-rtdb.firebaseio.com',
    storageBucket: 'publicaciones-a60d5.appspot.com',
    iosClientId: '492027981726-1lcqgtvhtn65s9o7bseobq3g4sbrgfsf.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackernews',
  );
}
