import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

abstract class SplashState<T extends StatefulWidget> extends State<T> {
  late ConnectivityResult _connectionStatus;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectAndNavigate();
  }

  Future<void> _checkInternetConnectAndNavigate() async {
    final connectivity = Connectivity();
    _connectionStatus = await connectivity.checkConnectivity();

    if (_connectionStatus == ConnectivityResult.none) {
      _showNoInternetAlertDialog();
    } else {
      _checkAuthenticationAndNavigate();
    }
  }

  Future<void> _checkAuthenticationAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    User? user = _auth.currentUser;
    if (user != null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
    } else {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
    }
  }

  void _showNoInternetAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkInternetConnectAndNavigate();
              },
              child: const Text('Try again later'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
