// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdex/views/home_screen_view.dart';

// import 'views/home_screen.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
