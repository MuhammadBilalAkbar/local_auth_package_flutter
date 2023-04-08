import 'package:flutter/material.dart';
import 'package:local_auth_package_flutter/local_auth_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalAuthApi localAuthApi = LocalAuthApi();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await localAuthApi.authenticate();
                },
                child: const Text('Check Availability'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
}
