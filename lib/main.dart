import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());

}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";
  bool _isOperatorClicked = false;

  void _handleButtonClick(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
        _isOperatorClicked = false;
      }
      else if (value == "gcd") {
        _num2 = double.parse(_output);
        _output = gcd(_num1.toInt(), _num2.toInt()).toString();
        _operator = "";
      }
      else if (value == "=") {
        _num2 = double.parse(_output);
        switch (_operator) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "*":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            if (_num2 != 0) {
              _output = (_num1 / _num2).toString();
            } else {
              _output = "Error";
            }
            break;
        }
        _num1 = 0;
        _num2 = 0;
        _operator = "";
        _isOperatorClicked = false;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (!_isOperatorClicked) {
          _num1 = double.parse(_output);
          _operator = value;
          _isOperatorClicked = true;
        }
      } else if (value == "%") {
        _num1 = double.parse(_output);
        _output = (_num1 / 100).toString();
        _operator = "";
      } else if (value == ".") {
        if (!_output.contains(".")) {
          _output += ".";
        }
      } else if (value == "sqrt") {
        _num1 = double.parse(_output);
        _output = sqrt(_num1).toString();
        _operator = "";
      } else {
        if (_output == "0" || _isOperatorClicked) {
          _output = value;
          _isOperatorClicked = false;
        } else {
          _output += value;
        }
      }
    });
  }

  Widget _buildButton(String value, {Color? color, bool isCircular = false}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _handleButtonClick(value),
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.blueGrey.shade500,
            onPrimary: Colors.white,
            shape: isCircular
                ? CircleBorder()
                : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Calculator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, )),
      ),


      backgroundColor: Colors.white70,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _operator.isEmpty ? "" : "Operator: $_operator",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 25,
            thickness: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("sqrt", color: Colors.brown),
              _buildButton("gcd", color: Colors.brown),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/", color: Colors.brown),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*", color: Colors.brown),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-", color: Colors.brown),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("0"),
              _buildButton("."),
              _buildButton("C"),
              _buildButton("+", color: Colors.brown),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("%", color: Colors.brown),
              _buildButton("=", color: Colors.brown),
            ],
          ),
        ],

      ),
    );
  }
}
int gcd(int a, int b) {
  if (a < b) {
    // Swap the values of a and b if a is smaller than b
    int temp = a;
    a = b;
    b = temp;
  }
  while (b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

