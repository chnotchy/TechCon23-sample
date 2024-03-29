import 'package:flutter/material.dart';
import 'package:superellipse/ui/sample_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF30a3f0)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SampleScreen(),
    );
  }
}
