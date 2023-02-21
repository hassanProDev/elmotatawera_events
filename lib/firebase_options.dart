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
    apiKey: 'AIzaSyBX93HOuC_wfriCu7zl3d8przryGWfb52I',
    appId: '1:686144051056:web:53e0acf9bba8b1f7fba1b5',
    messagingSenderId: '686144051056',
    projectId: 'events-app-446c5',
    authDomain: 'events-app-446c5.firebaseapp.com',
    storageBucket: 'events-app-446c5.appspot.com',
    measurementId: 'G-RJPCPRWQDV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3WcvyNBVqCAfm0cvC4sSCWwC2fmoU_9U',
    appId: '1:686144051056:android:68cd23888541cd6cfba1b5',
    messagingSenderId: '686144051056',
    projectId: 'events-app-446c5',
    storageBucket: 'events-app-446c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXuZGah9COesMg3rdENb3xXON94FALMr0',
    appId: '1:686144051056:ios:657bf2f4b5f3d718fba1b5',
    messagingSenderId: '686144051056',
    projectId: 'events-app-446c5',
    storageBucket: 'events-app-446c5.appspot.com',
    iosClientId: '686144051056-d1f3jcemkvr8udmsdnrjbcrknn6ark65.apps.googleusercontent.com',
    iosBundleId: 'com.example.elmotataweraEvents',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXuZGah9COesMg3rdENb3xXON94FALMr0',
    appId: '1:686144051056:ios:657bf2f4b5f3d718fba1b5',
    messagingSenderId: '686144051056',
    projectId: 'events-app-446c5',
    storageBucket: 'events-app-446c5.appspot.com',
    iosClientId: '686144051056-d1f3jcemkvr8udmsdnrjbcrknn6ark65.apps.googleusercontent.com',
    iosBundleId: 'com.example.elmotataweraEvents',
  );
}
