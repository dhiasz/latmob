

import 'package:flutter/foundation.dart';

class Produk {
  final String nama;
  Produk(this.nama);  
}

class Keranjang extends ChangeNotifier{

  //Data Produk
  final List<Produk> produks = [
    Produk('Laptop'),
    Produk('Mouse'),
    Produk('Keyboard'),
    Produk('Monitor'),
  ];

  //Keranjang
  final List<Produk> _item = [];

  List<Produk> get items => _item;
  int get totalItem => _item.length;

  void tambah(Produk produk){
    _item.add(produk);
    notifyListeners();
  }

}

import 'package:flutter/material.dart';
import 'package:p6/model/produk.dart';
import 'package:p6/screen/halamanproduk.dart';
import 'package:provider/provider.dart';




void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Keranjang(),
      child: MaterialApp(
        title: 'Demo Keranjang',
        debugShowCheckedModeBanner: false,
        home: Halamanproduk(),
      ),
    )
  );
}


import 'package:flutter/material.dart';
import 'package:p6/model/produk.dart';
import 'package:p6/screen/HalamanKeranjang.dart';
import 'package:provider/provider.dart';

class Halamanproduk extends StatelessWidget {
  const Halamanproduk({super.key});

  @override
  Widget build(BuildContext context) {
    final produks = context.watch<Keranjang>().produks;
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Poduk'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Consumer<Keranjang>(
              builder: (context, Keranjang, child) {
                return Badge(
                  label: Text('${Keranjang.totalItem}'),
                  isLabelVisible: Keranjang.totalItem > 0,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => Halamankeranjang(),) 
                        );
                    },
                    icon: Icon(Icons.shopping_cart)
                    ),
                );
              },
            ),
            )
        ],
      ),
      body: ListView.builder(
        itemCount: produks.length,
        itemBuilder: (context, index) {
          final produk = produks[index];
          return Card(
            child: ListTile(
            title: Text(produk.nama),
            trailing: IconButton(
              onPressed: (){
                Provider.of<Keranjang>(context, listen: false).tambah(produk);
              },
              icon: Icon(Icons.add_shopping_cart)
              ),
          ),
          );
        },
        ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:p6/model/produk.dart';

class Halamankeranjang extends StatelessWidget {
  const Halamankeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: Consumer<Keranjang>(
        builder: (context, keranjang, child) {
          if (keranjang.items.isEmpty){
            return Center(
              child: Text('Keranjang masih kosong'),
            );
          }
          return ListView.builder(
            itemCount: keranjang.items.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(keranjang.items[index].nama),
              ),
            ),
            );
        },
      ),
    );
  }
}