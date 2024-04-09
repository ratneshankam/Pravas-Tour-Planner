import 'package:flutter/material.dart';
import 'src/register.dart';


void main() async {
  runApp(const MainApp());
}

int retriveId = 0;
DateTime? retriveDate = DateTime.now();
int retriveGuest = 0;
class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Register(),
      debugShowCheckedModeBanner: false,
    );
  }
}
