import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';

import '../../../routes/paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false; // Tambahkan variabel isLoading

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 0),
      () {
        // Set isLoading menjadi true ketika timer dimulai
        setState(() {
          isLoading = true;
        });

        // Navigasi ke halaman login setelah beberapa saat
        Timer(
          const Duration(seconds: 2,  microseconds: 5),
          () {
            context.go(Paths.login);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            const Center(
              child: LzImage('logoHomecare.png', size: 150),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 150),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: const LzImage(
                  'glombang.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ).margin(t: 160),
          ],
        ),
      ),
    );
  }
}
