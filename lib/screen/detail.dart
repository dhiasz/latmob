import 'package:flutter/material.dart';

class HalamanDetail
 extends StatelessWidget {
  final String judul;
  final String tipe;
  
  const HalamanDetail
  ({super.key , required this.judul, required this.tipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(judul),
            Text(tipe)
          ],
        ),
      ),
    );
  }
}