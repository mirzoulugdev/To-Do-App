import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final bool hasIcon;
  const MainButton({
    super.key,
    required this.hasIcon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4), // soya yo'nalishi
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(252, 177, 76, 1),
            Color.fromRGBO(216, 96, 91, 1),
          ],
        ),
        color: Colors.red,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 10),
          if (hasIcon)
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30,
            ),
        ],
      ),
    );
  }
}
