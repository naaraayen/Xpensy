import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/transaction.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const Xpensy());
}

// ignore: must_be_immutable
class Xpensy extends StatelessWidget {
  const Xpensy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Transaction(),
        )
      ],
      child: MaterialApp(
        title: 'Xpensy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            colorScheme:
                ColorScheme.fromSwatch(accentColor: Colors.grey.shade300),
            fontFamily: 'OpenSans',        
                
          ),
        home: HomeScreen(),
      ),
    );
  }
}
