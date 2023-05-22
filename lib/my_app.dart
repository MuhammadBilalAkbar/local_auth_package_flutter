import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const title = 'Local Auth Package Flutter';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 20),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.primary,
            titleTextStyle: const TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: const Size(320, 80),
            ),
          ),
        ),
        home: const HomePage(title: title),
      );
}
