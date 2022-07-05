import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BarChart extends StatelessWidget {
  List<Map<String, Object>> groupedTxValues;
  Function getHeight;
  BarChart({Key? key, required this.groupedTxValues, required this.getHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxValues.map((value) {
            return Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Container(
                      height: constraints.maxHeight * 0.08,
                      child: FittedBox(
                          child: Text('Rs${value['amount'].toString()}'))),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.74,
                    width: 25,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        FractionallySizedBox(
                          heightFactor: getHeight(
                              double.parse(value['amount'].toString())),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.08,
                      child: Text(value['day'].toString()))
                ],
              ),
            );
          }).toList());
    }));
  }
}
