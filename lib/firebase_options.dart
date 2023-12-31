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
    apiKey: 'AIzaSyAWkY_1MJPpxMhAuyMKMGP0IsrKxZXtoOk',
    appId: '1:367636450484:web:09da670650786e2fcb1be1',
    messagingSenderId: '367636450484',
    projectId: 'flutter-sns-udemy02',
    authDomain: 'flutter-sns-udemy02.firebaseapp.com',
    storageBucket: 'flutter-sns-udemy02.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6TVlblu-qf9XLYIRaySa9MElCI7PAUi4',
    appId: '1:367636450484:android:977d72d3b5896164cb1be1',
    messagingSenderId: '367636450484',
    projectId: 'flutter-sns-udemy02',
    storageBucket: 'flutter-sns-udemy02.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfOw1w1szxRVliSNQeYaOrxvRUXZ9aj6o',
    appId: '1:367636450484:ios:85166f9e37fecea7cb1be1',
    messagingSenderId: '367636450484',
    projectId: 'flutter-sns-udemy02',
    storageBucket: 'flutter-sns-udemy02.appspot.com',
    iosBundleId: 'com.example.flutterSnsU02',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAfOw1w1szxRVliSNQeYaOrxvRUXZ9aj6o',
    appId: '1:367636450484:ios:d1a4d61ccdc46102cb1be1',
    messagingSenderId: '367636450484',
    projectId: 'flutter-sns-udemy02',
    storageBucket: 'flutter-sns-udemy02.appspot.com',
    iosBundleId: 'com.example.flutterSnsU02.RunnerTests',
  );
}
