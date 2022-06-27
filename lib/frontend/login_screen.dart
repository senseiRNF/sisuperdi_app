import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';
import 'package:sisuperdi_app/frontend/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      body: SafeArea(
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0,),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      '${GlobalString.imagePath}/logo-disnakertrans.png',
                    ),
                  ),
                  const Text(
                    'SISUPERDI',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      label: const Text(
                        'Username',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      label: const Text(
                        'Password',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0,),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      RouteFunctions(context: context).replaceScreen(const HomeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: GlobalColor.btnColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0,),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
