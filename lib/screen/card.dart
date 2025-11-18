import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class DigitalBusinessCardApp extends StatelessWidget {
  const DigitalBusinessCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Kartu Nama Digital',
      home: BusinessCardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BusinessCardScreen extends StatelessWidget {
  const BusinessCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 70.0,
                backgroundImage: NetworkImage(
                  'https://placehold.co/300x300/EFEFEF/grey?text=Foto',
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Kabayan',
                style: GoogleFonts.pacifico(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'MAHASISWA & PROGRAMMER',
                style: GoogleFonts.sourceSans3(
                  fontSize: 20.0,
                  color: Colors.tealAccent.shade100,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 200.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    '+62 812 3456 7890',
                    style: TextStyle(
                      color: Colors.teal[900],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    'kabayan@email.com',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.teal[900],
                    ),
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
