import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigationUser.dart';
import 'navigationAdmin.dart';
import 'database/database_review.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[700],
          textTheme: GoogleFonts.interTextTheme(),
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: TextStyle(
              color: (Colors.green[700])!,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: (Colors.green[700])!),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Role());
  }
}

class Role extends StatelessWidget {
  const Role({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png'),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationAdmin()),
                );
              },
              icon: const Icon(
                Icons.person_pin_outlined,
              ),
              label: const Text('Admin'),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.all(18),
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 14)),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationUser()),
                );
              },
              icon: const Icon(
                Icons.group_outlined,
              ),
              label: Text(
                'User',
                style: TextStyle(color: Colors.green[700]),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green[700],
                  padding: const EdgeInsets.all(18),
                  side: BorderSide(color: (Colors.green[700])!)),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    )));
  }
}
