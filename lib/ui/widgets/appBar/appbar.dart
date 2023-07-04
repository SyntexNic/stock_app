import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    String title = '',
    Color backgroundColor = ColorsApp.primary,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          title: Container(
            margin: const EdgeInsets.only(left: 70),
            child: Text(
              title,
              style: GoogleFonts.getFont(
                'Lato',
              ),
            ),
          ),
        );
}
