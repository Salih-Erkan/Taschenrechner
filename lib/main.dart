import 'package:flutter/material.dart';
import 'package:taschenrechner_app/Logik/operationen.dart';

void main() {
  runApp(const TaschenrechnerApp());
}

class TaschenrechnerApp extends StatelessWidget {
  const TaschenrechnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tascherechner App",
      home: TaschenrechnerWidget(),
    );
  }
}

class TaschenrechnerWidget extends StatefulWidget {
  const TaschenrechnerWidget({super.key});

  @override
  State<TaschenrechnerWidget> createState() => TaschenrechnerWidgetState();
}

class TaschenrechnerWidgetState extends State<TaschenrechnerWidget> {

  String _input = "15.0";
  String _output = "15.0";
   
  void btnPressedCallBack(String zeichen){



    switch (zeichen) {
      case "C":
        clearPressed();
        break;
      case "=":
        calculate(_input);
        break;  
      default:
          if(Operationen.isOperator(zeichen)){
          operatorPressed(zeichen);
          }
          else if(Operationen.isDigit(zeichen)){
            numberPressed(zeichen);
          }
          else{
               setState(() {
              _output = "Error";
            });
          }
    }  
  }

  void clearPressed(){
    setState(() {
      _input = "";
      _output = "0";
    });

  }

  void calculate(String input){
    double? ergebnis = Operationen.calculateInputString(_input);

    if(ergebnis == null){
      setState(() {
        _input = "";
        _output = "Error";
      });
    }
    else{
      setState(() {
        _input = ergebnis.toString();
        _output = ergebnis.toString();
      });
    }
  }

  void numberPressed(String number){
    setState(() {
      _input += number;
    });
  }

  void operatorPressed(String operator){
        setState(() {
      _input += " $operator ";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Taschenrechner")),
      body: Column(
        children: [
          Expanded(flex: 2, child: Container(padding: const EdgeInsets.all(16), alignment: Alignment.bottomRight, child: Text(_input, style: const TextStyle(fontSize: 24.0)))),
          Expanded(flex: 1, child: (Container(color: Colors.grey.shade300, alignment: Alignment.center, child: Text(_output, style: const TextStyle(fontSize: 35.0))))),
          Expanded(flex: 4, child: Column(children: [
             NumPadZeile(const ["7","8","9", "/"], btnPressedCallBack),
             NumPadZeile(const ["4","5","6", "X"], btnPressedCallBack),
             NumPadZeile(const ["1","2","3", "-"], btnPressedCallBack),
             NumPadZeile(const ["0","C","=", "+"], btnPressedCallBack),
            ]))
          ]
      )
    );
  }
}


class NumPadZeile extends StatelessWidget {

  final List<String> zeichen;
  final Function(String) btnPressed;

  const NumPadZeile(this.zeichen, this.btnPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
          zeichen.map((symbol) => Expanded(
            child: Container(
              margin: const EdgeInsets.all(4.0),
              color: zeichen.indexOf(symbol) == zeichen.length -1 ? Colors.orange : null,
              child: TextButton(onPressed: (){ btnPressed(symbol);},
              child: Text(symbol, style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: zeichen.indexOf(symbol) == zeichen.length -1 ? FontWeight.bold : null)))
            )
          )).toList()
      ),
    );
  }
}