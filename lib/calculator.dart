import 'package:calculatorapp/app/common/button_view.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<Calculator> {
  var userQuestion = '';
  var result = '';

  final List<String> buttons = [
    'C',
    '+/-',
    '/',
    '<-',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Calculator',
            style: TextStyle(
                fontFamily: "Times New Roman",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        userQuestion,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        result,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
              ),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                        result = '';
                      });
                    },
                  );
                }
                else if (index == 3) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                  );
                }
                else if (index == buttons.length - 1) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        result = calculate();
                      });
                    },
                  );
                }
                else if (index >= 4 && index <= 18) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        if (result.isNotEmpty) {
                          userQuestion = '';
                          result = '';
                        }
                        userQuestion += buttons[index];
                      });
                    },
                  );
                }
                return ButtonsView(
                  buttonText: buttons[index],
                  buttonTapped: () {
                    setState(() {
                      userQuestion += buttons[index];
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String calculate() {
    try {
      var exp = Parser().parse(userQuestion);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      if (evaluation % 1 == 0) {
        return evaluation.toInt().toString();
      }
      return evaluation.toString();
    } catch (e) {
      return "Error!!";
    }
  }
}
