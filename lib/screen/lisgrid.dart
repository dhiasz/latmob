import 'package:flutter/material.dart';
import 'package:lat1/model/wisata.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Wisata();
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('wisata Indonesia'),
          centerTitle: true,
          bottom: ,
        ),
      ) 
      );
  }
}