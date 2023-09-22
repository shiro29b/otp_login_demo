import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final void Function() onTapped;
  const CustomElevatedButton(
      {super.key, required this.title, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[600]!, Colors.blue[900]!],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.1, 0.6, 1.8],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent.withOpacity(0.38),
              disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100), // <-- Radius
              ),
              padding: const EdgeInsets.all(12)),
          onPressed: onTapped,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20),
          )),
    );
  }
}
