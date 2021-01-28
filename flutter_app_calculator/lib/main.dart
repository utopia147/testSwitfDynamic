import 'package:flutter/material.dart';
import 'package:flutter_app_calculator/calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Claculator claculator = Claculator();
  String x1 = '0';
  String x2 = '';
  String result = '';
  String _operator = '';
  bool checkFloat = false;
  bool plusSwitchMinus = true;

  tapAddNumber(String numberPad) {
    setState(() {
      if (numberPad == '.') {
        checkFloat = true;
        print(checkFloat);
      }
      if (result != '') {
        x1 = '0';
        result = '';
      }
      if (numberPad == '0' && x1 == '0' && numberPad == '.') {
        //do nothing
      } else if (numberPad != 0 && x1 == '0') {
        x1 = numberPad;
      } else {
        x1 += numberPad;
      }
    });
  }

  removeResult() {
    if (x1 == '0') {
      setState(() {
        x2 = '';
        _operator = '';
      });
    } else {
      setState(() {
        if (x1.length > 1) {
          x1 = x1.substring(0, x1.length - 1);
        } else {
          x1 = '0';
        }
      });
    }
  }

  _operatorAdd(_operatorAdd) {
    if (x2 == '' && _operator == '') {
      setState(() {
        _operator = _operatorAdd;
        x2 = x1;
        x1 = '0';
      });
    }
  }

  _plusMinusSign(plusminus) {
    print(plusSwitchMinus);

    setState(() {
      if (x1 == '0') {
      } else {
        if (plusSwitchMinus == true) {
          plusSwitchMinus = false;
          x1 = '-$x1';
        } else if (plusSwitchMinus == false) {
          plusSwitchMinus = true;
          x1 = x1.substring(1, x1.length);
        }
      }
    });
  }

  _clearAll() {
    setState(() {
      x1 = '0';
      x2 = '';
      result = '';
      _operator = '';
    });
  }

  List numberPad = [
    "CE",
    "C",
    "⌫",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "−",
    "1",
    "2",
    "3",
    "+",
    "±",
    "0",
    ".",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (_operator != '' && x2 != '')
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          child: Text(
                            '$x2 $_operator',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Text(
                        '$x1',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white10,
              child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: numberPad.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          print(numberPad[index]);
                          switch (numberPad[index]) {
                            case '⌫':
                              removeResult();
                              break;

                            case '+':
                              _operatorAdd(numberPad[index]);
                              break;
                            case '−':
                              _operatorAdd(numberPad[index]);
                              break;
                            case '×':
                              _operatorAdd(numberPad[index]);
                              break;
                            case '÷':
                              _operatorAdd(numberPad[index]);
                              break;
                            case '±':
                              _plusMinusSign(numberPad[index]);
                              break;
                            case 'C':
                              _clearAll();
                              break;
                            case 'CE':
                              _clearAll();
                              break;
                            case '=':
                              var a1;
                              var a2;
                              if (x2 != '') {
                                if (checkFloat) {
                                  a1 = double.parse(x1);
                                  a2 = double.parse(x2);
                                } else {
                                  a1 = int.parse(x1);
                                  a2 = int.parse(x2);
                                }
                                result = claculator
                                    .sumCalculator(a1, _operator, a2)
                                    .toString();
                                setState(() {
                                  x2 = '';
                                  _operator = '';
                                  x1 = result;
                                });
                              } else {}
                              break;

                            default:
                              tapAddNumber(numberPad[index]);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 25,
                                  child: Text(
                                    numberPad[index],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
