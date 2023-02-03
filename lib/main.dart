import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:xpensy/bloc/transaction_bloc.dart';
import './screens/home_screen.dart';
import './screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const Xpensy());
}

class Xpensy extends StatelessWidget {
  const Xpensy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransactionBloc()),
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
          home: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              return const HomeScreen();
            },
          )),
    );
  }
}
