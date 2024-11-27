import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/main_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 194, 127, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Image.asset(
                  "assets/images/Done.png",
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                const Text(
                  "OUR REMINDER",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(
                  height: 200,
                  width: 350,
                  child: Text(
                    "Lorem ipsum odor amet, consectetuer adipiscing elit. Ante ornare tincidunt ut tempus facilisis pretium quisque. liquam turpis porttitor convallis semper nulla urna inceptos vel",
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/register'),
                  child: const MainButton(
                    hasIcon: true,
                    title: "Get Started",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
