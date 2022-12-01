import 'package:flutter/material.dart';
import 'package:xpensy/widgets/neumorphic_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: NeumorphicContainer(
                offset: 4,
                borderRadius: 10,
                blurRadius: 10,
                padding: const EdgeInsets.all(10.0),
                color: Colors.grey.shade300,
                child: Image.asset(
                  'assets/illustrations/app_logo.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Text('XPENSY', style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),)
          ],
        ),
      ),
    );
  }
}
