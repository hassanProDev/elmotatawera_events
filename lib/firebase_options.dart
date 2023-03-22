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
    apiKey: 'AIzaSyDaXb0iwcvhmhITB-FjBGz4gbICijyXKQI',
    appId: '1:888019477779:web:3249bf41cb56a1b835e6e6',
    messagingSenderId: '888019477779',
    projectId: 'event-app-4609e',
    authDomain: 'event-app-4609e.firebaseapp.com',
    storageBucket: 'event-app-4609e.appspot.com',
    measurementId: 'G-PCGX3JHGFC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRze1iO5KXg1axhvwT9RK4llviOaTMhxw',
    appId: '1:888019477779:android:edcada4ad911b2e035e6e6',
    messagingSenderId: '888019477779',
    projectId: 'event-app-4609e',
    storageBucket: 'event-app-4609e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA79XpeRn_vCM37U0jBxhSWgsx3_VXbFC8',
    appId: '1:888019477779:ios:ceee00cc81b86d2f35e6e6',
    messagingSenderId: '888019477779',
    projectId: 'event-app-4609e',
    storageBucket: 'event-app-4609e.appspot.com',
    iosClientId: '888019477779-o5foh8rq3sca2gqqa3l7qabkktn8suv1.apps.googleusercontent.com',
    iosBundleId: 'com.example.elmotataweraEvents',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA79XpeRn_vCM37U0jBxhSWgsx3_VXbFC8',
    appId: '1:888019477779:ios:ceee00cc81b86d2f35e6e6',
    messagingSenderId: '888019477779',
    projectId: 'event-app-4609e',
    storageBucket: 'event-app-4609e.appspot.com',
    iosClientId: '888019477779-o5foh8rq3sca2gqqa3l7qabkktn8suv1.apps.googleusercontent.com',
    iosBundleId: 'com.example.elmotataweraEvents',
  );
}
