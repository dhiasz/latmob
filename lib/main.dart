import 'package:firebase/screen/homepage.dart';
import 'package:firebase/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Memastikan Flutter sudah siap sebelum kamu menjalankan kode yang membutuhkan binding (seperti Firebase).
  WidgetsFlutterBinding.ensureInitialized();
  // Menghubungkan aplikasi Flutter ke Firebase.
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase Auth',
      home: AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder adalah widget di Flutter yang digunakan untuk memantau aliran data (stream) dan memperbarui tampilan otomatis setiap kali ada perubahan data.
    return StreamBuilder<User?>(
      // authStateChanges() adalah stream yang selalu memantau status login user, misalnya:
      // user login
      // user logout
      // user baru masuk
      // token expired
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const HomePage();
        }
        return const TampilanLogin();
      },
    );
  }
}



