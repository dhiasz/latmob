import 'package:flutter/material.dart';
import 'package:p8/model/provider.dart';
import 'package:provider/provider.dart';

void main() async{
  // menginisialisasi binding antara Flutter framework dan engine
    WidgetsFlutterBinding.ensureInitialized();
    runApp(
      ChangeNotifierProvider(
        create: (context) => TemaProvider(),
        child: MyApp(),
        )
    );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode gelap terang'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Mode Gelap'),
            Switch(
              value: EditableText.debugDeterministicCursor, 
              onChanged: (value) {
                
              }, 
              )
          ],
        ),
      ),
    );
  }
}
