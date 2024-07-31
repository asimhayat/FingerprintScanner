import 'package:fingerprintscanner/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintScanner extends StatefulWidget {
  FingerprintScanner({super.key});

  @override
  State<FingerprintScanner> createState() => _FingerprintScannerState();
}

class _FingerprintScannerState extends State<FingerprintScanner> {
  final LocalAuthentication auth = LocalAuthentication();

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
        localizedReason: 'Scan Your Fingerprint',
        // options: AuthenticationOptions(biometricOnly: true),  (IF ONLY WANT BIOMETRIC OPTION)
      );
      if (result) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        print('Permission Denied');
      }
    } else {
      print("No biometric Sensor detected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Login"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                checkAuth();
              },
              child: Text("Authenticate"))
        ],
      ),
    );
  }
}
