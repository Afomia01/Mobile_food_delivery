import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_prime_app/theme/style.dart';
import 'package:food_prime_app/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:food_prime_app/user_auth/presentation/pages/login_page.dart';
import 'package:food_prime_app/widgets/button_container_widget.dart';
import 'package:food_prime_app/widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _rememberMeCheckValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 140,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormContainerWidget(
                    controller: _usernameController, hintText: "Username"),
                const SizedBox(
                  height: 20,
                ),
                FormContainerWidget(
                    controller: _emailController, hintText: "Email"),
                const SizedBox(
                  height: 20,
                ),
                FormContainerWidget(
                    controller: _passwordController, hintText: "Password"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                      onChanged: (value) {
                        setState(() {
                          _rememberMeCheckValue = value!;
                        });
                      },
                      value: _rememberMeCheckValue,
                    ),
                    Expanded(
                      child: RichText(
                        maxLines: 2,
                        text: const TextSpan(
                          text: "By signing up you accept the ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Team of service ",
                              style: TextStyle(color: primaryColorED6E1B),
                            ),
                            TextSpan(
                              text: "and ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(color: primaryColorED6E1B),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonContainerWidget(
                  title: "Sign Up",
                  onTap: _signUp,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(fontSize: 15),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false);
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 15, color: primaryColorED6E1B),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    
      Navigator.pushNamed(context, '/home');

    }
  }

