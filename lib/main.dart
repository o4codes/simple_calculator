import 'package:flutter/material.dart';
import 'models/calculator.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    title: "Calculator",
    theme: ThemeData(
      primaryColorDark: Colors.grey[900],
      primaryColorLight: Colors.grey[300],
      accentColor: Colors.grey[500],
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //user defined variables________________
  var calculate = new Calculator("0", 0);
  List operators = ["+", "-", "*", "/"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator", textScaleFactor: 1.0),
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).primaryColorDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 20.0, left: 20.0),
              color: Theme.of(context).primaryColorDark,
              child: Text("${calculate.result}",
                  textDirection: TextDirection.ltr,
                  textScaleFactor: 4.0,
                  style: TextStyle(color: Colors.grey[100])),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0, left: 20.0),
              child: Text(calculate.operation,
                  textDirection: TextDirection.ltr,
                  textScaleFactor: 2.0,
                  style: TextStyle(color: Colors.grey[100])),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Divider(color: Colors.grey[500]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: cancelButton(
                            "C",
                          )),
                          Expanded(
                              child: numberButton(
                            "7",
                          )),
                          Expanded(
                              child: numberButton(
                            "4",
                          )),
                          Expanded(
                              child: numberButton(
                            "1",
                          )),
                          Expanded(
                            child: functionButton(
                              "GT",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: functionButton("^"),
                          ),
                          Expanded(
                            child: numberButton(
                              "8",
                            ),
                          ),
                          Expanded(
                              child: numberButton(
                            "5",
                          )),
                          Expanded(
                            child: numberButton(
                              "2",
                            ),
                          ),
                          Expanded(
                            child: numberButton(
                              "0",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: functionButton("%"),
                          ),
                          Expanded(
                            child: numberButton(
                              "9",
                            ),
                          ),
                          Expanded(
                            child: numberButton(
                              "6",
                            ),
                          ),
                          Expanded(
                            child: numberButton(
                              "3",
                            ),
                          ),
                          Expanded(
                            child: numberButton(
                              ".",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child: functionButton("/")),
                          Expanded(child: functionButton("*")),
                          Expanded(
                            child: functionButton("-"),
                          ),
                          Expanded(
                            child: functionButton("+"),
                          ),
                          Expanded(child: solveButton("=", () {
                            setState(() {
                              solve(calculate.operation);
                              calculate.operation = "0";
                            });
                          })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container numberButton(String number) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.grey[850]),
        highlightedBorderColor: Colors.deepOrange,
        onPressed: () {
          setState(() {
            setValues(number);
            solve(calculate.operation);
          });
        },
        child: Text(number,
            textScaleFactor: 1.8, style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  Container functionButton(String number) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: FlatButton(
        onPressed: () {
          setState(() {
            setfuntion(number);
          });
        },
        color: Colors.grey[850],
        child: Text(number,
            textScaleFactor: 1.8, style: TextStyle(color: Colors.grey[500])),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  Container cancelButton(String number) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: FlatButton(
        onLongPress: () {
          setState(() {
            calculate.firstNumber = 0;
            calculate.secondNumber = 0;
            calculate.result = 0;
            calculate.operation = "0";
          });
        },
        onPressed: () {
          setState(() {
            backSpace();
          });
        },
        color: Colors.grey[850],
        child: Text(number,
            textScaleFactor: 1.8, style: TextStyle(color: Colors.grey[500])),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  Container solveButton(String number, Function btnAction) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: FlatButton(
        onPressed: btnAction,
        color: Colors.deepOrange,
        child: Text(number,
            textScaleFactor: 1.8, style: TextStyle(color: Colors.grey[500])),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  void setValues(String number) {
    if (calculate.operation == "0") {
      if (number == ".") {
        calculate.operation = "0.";
      } else {
        calculate.operation = number;
      }
    } else {
      calculate.operation = calculate.operation + "$number";
    }
  }

  void setfuntion(String symbol) {
    switch (symbol) {
      case "GT":
        solve(calculate.operation);
        calculate.operation = solve(calculate.operation);
        calculate.result = 0;
        break;

      case "%":
        percent();
        break;

      case "+":
        arithmetric("+");
        break;

      case "-":
        arithmetric("-");
        break;

      case "/":
        arithmetric("/");
        break;

      case "*":
        arithmetric("*");
        break;

      case "^":
        arithmetric("^");
        break;
    }
    
  }

  String solve(String expressions) {
    int lastIndex = expressions.length;
    if (!operators.contains(expressions.substring(lastIndex-1))) {
     Parser p = Parser();
     Expression exp = p.parse(expressions);
     ContextModel cm = ContextModel();
     calculate.result = exp.evaluate(EvaluationType.REAL, cm);
    }

    return calculate.result.toString();
  }

  void percent() {
    bool last = false;
    operators.forEach((element) {
      //last = calculate.operation.endsWith(element) ? true : false;
      if (calculate.operation.contains(element)) {
        last = true;
      }
    });

    if (last == false) {
      calculate.operation =
          (double.parse(calculate.operation) / 100).toString();
    }
  }

  void backSpace() {
    int lastIndex = calculate.operation.length;

    if (lastIndex <= 1) {
      calculate.firstNumber = 0;
      calculate.secondNumber = 0;
      calculate.result = 0;
      calculate.operation = "0";
    } else {
      calculate.operation = calculate.operation.substring(0, lastIndex - 1);
      int length = calculate.operation.length;
      if (!operators.contains(calculate.operation.substring(length - 1))) {
        solve(calculate.operation);
      }
    }
  }

  void arithmetric(String symbol) {
    if (calculate.operation == "0") {
      debugPrint("cannot work");
    } else {
      int length = calculate.operation.length;
      bool last = false;
      operators.forEach((element) {
        //last = calculate.operation.endsWith(element) ? true : false;
        if (calculate.operation.substring(length - 1) == element) {
          last = true;
        }
      });

      if (last == false) {
        calculate.result = double.parse(solve(calculate.operation));
        calculate.operation = calculate.operation + "$symbol";
      } else {
        if (operators.contains(calculate.operation.substring(length - 1))) {
          calculate.result = double.parse(solve(calculate.operation));
          calculate.operation =
              calculate.operation.substring(0, length - 1) + "$symbol";
          // calculate.operation = calculate.operation+"$symbol";
        } else {
          debugPrint("arithmetric position error");
        }
      }
    }
  }
}
