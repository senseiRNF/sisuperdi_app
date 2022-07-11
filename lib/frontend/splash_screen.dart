import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';
import 'package:sisuperdi_app/frontend/home_screen.dart';
import 'package:sisuperdi_app/frontend/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((result) {
      if(result != null) {
        Future.delayed(const Duration(seconds: 2), () {
          RouteFunctions(context: context).replaceScreen(const HomeScreen());
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          RouteFunctions(context: context).replaceScreen(const LoginScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: Image.asset(
                '${GlobalString.imagePath}/logo-disnakertrans.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            const Text(
              'SISUPERDI',
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'DISNAKERTRANS PROVINSI JAWA TENGAH',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}