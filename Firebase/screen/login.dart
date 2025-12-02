// library untuk login & register menggunakan Firebase Authentication.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class TampilanLogin extends StatefulWidget {
  const TampilanLogin({super.key});

  @override
  State<TampilanLogin> createState() => _TampilanLoginState();
}

class _TampilanLoginState extends State<TampilanLogin> {
      final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    // Mengambil instance FirebaseAuth untuk:
    // login (signInWithEmailAndPassword)
    // register (createUserWithEmailAndPassword)
    // cek user aktif
    // logout
    // objek dari class firebase
    final _auth = FirebaseAuth.instance;

Future<void> _login() async {
    try {
       await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
       );
    } on FirebaseAuthException catch (e) {
      // menampilkan pesan error (misal password salah).
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Login Gagal')));
     }
  }


  Future<void> _register() async{
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text,
        );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message?? 'Register gagal')));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login & Register'),
      ),
      body:Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(label: Text('Email')),),
            // obscureText: true → password disembunyikan (•••••••).
            TextField(controller: _passwordController, decoration: InputDecoration(label: Text('Paswword')), obscureText: true,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _login, 
                  child: Text('Login')
                  ),
                  ElevatedButton(
                  onPressed: _register, 
                  child: Text('Register')
                  ),
              ],
            )
          ],
        ),
        )
    );
  }
}


//Ini Bagian Rapih



class TampilanLogin_ extends StatefulWidget {
  const TampilanLogin_({super.key});

  @override
  State<TampilanLogin_> createState() => _TampilanLogin_State();
}

class _TampilanLogin_State extends State<TampilanLogin_> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Login gagal')));
    }
  }

  Future<void> _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Register gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo atau icon
              const Icon(
                Icons.person_pin,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),

              const Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Card form
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Email
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextButton(
                        onPressed: _register,
                        child: const Text("Create an Account"),
                      ),
                    ],
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
