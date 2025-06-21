import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/pages/home.dart';
import 'package:pomart/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (!mounted) return;

    if (username != null) {
      // Usuario ya inició sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHomePage(title: 'PomArt')),
      );
    } else {
      // Usuario no ha iniciado sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 141, 218),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 320,
              height: 320,
            ),
            const SizedBox(height: 10),
            Text(
              'Bienvenido a Pomart',
              style: GoogleFonts.montserrat(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
