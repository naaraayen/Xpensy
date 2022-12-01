import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/splash_screen.dart';
import './provider/transaction.dart';
import './screens/home_screen.dart';

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
      child: Consumer<Transaction>(
        builder: (context, txData, _) => MaterialApp(
            title: 'Xpensy',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              colorScheme:
                  ColorScheme.fromSwatch(accentColor: Colors.grey.shade300),
              fontFamily: 'OpenSans',
            ),
            home: txData.isDataAvailable
                ? HomeScreen()
                : FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 2))
                        .then((_) => txData.retrieveUserData()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      } else {
                        return HomeScreen();
                      }
                    },
                  )),
      ),
    );
  }
}
