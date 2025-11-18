import 'package:flutter/material.dart';
import 'package:lat1/model/elektronik.dart';
import 'package:lat1/screen/detail.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {

    var elektronik = Elektronik();
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Utama'),
        centerTitle: true ,
      ),
      body: ListView.builder(
        itemCount: elektronik.merk.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: InkWell(
              hoverColor: Colors.blueAccent,
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  //disini kita masuk ke halaman tujuan 
                  MaterialPageRoute(
                    builder: (context) => HalamanDetail(
                      judul: elektronik.merk[index], tipe: elektronik.tipe[index],
                      )
                    )
                  ); 

              },
              child: ListTile(
                leading: Icon(Icons.electrical_services),
                title: Text(elektronik.merk[index]),
                subtitle: Text(elektronik.tipe[index]),
              ),
            ),


          );
        },
        ),
    );
  }
}