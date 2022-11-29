import 'package:flutter/material.dart';
import 'package:xpensy/widgets/neumorphic_container.dart';

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
                  SizedBox(
                      height: constraints.maxHeight * 0.08,
                      child: FittedBox(
                          child: Text('Rs${value['amount'].toString()}'))),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.74,
                    width: 25,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        NeumorphicContainer(
                          color: Colors.grey.shade300,
                          borderRadius: 25,
                        ),
                        FractionallySizedBox(
                          heightFactor: getHeight(
                              double.parse(value['amount'].toString())),
                          child: NeumorphicContainer(
                            color: Colors.grey.shade400,
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                      height: constraints.maxHeight * 0.08,
                      child: Text(value['day'].toString()))
                ],
              ),
            );
          }).toList());
    }));
  }
}
