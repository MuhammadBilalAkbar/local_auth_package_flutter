import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_package_flutter/local_auth_api.dart';

import 'authenticated_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDeviceSupported = false;
  bool canCheckBiometrics = false;
  List<BiometricType> availableBiometrics = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.event_available),
                onPressed: () async {
                  final isAvailable = await LocalAuthApi.isDeviceSupported();
                  final canCheckBiometric =
                      await LocalAuthApi.canCheckBiometrics();
                  setState(() {
                    isDeviceSupported = isAvailable;
                    canCheckBiometrics = canCheckBiometric;
                  });
                  final biometrics = await LocalAuthApi().getBiometrics();
                  debugPrint('biometrics: $biometrics');
                  final hasStrong = biometrics.contains(BiometricType.strong);
                  debugPrint('hasStrong: $hasStrong');
                  final hasWeak = biometrics.contains(BiometricType.weak);
                  debugPrint('hasWeak: $hasWeak');
                  final hasFace = biometrics.contains(BiometricType.face);
                  debugPrint('hasFace: $hasFace');
                  final hasFingerprint =
                      biometrics.contains(BiometricType.fingerprint);
                  debugPrint('hasFingerprint: $hasFingerprint');
                  final hasIris = biometrics.contains(BiometricType.iris);
                  debugPrint('hasIris: $hasIris');

                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Availability'),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          listTile('Biometrics', isAvailable),
                          listTile('Strong', hasStrong),
                          listTile('Weak', hasWeak),
                        ],
                      ),
                    ),
                  );
                },
                label: const Text('Check Availability'),
              ),
              const SizedBox(height: 24),
              Text('isDeviceSupported: $isDeviceSupported'),
              const SizedBox(height: 12),
              Text('canCheckBiometrics: $canCheckBiometrics'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.lock_open),
                onPressed: () async {
                  final isAuthenticated = await LocalAuthApi.authenticate();
                  if (isAuthenticated) {
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthenticatedPage(),
                      ),
                    );
                  }
                },
                label: const Text('Authenticate'),
              ),
            ],
          ),
        ),
      );
}

Container listTile(String text, bool checked) => Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: checked
            ? const Icon(Icons.check, color: Colors.green)
            : const Icon(Icons.close, color: Colors.red),
        title: Text(text),
      ),
    );
