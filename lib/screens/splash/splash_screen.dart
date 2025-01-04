import 'package:flutter/material.dart';
import 'package:food_prime_app/theme/style.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000)).then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColorED6E1B,
      body: Center(
        child: Text(
          "MAED DELIVERY",
          style: TextStyle(
            fontSize: 40, // Adjust font size as needed
            fontWeight: FontWeight.bold,
            color: Colors.white, // Text color white for contrast
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:food_prime_app/theme/style.dart';

// class SplashScreen extends StatefulWidget {
//   final Widget child;
//   const SplashScreen({super.key, required this.child});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 3000)).then((value){
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child), (route) => false);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColorED6E1B,
//       body: Center(
//         child: Image.asset("assets/maed_delivery_splash_screen.png"),
//       ),
//     );
//   }
// }
