import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  //data tranferi olmadıgı için less
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TEMA TARAFI İŞLEM YOK TASARIM DÖNECEK
      debugShowCheckedModeBanner: false, //hata fons
      title: "Calculator",
      theme: ThemeData(primaryColor: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  //data transfer olacagı için top-çık vs ful
  @override
  SimpleCalculatorState createState() => SimpleCalculatorState();
}

class SimpleCalculatorState extends State<SimpleCalculator> {
  //değişkenlerimizi tanımladık ve aşağı tabloda tanımlamamız lazım
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  //buton tıklayınca olsun

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "<-") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = result;
        expression = equation.replaceAll("*", "*");
        expression = equation.replaceAll("/", "/");
        expression = equation.replaceAll("+", "+");
        expression = equation.replaceAll("-", "-");

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget BuildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: buttonColor),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      //color: buttonRenk,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            //ekranı tamamen kapatıyor
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width *
                    0.75, //0.75 katı kadar büyüsün
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        //container kısmını yukarı aldık
                        BuildButton("C", 1, Colors.redAccent),
                        BuildButton("<-", 1, Colors.blue),
                        BuildButton("/", 1, Colors.blue)
                      ],
                    ),
                    TableRow(
                      children: [
                        //container kısmını yukarı aldık
                        BuildButton("7", 1, Colors.blueGrey),
                        BuildButton("8", 1, Colors.blueGrey),
                        BuildButton("9", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        //container kısmını yukarı aldık ve aşağıya buildbuttonu importladmış olduk
                        BuildButton("4", 1, Colors.blueGrey),
                        BuildButton("5", 1, Colors.blueGrey),
                        BuildButton("6", 1, Colors.blueGrey)
                      ],
                    ),
                    TableRow(
                      children: [
                        //container kısmını yukarı aldık
                        BuildButton("3", 1, Colors.blueGrey),
                        BuildButton("2", 1, Colors.blueGrey),
                        BuildButton("1", 1, Colors.blueGrey)
                      ],
                    ),
                    TableRow(
                      children: [
                        //container kısmını yukarı aldık
                        BuildButton(".", 1, Colors.amberAccent),
                        BuildButton("0", 1, Colors.amberAccent),
                        BuildButton("00", 1, Colors.amberAccent)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [BuildButton("*", 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [BuildButton("-", 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [BuildButton("+", 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [BuildButton("=", 2, Colors.blue)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
