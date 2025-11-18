import 'package:flutter/material.dart';

class kalkulatorbmi extends StatelessWidget {
  const kalkulatorbmi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TampilankalkulatorBMI(),
    );
  }
}


class TampilankalkulatorBMI extends StatefulWidget {
  const TampilankalkulatorBMI({super.key});

  @override
  State<TampilankalkulatorBMI> createState() => _TampilankalkulatorBMIState();
}

class _TampilankalkulatorBMIState extends State<TampilankalkulatorBMI> {

final _beratcontroller = TextEditingController();
final _tinggicontroller = TextEditingController();

double? _hasil;
String _komentarbmi = "Masukan Nilai";

void hitung(){

final double _berat = double.tryParse(_beratcontroller.text)?? 0;
final double _tinggiInCm = double.tryParse(_tinggicontroller.text)?? 0;

setState(() {

  if(_berat > 0 && _tinggiInCm > 0){

    double _tinggiInM = _tinggiInCm /100;
    double bmi = _berat / ( _tinggiInM* _tinggiInM);
    _hasil = bmi;

    if (bmi < 18.5) {
           _komentarbmi = "Kekurangan berat badan";
        } else if (bmi < 25) {
           _komentarbmi = "Berat badan ideal";
         } else if (bmi < 30) {
           _komentarbmi = "Kelebihan berat badan";
         } else {
          _komentarbmi = "Obesitas";
         }
       } else {
        _hasil = null;
         _komentarbmi = "Masukkan data yang valid";
        }


});

}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _beratcontroller,
              ),
              TextField(
                controller: _tinggicontroller,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: hitung, 
                child: Text("Hitung BMI")
                ),
              SizedBox(height: 30,),
              Text("Hasil"),
              Container(
                child: Column(
                  children: [
                    Text(_hasil?.toStringAsFixed(1)??"--"),
                    Text(_komentarbmi)
                  ],
                ),
              )  
            ],
          ),
        ),

      ),
    );
  }

}



  