import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              title,
              style: GoogleFonts.anton(fontSize: 20, color: const Color.fromARGB(255, 42, 60, 71)),
            ),
          ),
        ),
        const Divider(
            thickness: 3,
            height: 10,
            endIndent: 200,
            color: Color.fromARGB(255, 42, 60, 71))
      ],
    );
  }
}
